#!/usr/bin/perl -w

my $dir = @ARGV;		# directory of extracted codebase
foreach my $file (split /\n/,`find $dir`) {
  print "<$file>";
}
