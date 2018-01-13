#!/usr/bin/perl -w

use Manager::Dialog (Approve);

my $f = $ARGV[0];
my $of = $ARGV[1];
if (-f $f) {
  my $c = `cat "$f"`;
  $c =~ s/\bApprove(\s*)\(/Approve$1\(Contents =\> /g;
  $c =~ s/\bApproveCommand(\s*)\(/ApproveCommand$1\(Command =\> /g;
  $c =~ s/\bChoose(\s*)\(/Choose$1\(List =\> /g;
  # remember we have to manually fix the list in choose
  $c =~ s/\bQueryUser(\s*)\(/QueryUser$1\(Contents =\> /g;
  if (Approve("Write to <$of>?")) {
    my $OUT;
    open(OUT,">$of") or die "Cannot open <$of>\n";
    print OUT $c;
    close(OUT);
  }
}
