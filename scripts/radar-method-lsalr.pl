#!/usr/bin/perl -w

# this  method downloads  an ls-alr  file from  a site  and  does some
# indexing of it

if (0) {
  use Net::FTP;
  use Net::FTP::Recursive;
  use Data::Dumper;

  $ftp = Net::FTP::Recursive->new("$ARGV[0]", Debug => 0);
  $ftp->login("anonymous",'chou_enlai@hotmail.com');
  $ftp->cwd('/pub');
  my $OUT = 0;
  open(OUT,">$ARGV[0]");
  $ftp->rls(Filehandle => \*OUT);
  close OUT;
  $ftp->quit;
} else {
  # start typescript with command, output data to file
  $site = $ARGV[0];
  if ($site) {
    $radarhome = "/home/jasayne/frdcsa/source/radar";
    $file = "$radarhome/var/lib/radar/ftps/$site";
    system 
  } else {
    print "usage: lsalr <site>\n";
  }
}
