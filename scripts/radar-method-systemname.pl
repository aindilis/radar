#!/usr/bin/perl -w

# http://acl.ldc.upenn.edu/hlt-naacl2004/main/pdf/137_Paper.pdf

use Digi::Util::GetAuthors;
use Digi::Util::WgetCache;
use PerlLib::ToText;
use PerlLib::URIExtractor;

use Data::Dumper;

my $getauthors = Digi::Util::GetAuthors->new;
my $wgetcache = Digi::Util::WgetCache->new;
my $totext = PerlLib::ToText->new;

foreach my $pub (@ARGV) {
  # download the file
  my $filename = $wgetcache->GetURI
    (URI => $pub);
  if (-f $filename) {
    # convert to text
    my $txtfile = "$filename.txt";
    print "$txtfile\n";
    my $text = undef;
    if (! -f $txtfile) {
      my $res = $totext->ToText(File => $filename);
      if (defined $res->{Success}) {
	$text = $res->{Text};
	my $OUT;
	open(OUT,">$txtfile") or die "oops!\n";
	print OUT $text;
	close(OUT);
      } else {
	print "Error converting file to text\n";
      }
    } else {
      $text = `cat "$txtfile"`;
    }
    if (defined $text) {
      # extract all URIs
      print Dumper
	({
	  ExtractURIs => ExtractURIs($text),
	  Authors => $getauthors->GetAuthors(Text => $text),
	 });

      # process FTPs using subdomain acquisition, and for possibly LS-ALR

      if (0) {
	# do system-ie extraction on the text
	my $c = "/var/lib/myfrdcsa/codebases/minor/system-ie/extract-systems-from-text.pl \"$txtfile\" 2&>1";
	print $c."\n";
	my $res2 = `$c`;
	print Dumper($res2);
      }

      #  lookup author homepages and ftp sites
      # get the beginning of the text and do named entity recognition
    }
  } else {
    print "Filename <$filename> does not exist\n";
  }
}
