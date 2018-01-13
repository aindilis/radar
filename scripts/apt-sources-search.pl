#!/usr/bin/perl -w

use BOSS::Config;
use PerlLib::SwissArmyKnife;

$specification = q(
	-s <search>		Search sources
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

# search a package name
my $search = $conf->{'-s'};
die "Usage: $0 -s <search>\n" unless defined $search;
my $res = `grep "Package: $search" /var/lib/apt/lists/*`;

print Dumper($res);

