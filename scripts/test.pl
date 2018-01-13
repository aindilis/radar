#!/usr/bin/perl -w

use PerlLib::URIExtractor;

use Data::Dumper;

my $c = `cat /tmp/totext.txt`;

print Dumper(ExtractURIs($c));
