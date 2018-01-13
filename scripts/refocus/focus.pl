#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

use File::Stat;

if (0) {
  my $c = read_file('real-data.txt');
  eval $c;
  my $data = $VAR1;

  my $stats = {};

  foreach my $key (keys %$data) {
    if (! -d "/var/lib/myfrdcsa/codebases/external/$key") {
      print "$key not present\n";
      foreach my $dir (keys %{$data->{$key}}) {
	my $complete = "$dir$key";
	$stats->{$complete} = {
			       size => `du -k -s $complete`,
			       stat => File::Stat->new($complete),
			       dir => $dir,
			       key => $key,
			       complete => $complete,
			      };;
	print Dumper({StatsDir => $stats->{$complete}});
      }
    }
  }
  print Dumper({AllStats => $stats});
}

my $c = read_file('focussed.txt');
eval $c;
my $data = $VAR1->{AllStats};

my $sizes = {};
foreach my $key (keys %$data) {
  my $size = $data->{$key}->{size};
  my $complete = $data->{$key}->{complete};
  if ($size !~ /^(\d+)\s+$complete\s*$/s) {
    # print "$size\n";
  } else {
    # print $1."\n";
    $sizes->{$complete} = $1;
  }
}

my $c = read_file('real-data.txt');
eval $c;
my $data = $VAR1;

my $stats = {};

my $match = {};
foreach my $key (keys %$data) {
  if (! -d "/var/lib/myfrdcsa/codebases/external/$key") {
    # print "$key not present\n";
    foreach my $dir (keys %{$data->{$key}}) {
      my $complete = "$dir$key";
      if ($sizes->{$complete} > 4) {
	if (defined $match->{$key}) {
	  if ($match->{$key}{max} < $sizes->{$complete}) {
	    $match->{$key}{max} = $sizes->{$complete};
	    $match->{$key}{file} = $complete;
	  }
	} else {
	  $match->{$key}{max} = $sizes->{$complete};
	  $match->{$key}{file} = $complete;
	}
      }
    }
  }
}

# print Dumper($match);
my $totalsize = 0;
foreach my $key (keys %$match) {
  my $command = "cp -ar ".$match->{$key}{file}." /var/lib/myfrdcsa/codebases/external/";
  $totalsize += $match->{$key}{max};
  print $match->{$key}{max}."\t".$command."\n";
  if (1) {
    # system $command;
  }
}
print "Totalsize: ".$totalsize."\n";
