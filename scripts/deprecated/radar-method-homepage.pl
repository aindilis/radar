#!/usr/bin/perl -w

# this is to go ahead and index a system based on its home page.

#use MyFRDCSA;
#use KBFS;

#sub IndexHomePage {
#  my $homepage = shift;
#  return unless URI->validate($homepage);
#  my $project =
#    MyFRDCSA::Project->new(HomePage => KBFS::Cache::URI($homepage));
#}

#accepts a website

my $homepage = $ARGV[0] or die "Homepage not given as arg.";

# find out the following information
# the name of the system

foreach my $field (qw/ Name Version /) {
  print "Enter field: $field\n";
  $data{$field} = <STDIN>;
  chomp $data{$field};
}

$radarincomingdir = "/home/jasayne/frdcsa/source-archives";

my $systemdir = "$radarincomingdir/$data{Name}-$data{Version}";
system "mkdir $systemdir";
system "wget -rl1 -P $systemdir $homepage";

