package RADAR::Method::SourceForge::Git;

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
    my $command = "git clone git://$projectname.git.sourceforge.net/gitroot/$projectname/$projectname";
    ApproveCommands
      (
       Commands => [$command],
       Method => "parallel",
      );
    if (-d $projectname) {
      my $quoteddir = shell_quote($projectname);
      ApproveCommands
	(
	 Commands => [
		      "tar czf $projectname.tgz $projectname",
		      "mv $projectname /tmp",
		     ],
	 Method => "parallel",
	);
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

1;

