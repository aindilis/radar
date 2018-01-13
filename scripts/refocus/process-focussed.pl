#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

my $c = read_file('focussed.txt');
eval $c;
my $data = $VAR1->{AllStats};

foreach my $key (keys %$data) {
  my $size = $data->{$key}->{size};
  my $complete = $data->{$key}->{complete};
  if ($size !~ /^(\d+)\s+$complete\s*$/s) {
    # print "$size\n";
  } else {
    print $1."\n";
  }
}
