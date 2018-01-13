#!/usr/bin/perl -w

use MyFRDCSA;
use Packager::CodeBases;

# given a name, search the existing archives for it

# use syntactic similarity to determine possible matches

sub CheckCSO {
  my (%args) = (@_);
  my $codebases = Packager::CodeBases->new(Location => Dir("external codebases"));
  my $codebase = $codebases->SearchCodeBases(Regex => $args{Name});
  if ($codebase) {
    print "Codebase found\n";
  } else {
    print "No codebase found\n";
  }
}

sub CheckInstalled {
  
}

sub CheckApt {

}

sub CheckGoogle {

}

my $name = shift;
CheckCSO(Name => $name);
