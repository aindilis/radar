package RADAR::Method::SourceForge::CVS;

use Manager::Dialog qw (Message Choose ApproveCommands SubsetSelect QueryUser);
use MyFRDCSA qw (Dir ConcatDir);
use Packager::Rename qw (Normalize);
use RADAR::Method::CodeBase;

use Data::Dumper;
use Sort::Versions;
use String::ShellQuote;
use WWW::Mechanize;

use Class::MethodMaker new_with_init => 'new',
  get_set =>
  [
   qw / Items Mech FRDCSAHome Debug /
  ];

sub init {
  my ($self,%args) = @_;
  $self->Items($args{Items} || []);
  $self->FRDCSAHome(MyFRDCSA::Dir("home"));
  $self->Debug(0);
}

sub AddItems {
  my ($self,%args) = @_;
  $self->Items($args{Items});
  # push @{$self->Items}, @{$args{Items}};
}

sub Execute {
  my ($self,%args) = @_;
  $self->Mech(WWW::Mechanize->new());
  foreach my $item (@{$self->Items}) {
    $self->RetrieveSoftware($item);
  }
}

sub RetrieveSoftware {
  my ($self,$projectname) = (shift,lc(shift));
  my $mech = $self->Mech;
  if ($projectname) {
    # get this and extract out the possible items for download
    $mech->get("http://$projectname.cvs.sourceforge.net/viewvc/$projectname");
    my @options;
    foreach my $link ($mech->links()) {
      if ($link->URI->abs->as_string =~ /^http:\/\/(.+).cvs.sourceforge.net\/viewvc\/[^\/]+\/([^\?].+)\/$/) {
	push @options, $2;
      }
    }
    my @choices = SubsetSelect
      (
       Set => \@options,
       Selection => {},
      );
    foreach my $choice (@choices) {
      my $command = "cvs -z3 -d:pserver:anonymous\@$projectname.cvs.sourceforge.net:/cvsroot/$projectname checkout -P $choice";
      ApproveCommands
	(
	 Commands => [$command],
	 Method => "parallel",
	);
      if (-d $choice) {
	ApproveCommands
	  (
	   Commands => [
			"tar czf $choice.tgz $choice",
			"mv $choice /tmp",
		       ],
	   Method => "parallel",
	  );
	my $quoteddir = shell_quote("$choice.tgz");
	my $loc = `chase $quoteddir`;
	chomp $loc;
	# now index the directory that was downloaded
	my $cb = RADAR::Method::CodeBase->new
	  (
	   URI => [
		   "file://".$loc,
		  ],
	  );
	$cb->Execute;
      }
    }
  }
}

1;

