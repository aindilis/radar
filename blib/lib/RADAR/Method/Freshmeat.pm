package RADAR::Method::Freshmeat;

use Manager::Dialog qw
  (Message Choose ApproveCommand ApproveCommands SubsetSelect QueryUser);
use MyFRDCSA qw
  ( Dir ConcatDir );
use Packager::Rename qw
  (Normalize);

use Data::Dumper;
use WWW::Mechanize;

use vars qw($VERSION);
use strict;
use Carp;

$VERSION = '1.00';

use Class::MethodMaker new_with_init => 'new',
  get_set => [ qw / Items Mech FRDCSAHome / ];

sub init {
  my ($self,%args) = (shift,@_);
  $self->Items($args{Items} || []);
  $self->FRDCSAHome(MyFRDCSA::Dir("home"));
}

sub PossibleMatches {
  my ($self,%args) = (shift,@_);
  # determine whether this looks to be here, return a list of probable matches
  my $query = $args{Query};
  if ($self->Mech->get( "http://freshmeat.net/projects/$query/")) {
    return [$query];
  } else {
    return [];
  }
}

sub AddItems {
  my ($self,%args) = (shift,@_);
  $self->Items($args{Items});
  # push @{$self->Items}, @{$args{Items}};
}

sub Execute {
  my ($self,%args) = (shift,@_);
  $self->Mech(WWW::Mechanize->new());
  foreach my $item (@{$self->Items}) {
    $self->RetrieveSoftware($item);
  }
}

sub RetrieveSoftware {
  my ($self,$projectname) = (shift,lc(shift));
  my $mech = $self->Mech;
  if ($projectname) {
    $mech->get( "http://freshmeat.net/projects/$projectname/" );

    my (@matches,%allfiles);
    foreach my $link ($mech->links()) {
      if ($link->[0] =~ /\.(tgz|gz|zip|bz2|exe)$/) {
	push @matches, $link->[0];
      }
    }

    # estimate what are the new releases
    # call each filename with the function that parses out names and versions
    # foreach unique name select the greatest version
    my $nameversion = {};
    my $possible = {};
    my $selection = {};
    foreach my $match (@matches) {
      if ($match !~ /^http:\/\//) {
	$match = "http://freshmeat.net$match";
      }
      if ($match =~ /^http:\/\/?.*\/([^\/]*?)$/) {
	$allfiles{$match} = 1;
	my ($name,$version,$filetype) = $self->GetVersion($1);
	# print "<$name><$version><$filetype>\n";
	if ($version) {
	  $nameversion->{$name}->{$version} = $match;
	  if (! defined $nameversion->{$name}->{MAX}) {
	    $nameversion->{$name}->{MAX} = $version;
	  } else {
	    $nameversion->{$name}->{MAX} =
	      $self->VersionGreater
		($nameversion->{$name}->{MAX},$version)
		  ? $nameversion->{$name}->{MAX} : $version;
	  }
	  $possible->{$match} = [$name,$version];
	}
      } else {
	print "ERROR: $match\n";
      }
    }

    foreach my $name (keys %{$nameversion}) {
      $selection->{$nameversion->{$name}->{$nameversion->{$name}->{MAX}}} = 1;
    }

    # now select
    my @todownload = SubsetSelect(Set => [keys %allfiles],
				  Selection => $selection);

    # now choose the name for this
    my (@p1,@p2);;
    push @p1, "Other";
    push @p2, "Other";
    foreach my $file (@todownload) {
      if ($file =~ /^http:\/\/.*\/(.*?)$/) {
	my ($name,$version,$filetype) = $self->GetVersion($1);
	push @p1, $name;
	push @p2, $version;
      }
    }
    Message(Message => "What is the name of this codebase?");
    my $name = Choose(@p1);
    if ($name eq "Other") {
      $name = QueryUser("Please enter the correct name of this codebase.");
    }
    Message(Message => "What is the version of this codebase?");
    my $version = Choose(@p2);
    if ($version eq "Other") {
      $version = QueryUser("Please enter the correct version of this codebase.");
    }
    my $location = ConcatDir(MyFRDCSA::Dir("external codebases"),"${name}-$version");
    ApproveCommands
      (Method => "parallel",
       Commands => ["mkdir \"".$location."\"",
		    "wget -P \"$location\" ".(join " ", map "\"$_\"", @todownload)]);

    ApproveCommand("packager $name");
  }
}

sub GetVersion {
  my ($self,$filename) = (shift,Normalize(shift));
  # this function needs to be greatly enhanced

  my ($name,$match) = ("","");
  my @ext = qw/tar.gz tgz tar gz jar tar.bz2 bz2 zip/;
  foreach my $e (@ext) {
    if ($filename =~ /^(.*)\.$e$/) {
      if (! $match) {
	$filename = $1;
	$match = $e;
      }
    }
  }

  if ($filename =~ /(.*?)-?([0-9\.]+)/) {
    return ($1,$2,$match);
  } elsif ($filename =~ /^(.*)\.(.*)$/) {
    return ($1,"",$2);
  } else {
    return ($filename,"","");
  }
}

sub VersionGreater {
  my ($self,$v1,$v2) = (shift,shift,shift);
  return $v1 cmp $v2;
}

1;

