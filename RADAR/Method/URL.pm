package RADAR::Method::URL;

use Manager::Dialog qw( QueryUser Choose Message SubsetSelect FamilySelect );
use MyFRDCSA qw ( Dir ConcatDir );
use RADAR::Method::CodeBase;

use Cache::FileCache;
use Data::Dumper;
# use HTML::LinkExtractor;
# use WebFS::FileCopy;
use WWW::Mechanize;
use WWW::Mechanize::Cached;
use URI::URL;

use vars qw($VERSION);
use strict;
use Carp;

$VERSION = '1.00';

use Class::MethodMaker new_with_init => 'new',
  get_set => [ qw / Items FRDCSAHome Mech MyCacher / ];

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
      $class = Choose
	((
	  "Project Information",
	  "Actual Release URL",
	  "Page Containing Downloads of Releases",
	  "MetaSite links to projects",
	  "Starting point to find software using focused crawling"
	 ));
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
      } elsif ($class =~ /Starting point to find software using focused crawling/) {
	my (@matches,%selection);
	@matches = @{$self->Retrieve(URL => $item)};
	foreach my $subset
	  (FamilySelect
	   (
	    Set => \@matches,
	    Selection => {},
	    NoAllowWrap => 1,
	   )) {
	  my $codebase = RADAR::Method::CodeBase->new
	    (Site => $item,
	     URI => $subset);
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

sub Retrieve {
  my ($self,%args) = @_;
  my $result = $args{Result};
  my $seen = {};
  my $scores = {};
  foreach my $line (split /\n/, `cat /var/lib/myfrdcsa/codebases/minor/software-finder/search/la-2/scores.txt`) {
    # 7.10230367827613	download.php	22	33	84
    my ($score,$token) = split(/\t/,$line);
    $scores->{lc($token)} = $score;
  }

  my $url = $args{URL};
  if (! $self->MyCacher) {
    my $cacheobj = new Cache::FileCache
      ({
	namespace => 'radar',
	default_expires_in => "2 years",
	cache_root => "/var/lib/myfrdcsa/codebases/internal/radar/data/FileCache",
       });
    my $timeout = 15;
    $self->MyCacher
      (WWW::Mechanize::Cached->new
       (
	cache => $cacheobj,
	timeout => $timeout,
       ));
  }

  return [] unless $url !~ /\.(doc|ps|pdf|rtf|txt|ps.gz|ps.Z|ppt)$/i;
  $self->MyCacher->get( $url );
  my (@links,@alllinks);
  foreach my $link ($self->MyCacher->links) {
    my $item = $link->URI->abs->as_string;
    print "Item: \t$item\n";
    if (
	$item =~
	/\.(tar.z|tar.gz|tar.bz2|tbz2|zip|gz|bz2|tgz|exe|sit|bin|tar|rar|jar|ace|iso|Z|7z|xz)$/i and
	$item !~
	/\.(ps.gz|ps.Z|ps.zip|pdf.gz|pdf.Z|pdf.zip)/i
       ) {
      next if $seen->{$item};
      $seen->{$item} = 1;
      push @links, $item;
      if (exists $link->attrs->{title}) {
	push @alllinks, [$url, $item, $link->attrs->{title}];
      } else {
	push @alllinks, [$url, $item, ''];
      }
    } else {
      # attempt to give the links a score
      my $thing = $item;
      $thing =~ s/\#.*//;
      my $token = lc([split /\//, $thing]->[-1]);
      # print "$token ";
      if (1) { # exists $scores->{$token} and $scores->{$token} > 0.5) {
	# go after this one
	print "getting $item with score ".$scores->{$token}."\n";
	$self->MyCacher->get( $item );
	foreach my $link2 ($self->MyCacher->links) {
	  my $item2 = $link2->URI->abs->as_string;
	  print "Item2:\t$item2\n";
	  if (
	      $item2 =~
	      /\.(tar.z|tar.gz|tar.bz2|tbz2|zip|gz|bz2|tgz|exe|sit|bin|tar|rar|jar|ace|iso|Z|7z|xz)$/i and
	      $item2 !~
	      /\.(ps.gz|ps.Z|ps.zip|pdf.gz|pdf.Z|pdf.zip)/i
	     ) {
	    next if $seen->{$item2};
	    $seen->{$item2} = 1;
	    push @links, $item2;
	    if (exists $link->attrs->{title}) {
	      push @alllinks, [$url, $item2, $link->attrs->{title}];
	    } else {
	      push @alllinks, [$url, $item2, ''];
	    }
	  }
	}
      }
    }
  }
  return \@links;
}

1;
