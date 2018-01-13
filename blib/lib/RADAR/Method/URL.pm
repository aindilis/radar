package RADAR::Method::URL;

use Manager::Dialog qw( QueryUser Choose Message SubsetSelect FamilySelect );
use MyFRDCSA qw ( Dir ConcatDir );
use RADAR::Method::CodeBase;

use Data::Dumper;
use WWW::Mechanize;
# use HTML::LinkExtractor;
# use WebFS::FileCopy;
use URI::URL;

use vars qw($VERSION);
use strict;
use Carp;

$VERSION = '1.00';

use Class::MethodMaker new_with_init => 'new',
  get_set => [ qw / Items FRDCSAHome Mech / ];

sub init {
  my ($self,%args) = (shift,@_);
  $self->Items($args{Items} || []);
  $self->FRDCSAHome($args{FRDCSAHome} || "/home/jasayne/frdcsa");
  $self->Mech(WWW::Mechanize->new);
}

sub AddItems {
  my ($self,%args) = (shift,@_);
  push @{$self->Items}, @{$args{Items}};
}

sub Execute {
  my ($self,%args) = (shift,@_);
  foreach my $item (@{$self->Items}) {
    print "<URI>".$item."</URI>\n";
    my $class;
    if (IsURL($item)) {
      Message(Message => $item);
      $class = Choose(("Project Information",
		       "Actual Release URL",
		       "Page Containing Downloads of Releases",
		       "MetaSite links to projects"));
      if ($class =~ /Actual Release URL/) {
	my $codebase = RADAR::Method::CodeBase->new();
	$codebase->AddURIs(URI => [$item]);
	$codebase->Execute;
      } elsif ($class =~ /Page Containing Downloads of Releases/) {
	# take the page and extract  all the notable items, use subset
	# select to determine whether these are appropriate
	$self->Mech->get($item);
	my (@matches,%selection);
	foreach my $link ($self->Mech->links()) {
	  if ($link->tag() eq "a") {
	    my $href = $link->url_abs;
	    push @matches, $href;
	    if ($href =~ /\.(tar.gz|tgz|bz2|gz|z|zip|jar|tar|ps|pdf|README|doc)$/i) {
	      $selection{$href} = 1;
	    }
	  }
	}
	if (1) {
	  # support multiple codebases
	  foreach my $subset
	    (FamilySelect
	     (
	      Set => \@matches,
	      Selection => \%selection,
	      NoAllowWrap => 1,
	     )) {
	    my $codebase = RADAR::Method::CodeBase->new
	      (Site => $item,
	       URI => $subset);
	    $codebase->Execute;
	  }
	} else {
	  # normal way
	  my $codebase = RADAR::Method::CodeBase->new
	    (Site => $item,
	     URI => [SubsetSelect(Set => \@matches,
				  Selection => \%selection)]);
	  $codebase->Execute;
	}
      } else { #(Ftpsite SystemName Capability CapabilityName Humor Thought GnutellaSearch Todo Person InterestingTopic)
	my $systems = ConcatDir(Dir("internal codebases"),"radar","data","systems.dat");
	my $OUT;
	open(OUT,">>$systems") or die "Can't open";
	print OUT "<item>\n\t<class>$class</class>\n\t<url>$item</url>\n</item>\n";
      }
    }
  }
}

sub IsURL {
  my $candidate = shift;
  if ($candidate =~ /\s*^(https?|ftp|file):\/\/\S+/) {
    return 1;
  }
  return 0;
}

sub Extract {
  my ($self,%args) = (shift,@_);
  print "<download-this $args{URL}>\n";
}

1;
