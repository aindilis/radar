#!/usr/bin/perl -w

use Packager::Rename qw (Normalize);
use Manager::Dialog qw (SubsetSelect);

use WWW::Mechanize;
use Data::Dumper;

sub RetrieveSoftware {
  my ($projectname) = lc(shift);
  my $mech = WWW::Mechanize->new();
  if ($projectname) {
    $mech->get( "http://sourceforge.net/projects/$projectname" );

    # go to files list
    $mech->follow_link( text_regex => qr/files/i,
			n => 1);
    foreach my $link ($mech->links()) {
      if ($link->[0] =~ /\?download$/) {
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
      if ($match =~ /^http:\/\/prdownloads.sourceforge.net\/[^\/]+\/(.*?)\?download$/) {
	my $filename = $1;
	my ($name,$version,$filetype) = GetVersion($filename);
	# print "<$name><$version><$filetype>\n";
	if ($version) {
	  $nameversion->{$name}->{$version} = $filename;
	  if (! defined $nameversion->{$name}->{MAX}) {
	    $nameversion->{$name}->{MAX} = $version;
	  } else {
	    $nameversion->{$name}->{MAX} =
	      VersionGreater
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
    my @todownload = SubsetSelect(Set => [sort keys %{$possible}],
				  Selection => $selection);

    # choose a random mirror
    my @mirrors = qw(
	http://optusnet.dl.sourceforge.net/sourceforge
	http://unc.dl.sourceforge.net/sourceforge
	http://unc.dl.sourceforge.net/sourceforge
	http://belnet.dl.sourceforge.net/sourceforge
	http://belnet.dl.sourceforge.net/sourceforge
	http://heanet.dl.sourceforge.net/sourceforge
	http://internap.dl.sourceforge.net/sourceforge
	http://umn.dl.sourceforge.net/sourceforge
	http://mesh.dl.sourceforge.net/sourceforge
	http://prdownloads.sourceforge.net
    );
    my $mirror = $mirrors[int(rand(scalar @mirrors))];
    foreach my $new (@todownload) {
      my $command = "wget $mirror/$projectname/$new";
      print $command."\n";
    }
  }
}

sub GetVersion {
  my ($filename) = Normalize(shift);
  # my ($filename) = (shift);# Normalize(shift);
  # if ($filename =~ /(.*)-([0-9\.]+?)([^0-9]+)$/) {
  if ($filename =~ /(.*)-([0-9\.]+)/) {
    return ($1,$2,"");
  }
}

sub VersionGreater {
  my ($v1,$v2) = (shift,shift);
  return $v1 cmp $v2;
}

RetrieveSoftware($ARGV[0]);
