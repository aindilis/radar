#!/usr/bin/perl -w

my $sizes = {};
my $externaldir = "/var/lib/myfrdcsa/codebases/external";
foreach my $file (split /\n/, `ls $externaldir`) {
  my $directory = "$externaldir/$file";
  print "<$directory>\n";
  my $size = `du -k -s $directory`;
  chomp $size;
  if ($size =~ /^(\d+)\s+$directory\s*$/s) {
    $sizes->{$directory} = $1;
  }
}

foreach my $key (sort {$sizes->{$b} <=> $sizes->{$a}} keys %$sizes) {
  print $sizes->{$key}."\t".$key."\n";
}
