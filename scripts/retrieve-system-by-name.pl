#!/usr/bin/perl -w

use BOSS::Config;
use PerlLib::SwissArmyKnife;
use RADAR::Mod::Retrieve;

$specification = q(
	-n <name>		Search for system by this name
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

my $name = $conf->{'-n'};;
die unless $name;
my $retrieve = RADAR::Mod::Retrieve->new(Name => $name);
