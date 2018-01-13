#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;

my $virtualdata = read_file('virtual-data.txt');
eval $virtualdata;
$vd = $VAR1;

my $realdata = read_file('real-data.txt');
eval $realdata;
$rd = $VAR1;

my $virtualbutnotreal = {};
foreach my $key (keys %$vd) {
  if (! exists $rd->{$key}) {
    $virtualbutnotreal->{$key} = vd->{$key};
  }
}

print Dumper([sort keys %$virtualbutnotreal]);


# shows that with this data, there is no missing files from the virtual
