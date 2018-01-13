# These functions are designed to  perform a sequence of heuristics to
# find software systems based on name.  A database of software systems
# is  presented and  then this  software does  sophisticated searching
# based on the information in the database.

# these functions should be a command line interface to the radar system

sub google_search {
    foreach $search (@_) {
	chomp($search);
	#$search =~ s/-[0-9.-]+[a-zA-Z]?$//;
	print "(w3m-browse-url \"http://www.google.com/search?hl=en&ie=UTF-8&oe=" .
	    "UTF-8&q=${search}+software+download+site%3Aedu&btnG=Google+" .
	    "Search\")\n";
    }
}

1;


