package RADAR::Method::SourceForge;

use Manager::Dialog qw (Message Choose ApproveCommands SubsetSelect QueryUser);
use MyFRDCSA qw ( Dir ConcatDir );
use Packager::Rename qw (Normalize);
use PerlLib::SwissArmyKnife;
use RADAR::Method::CodeBase;

use Data::Dumper;
use Sort::Versions;
use WWW::Mechanize;

use vars qw($VERSION);
use strict;
use Carp;

$VERSION = '1.00';

use Class::MethodMaker new_with_init => 'new',
  get_set => [ qw / Items Mech FRDCSAHome Debug / ];

sub init {
  my ($self,%args) = (shift,@_);
  $self->Items($args{Items} || []);
  $self->FRDCSAHome(MyFRDCSA::Dir("home"));
  $self->Debug(0);
  See($self->Mech);
}

sub Execute {
  my ($self,%args) = (shift,@_);
  $self->Mech(WWW::Mechanize->new());
  foreach my $item (@{$self->Items}) {
    $self->RetrieveSoftware($item);
  }
}

sub PossibleMatches {
  my ($self,%args) = (shift,@_);
  # determine whether this looks to be here, return a list of probable matches
  my $query = $args{Query};
  See(Query => $query);
  if ($self->Mech->get( "http://sourceforge.net/projects/$query/")) {
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

sub RetrieveSoftware {
  my ($self,$projectname) = (shift,lc(shift));
  my $mech = $self->Mech;
  if ($projectname) {
    $mech->get( "http://sourceforge.net/projects/$projectname/files" );
    # go to files list
    #V1 $mech->follow_link( text_regex => qr/files/i,
    #V1  n => 1);
    print "LINKS\n";
    foreach my $link ($mech->links()) {
      # print '<'.$link->[0].">\n";
      if ($link->[0] =~ /^\/projects\/$projectname\/files\/(.+?)$/) {
	if ($link->[0] !~ /(\?source=navbar|download\?source=files|stats\/timeline)/) {
	  print $link->[0]."\n";
	  push @links, $link->[0];
	}
      }
    }
    die;
    # $mech->follow_link( text_regex => qr/Browse All Files/i,
    # n => 1);
    my (@matches,@allfiles);
    foreach my $link ($mech->links()) {
      if ($link->[0] =~ /downloads\.sourceforge\.net/) {
	print "l1: ".$link->[0]."\n" if $self->Debug;
	push @matches, $link->[0];
      }
    }

    if (! scalar @matches) {
      print "No first level links, checking for second\n";
      my $links = {};
      foreach my $link ($mech->links()) {
	print "l2: ".$link->[0]."\n" if $self->Debug;
	if ($link->[0] =~ q/\/project\/showfiles.php\?group_id=(\d+)\&package_id=(\d+)\&release_id=(\d+)/) {
	  $links->{$link->[0]} = $3;
	}
      }
      foreach my $key (keys %$links) {
	print "key2: $key\n" if $self->Debug;
	$mech->get("http://sourceforge.net".$key);
	foreach my $link ($mech->links()) {
	  print "key2l2: ".$link->[0]."\n" if $self->Debug;
	  if ($link->[0] =~ /downloads\.sourceforge\.net/) {
	    push @matches, $link->[0];
	  } elsif ($link->[0] =~ /\/project\/downloading.php\?group_id=(\d+)\&filename=(.+)$/) {
	    $mech->get("http://sourceforge.net".$link->[0]);
	    # print Dumper([$mech->links]) if $self->Debug;
	    my $matches2 = {};
	    foreach my $la ($mech->links) {
	      if ($la->[0] =~ /http:\/\/(.+?).dl.sourceforge.net\/sourceforge\/(.+)$/) {
		print "DONE: ".$la->[0]."\n" if $self->Debug;
		$matches2->{$la->[0]}++;
	      }
	    }
	    push @matches, keys %$matches2;
	  }
	}
      }
    }

    if (! scalar @matches) {
      print "No second level links, checking for third\n";
      my $links = {};
      foreach my $link ($mech->links()) {
	print "l3: ".$link->[0]."\n" if $self->Debug;
	if ($link->[0] =~ q/\/project\/platformdownload.php\?group_id=(\d+)$/) {
	  $links->{$link->[0]} = 1;
	}
      }
      foreach my $key (keys %$links) {
	$mech->get("http://sourceforge.net".$key);
	my $links = {};
	foreach my $link ($mech->links()) {
	  if ($link->[0] =~ q/\/project\/showfiles.php\?group_id=(\d+)\&package_id=(\d+)\&release_id=(\d+)/) {
	    $links->{$link->[0]} = $3;
	  }
	}
	foreach my $key (keys %$links) {
	  print "key3: $key\n" if $self->Debug;
	  $mech->get("http://sourceforge.net".$key);
	  foreach my $link ($mech->links()) {
	    print "l3a: ".$link->[0]."\n" if $self->Debug;
	    if ($link->[0] =~ /downloads\.sourceforge\.net/) {
	      push @matches, $link->[0];
	    }
	  }
	}
      }
    }

    # estimate what are the new releases
    # call each filename with the function that parses out names and versions
    # foreach unique name select the greatest version
    my $nameversion = {};
    my $possible = {};
    my $selection = {};
    foreach my $match (@matches) {
      #V1 if ($match =~ /^http:\/\/prdownloads.sourceforge.net\/[^\/]+\/(.*?)\?download$/) {
      my $filename;
      if ($match =~ /^http:\/\/downloads.sourceforge.net\/[^\/]+\/(.*?)\?/) {
	$filename = $1;
      } elsif ($match =~ /http:\/\/(.+).dl.sourceforge.net\/sourceforge\/([^\/]+)\/(.+)$/) {
	$filename = $3;
      }
      if ($filename) {
	# http://downloads.sourceforge.net/ossmole/rfProjectIntAud2007-Sep.txt.bz2?modtime=1189029337&big_mirror=0
	push @allfiles, $filename;
	my ($name,$version,$filetype) = RADAR::Method::CodeBase::GetVersion($filename);
	# print "<$name><$version><$filetype>\n";
	if ($version) {
	  $nameversion->{$name}->{$version} = $filename;
	  if (! defined $nameversion->{$name}->{MAX}) {
	    $nameversion->{$name}->{MAX} = $version;
	  } else {
	    $nameversion->{$name}->{MAX} =
	      RADAR::Method::CodeBase::VersionGreater
		  ($nameversion->{$name}->{MAX},$version)
		    ? $nameversion->{$name}->{MAX} : $version;
	  }
	  $possible->{$filename} = [$name,$version];
	}
      } else {
	print "ERROR: $match\n";
      }
    }

    foreach my $name (keys %{$nameversion}) {
      $selection->{$nameversion->{$name}->{$nameversion->{$name}->{MAX}}} = 1;
    }

    # now select
    my @todownload = SubsetSelect(Set => \@allfiles, #[sort keys %{$possible}],
				  Selection => $selection,
				  NoAllowWrap => 1);

    # choose a random mirror
    my @mirrors =
      map {"http://$_.dl.sourceforge.net/sourceforge"}
	qw(ovh jaist optusnet kent easynews puzzle nchc citkit switch
	   heanet mesh superb internap surfnet);
    my @failed = qw(keihanna); 
    my $mirror = $mirrors[int(rand(scalar @mirrors))];
    my @URIs = map "\"$mirror/$projectname/$_\"", @todownload;

    my $cb = RADAR::Method::CodeBase->new
      (Site => "http://sourceforge.net/projects/$projectname",
       URI => \@URIs);
    $cb->Execute;
  }
}

1;

