package RADAR::Method::GoogleCode;

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
  get_set => [ qw / Items Mech / ];

sub init {
  my ($self,%args) = (shift,@_);
  $self->Items($args{Items} || []);
  $self->Mech(WWW::Mechanize->new);
}

sub AddItems {
  my ($self,%args) = (shift,@_);
  push @{$self->Items}, @{$args{Items}};
}

sub Execute {
  my ($self,%args) = (shift,@_);
  foreach my $item (@{$self->Items}) {
    my $site = "http://code.google.com/p/$item/downloads/list";
    $self->Mech->get($site);
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
	  (Site => $site,
	   URI => $subset);
	$codebase->Execute;
      }
    } else {
      # normal way
      my $codebase = RADAR::Method::CodeBase->new
	(Site => $site,
	 URI => [SubsetSelect(Set => \@matches,
			      Selection => \%selection)]);
      $codebase->Execute;
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
