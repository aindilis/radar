#!/usr/bin/perl

# essentially the same thing, except not nearly as good as, as:
# ./packager/scripts/package-lookup-by-description.pl

use Data::Dumper;
use Manager::Dialog qw ( Message );
use PerlLib::Util qw ( LookupSimilar );

# first search for debian packages containing software

use String::Similarity;

Message(Message => "Loading candidates...");
my @candidates = split /\n/, `apt-cache search .`;
Message(Message => "Done.");

if (! @ARGV) {
  print "Usage search-system-descriptions.pl <file>\n
Where file contains descriptions.\n";
  exit(0);
}

my @searches = split /\n/, `cat $ARGV[0]`;

foreach my $line (@searches) {
  chomp $line;
  print "Search: $line\n";
  my @responses =
    LookupSimilar
      (Candidates => \@candidates,
       Query => $line,
       Depth => 50);
  foreach my $response (@responses) {
    $response =~ s/ - .*//;
    print "$response\n";
    push @matches , $response;
  }
  print "\n";
}

foreach my $match (@matches) {
  print "$match ";
}


