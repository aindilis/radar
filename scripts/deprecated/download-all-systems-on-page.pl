#!/usr/bin/perl -w

# this script  expects to find on  the page one or  more releases, and
# goes about putting them into the packager archive.

use Manager::Dialog qw ( ApproveCommand );

foreach my $site (@ARGV) {
  my @plausible_types = qw ( zip exe sit tgz gz gz z z tar rar );
  my $command = "wget -rl1 -A".join(',',@plausible_types)." $site";
  ApproveCommand($command);
}
