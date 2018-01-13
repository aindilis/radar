#!/usr/bin/perl
use WWW::Search;
use strict;
my $oSearch = new WWW::Search('RpmFind');
my $request;
# Create request
while ($request = <>) {
  chomp $request;
  $oSearch->native_query(WWW::Search::escape_query($request));

  print "I find ", $oSearch->approximate_result_count()," elem\n";
  while (my $oResult = $oSearch->next_result()) {
    print "---------------------------------\n",
      "Url    :", $oResult->url,"\n",
	"Title  :", $oResult->title,"\n",
	  "Distrib:", $oResult->description,"\n",
	    "Rpm:", $oResult->source,"\n";
  }
}
