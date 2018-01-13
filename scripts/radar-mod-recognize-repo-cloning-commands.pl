#!/usr/bin/perl -w

use BOSS::Config;
use PerlLib::SwissArmyKnife;
use PerlLib::ToText;

$specification = q(
	-f <file>		File to analyze
);

my $config =
  BOSS::Config->new
  (Spec => $specification);
my $conf = $config->CLIConfig;
# $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

my $URL_REGEX = '((https?|ftp|gopher|telnet|file|notes|ms-help):((//)|(\\\\))+[\w\d:#@%/;$()~_?\+-=\\\.&]*)';


my $totext = PerlLib::ToText->new();

my $regexes =
  {
   hg => qr/\b(hg clone $URL_REGEX)\b/,
   git => qr/\b(git clone $URL_REGEX)\b/,
   svn => qr/\b(svn checkout $URL_REGEX)\b/,
  };

my $fn = $conf->{'-f'};

if (-f $fn) {
  my $text;
  if (0) {
    $text = read_file($fn);
  } else {
    my $res1 = $totext->ToText
      (
       File => $fn,
      );
    if ($res1->{Success}) {
      $text = $res1->{Text};
    }
  }
  if ($text) {
    my $res2 = ProcessText
      (
       Text => $text,
      );
    print Dumper($res2);
  }
}

sub ProcessText {
  my (%args) = @_;
  my $t = $args{Text};
  my $results = {};
  my $indexes = {};
  foreach my $vcs (keys %$regexes) {
    $indexes->{$vcs} = 1;
    my $re = $regexes->{$vcs};
    if ($t =~ /$re/) {
      my ($a,$b,$c,$d,$e,$f,$g) = ($1,$2,$3,$4,$5,$6,$7);
      $results->{$vcs}{$indexes->{$vcs}} = [$a,$b,$c,$d,$e,$f,$g];
      $indexes->{$vcs} = $indexes->{$vcs} + 1;
    }
  }
  return $results;
}
