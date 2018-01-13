# This  program  is  designed  to  search a  collection  of  metasites
# containing  software to find  appropriate software  matching various
# queries

sub search_metasites {
    foreach $query (@_) {
	chomp $query;
	$cgiquery = $query;
	#     $cgiquery =~ s/[^\w\+]+//g;
	$cgiquery =~ s/\s+/+/g;
	print "SAL\n";
	print "mozilla -remote 'OpenURL(http://sal.kachinatech.com/cgi-bin/AT-SALsearch.cgi?config=htdig&restrict=&exclude=&method=and&format=builtin-long&sort=score&words=$cgiquery)'\n";
	system "mozilla -remote 'OpenURL(http://sal.kachinatech.com/cgi-bin/AT-SALsearch.cgi?config=htdig&restrict=&exclude=&method=and&format=builtin-long&sort=score&words=$cgiquery)'";
	$tmp = <>;
	system "mozilla -remote 'OpenURL(http://freshmeat.net/search/?q=$cgiquery&section=projects&x=0&y=0)'";
    }
}

1;
