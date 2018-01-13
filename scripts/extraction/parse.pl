#!/usr/bin/perl -w

# program to parse out program descriptions, authors, etc from program lists

$doc = "";
while (<>) {
    $doc .= $_;
}

@li = ($doc =~ /(<li>.*?<\/li>).*?/gs);

foreach $p (@li) {
    if ($p =~ /<\/a>/) {
	($tit,$des) = ($p =~ /<a href=[^>]+>([^<]+)<\/a>:?\s*(.*)\s*<br>/s);
    } else {
	($tit,$des) = ($p =~ /^<li>\s*([^:]+):\s*(.*)\s*<br>/);
    }
    $tit =~ tr/A-Z/a-z/;
    $des =~ s/\n//;
    $des =~ s/\s+/ /g;
    if (defined $tit) {
	print "Package: $tit\n" if defined $tit;    
	print "Priority: optional\n";
	print "Section: artificial intelligence\n";
	print "Installed-Size: 144\n";
	($aut) = ($p =~ /\((.*?)\)/s);
	$aut =~ s/\n//;
	$aut =~ s/\s+/ /g;
	print "Maintainer: $aut\n" if defined $aut;
	print "Architecture: i386\n";
	print "Version: 1.0.0-1\n";
	print "Depends: libc6 (>= 2.2.4-4)\n";
	print "Filename: pool/main/${tit}_1.0.0-1_i386.deb\n";
	($web) = ($p =~ /\"(http:\/\/\S*)\"/);
	print "URL: $web\n" if defined $web;
	print "Size: 10241024\n";
	print "MD5sum: 03cdc2c944551aa3ecdd0d3979071e77\n";
	print "Description: $des\n" if defined $des;    
	print " $des\n" if defined $des;
	print "\n";
    }
}
