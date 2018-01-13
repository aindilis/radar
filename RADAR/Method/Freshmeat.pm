package RADAR::Method::Freshmeat;

use Manager::Dialog qw
  (Message Choose ApproveCommand ApproveCommands SubsetSelect QueryUser);
use MyFRDCSA qw
  ( Dir ConcatDir );
use Packager::Rename qw
  (Normalize);
use PerlLib::SwissArmyKnife;
use RADAR::Util;

use Sort::Versions;
use WWW::Mechanize;

use vars qw($VERSION);
use strict;
use Carp;

$VERSION = '1.00';

use Class::MethodMaker new_with_init => 'new',
  get_set => [ qw /

		    Items Mech FRDCSAHome URLPrefixes Noninteractively

		  / ];

sub init {
  my ($self,%args) = @_;
  $self->Items($args{Items} || []);
  $self->FRDCSAHome(MyFRDCSA::Dir("home"));
  $self->URLPrefixes
    ([
      "http://freshmeat.net/projects",
      "http://freecode.com/projects",
     ]);
}

sub PossibleMatches {
  my ($self,%args) = @_;
  # determine whether this looks to be here, return a list of probable matches
  my $query = $args{Query};
  foreach my $prefix (@{$self->URLPrefixes}) {
    if ($self->Mech->get( "$prefix/$query/")) {
      # have to fix this, but don't know where PossibleMatches is invoked
      return [$query];
    }
  }
  return [];
}

sub AddItems {
  my ($self,%args) = @_;
  $self->Items($args{Items});
  # push @{$self->Items}, @{$args{Items}};
}

sub Execute {
  my ($self,%args) = @_;
  $self->Noninteractively($args{Noninteractively});
  $self->Mech(WWW::Mechanize->new());

  while (@{$self->Items}) {
    my $item = shift @{$self->Items};
    my ($psd,$pld);
    if ($args{PD}) {
      $psd = shift @{$self->Items};
      $pld = shift @{$self->Items};
    }
    $self->RetrieveSoftware($item,$psd,$pld);
  }
}

sub RetrieveSoftware {
  my ($self,$input,$psd,$pld) = (shift,lc(shift),shift,shift);
  my @regexes = (
		 qr/^([^\/]+)$/,
		);
  foreach my $prefix (@{$self->URLPrefixes}) {
    $prefix =~ s/\//\\\//sg;
    push @regexes, qr/^$prefix\/([^\/]+)$/,
  }
  my $res = NormalizeItem
    (
     Item => $input,
     Regexes => \@regexes,
    );
  print Dumper($res);
  return unless $res->{Success};
  my $prefix = "http://freecode.com/projects";
  my $projectname = undef;
  if (exists $res->{Content}{2}) {
    $prefix = $res->{Content}{2};
    $projectname = $res->{Content}{2};
  } else {
    $projectname = $res->{Content}{1};
  }
  my $dn = $prefix;
  if ($dn =~ /^((ht|f)tps?:\/\/[^\/]+)\/.*/) {
    $dn = $1;
  } else {
    warn "cannot get domain name\n";
    return;
  }

  print Dumper({
		Domain => $dn,
		Prefix => $prefix,
		Projectname => $projectname,
	       });

  my $mech = $self->Mech;
  if ($projectname) {
    $mech->get( "$prefix/$projectname/" );
    my (@pages,@matches,%allfiles);
    my $releases = {};
    foreach my $link ($mech->links()) {
      if ($link->[0] =~ /^\/projects\/$projectname\/releases\/(\d+)$/) {
	$releases->{$1} = $link->[0];
      }
    }
    my $release = [sort {$b <=> $a} keys %$releases]->[0];
    $mech->get( $dn.'/'.$releases->{$release} );
    foreach my $link ($mech->links()) {
      if (defined $link and defined $link->[1] and $link->[1] eq 'Download') {
	push @pages, $dn.$link->[0];
      }
    }
    foreach my $match (@pages) {
      $mech->get( $match );
      my $c = $mech->content;
      if ($c =~ /<p>\s*In case it doesn't, click here: <a href="([^"]+)">[^<]+<\/a>/) {
	push @matches, $1;
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
    my @todownload;
    unless ($self->Noninteractively) {
      @todownload = SubsetSelect(Set => [keys %allfiles],
				 Selection => $selection);
    } else {
      @todownload = keys %allfiles;
    }
    # now choose the name for this
    my (@p1,@p2);;
    push @p1, "Other";
    push @p2, "Other";
    # FIXME so that if no real version options are here, add the
    # GetDateYYYYMMDD result
    foreach my $file (@todownload) {
      if ($file =~ /^http:\/\/.*\/(.*?)$/) {
	my ($name,$version,$filetype) = $self->GetVersion($1);
	push @p1, $name;
	push @p2, $version;
      }
    }

    Message(Message => "What is the name of this codebase?");
    my $name;
    unless ($self->Noninteractively) {
      $name = Choose(@p1);
    } else {
      # shift @p1;
      # $name = shift @p1;	# FIXME can we do better?
      $name = $projectname;
    }
    if ($name eq "Other") {
      $name = QueryUser("Please enter the correct name of this codebase.");
    }
    Message(Message => "What is the version of this codebase?");
    my $version;
    unless ($self->Noninteractively) {
      $version = Choose(@p2);
    } else {
      # $version = shift @p2;	# FIXME can we do better?
      shift @p2;
      $version = shift @p2;
      if ($version eq "") {
	$version = GetDateYYYYMMDD();
      }
    }
    if ($version eq "Other") {
      $version = QueryUser("Please enter the correct version of this codebase.");
    }
    my $location = ConcatDir(MyFRDCSA::Dir("external codebases"),"${name}-$version");
    if (-d $location) {
      print "Already exists: $location\n";
    } else {
      ApproveCommands
	(
	 Method => "parallel",
	 Commands => ["mkdir \"".$location."\"",
		      "wget -P \"$location\" ".(join " ", map "\"$_\"", @todownload)],
	 AutoApprove => $self->Noninteractively,
	);
    }
    my $command;
    unless ($self->Noninteractively) {
      $command = "packager $name";
    } else {
      $command = 'packager -y --include-version '.
	"^$projectname\$".' '.shell_quote($version);
    }
    print $command."\n";
    ApproveCommands
      (
       Commands => [
		    $command,
		   ],
       AutoApprove => $self->Noninteractively,
      );
  } else {
    warn "No project found for input <$input>\n";
    return;
  }
  print "RADAR::Method::Freshmeat Done\n";
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
  # return $v1 cmp $v2;
  return versioncmp($v1,$v2);
}

1;

