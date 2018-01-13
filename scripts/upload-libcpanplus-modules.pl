#!/usr/bin/perl -w

foreach my $changesfile (split /\n/, `find ~/.cpanplus/5.8.8/dist | grep -r '\.changes\$'`) {
  my $c = "dput -f -c ~/dput.cf -u local ".$changesfile;
  print "$c\n";
  system $c;
}
system "mini-dinstall --batch";
