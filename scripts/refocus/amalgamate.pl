#!/usr/bin/perl -w

use BOSS::Config;

use PerlLib::SwissArmyKnife;

$specification = q(
	-f <file>	File to process
	-e		Export validity file

	-v <file>	Use validity file
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;

my $validity;
if (exists $conf->{'-v'} and -f $conf->{'-v'}) {
  my $c = read_file($conf->{'-v'});
  eval $c;
  $validity = $VAR1;
}

my $all = {};
my $seen = {};
my $succeedprefix = {};
my $failprefix = {};
my $valid = {};
my $codebases = {};
die unless -f $conf->{'-f'};
my $c = read_file($conf->{'-f'});
foreach my $file (split /\n/, $c) {
  # print "<$file>\n";
  if ($file =~ /^.*\/external\/([^\/]+)/) {
    my $codebase = $1;
    $all->{$codebase}{$file} = 1;
    if ($file =~ /^(.+\/external\/$codebase)\b(\/|$)/) {
      my $prefix = $1;
      $seen->{$codebase}{$prefix} = 1;
    }
    if ($file =~ /^(.+\/([^\/]+)\/([^\/]+)\/external\/)/) {
      $succeedprefix->{$2}{$3}{$1} = 1;
      if (exists $conf->{'-v'}) {
	if (exists $validity->{$2}{$3}{$1} and $validity->{$2}{$3}{$1} > 0) {
	  $valid->{$1} = 1;
	  $codebases->{$codebase}{$1} = 1;
	}
      }
    }
  } elsif ($file =~ /^\/([^\/]+)\/([^\/]+)\/external\//) {
    $failprefix->{$1}{$2} = 1;
  }
}

if ($conf->{'-e'}) {
  # print Dumper($succeedprefix);
} elsif ($conf->{'-v'}) {
  print Dumper($codebases);
}

