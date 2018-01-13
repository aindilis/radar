#!/usr/bin/perl -w

use BOSS::Config;
use PerlLib::SwissArmyKnife;

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

# my $retrieve = RADAR::Mod::Retrieve->new(Name => $name);
my $command = 'apt-cache madison '.shell_quote($name);
my $res1 = `$command`;

# print Dumper({Res1 => $res1});

foreach my $line (split /\n/, $res1) {
  my @res = map {StripSurroundingWhiteSpace($_)} split /\|/, $line;
  my ($packagename,$version,$source) = @res;
  # check package names
  print Dumper
    ({
      PackageName => $packagename,
      Version => $version,
      Source => $source,
     });
}

sub StripSurroundingWhiteSpace {
  my ($item) = @_;
  $item =~ s/^\s*//sg;
  $item =~ s/\s*$//sg;
  return $item;
}
