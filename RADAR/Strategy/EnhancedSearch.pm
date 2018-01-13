package EnhancedSearch;

sub search {
    foreach $search (@_) {
	$search =~ s/-[0-9.-]+[a-zA-Z]?$//;
	print "(w3m-browse-url \"http://www.google.com/search?hl=en&ie=UTF-8&oe=" .
	    "UTF-8&q=${search}+software+download+site%3Aedu&btnG=Google+" .
	    "Search\")\n";
	# get the urls until they stop go on to the next one
	do {
	    $input = <>;
	    if ($input =~ /./) {
		chomp $input;
		chdir "/home/chou/debs/wanted/$dir";
		print "<downloading: $input\n>\n";
		system "wget $input &";
	    }
	} while ($input =~ /./);
    }
}

1;


=head1

#ala ./www.neci.nec.com/%7Elawrence/papers/cs-cikm99/cs-cikm99.ps
#===============================================================================#
# This function searches google  using remote control  of a  browser for        #
# user provided keywords and generated  keywords that have a tendency to        #
# produce webpages  that contain links  to quality software.   It speeds        #
# discovery of  applications which would  be associated with  the user's        #
# keywords.								        #
#===============================================================================#

=cut
