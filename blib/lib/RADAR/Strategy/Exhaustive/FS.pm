package RADAR::

# these functions takes a knowledge base of software systems and tries
# to identify  files from  an ftp  site that could  be related  to the
# software systems.

# various features


sub locate_possible_software {
    @projects = cyc-query("isa ?Project ","BaseKB");
    foreach $project (@projects) {
	foreach $file (@files) {
	    # file is in a subdirectory of an author's directory
	    foreach $author ($project->authors()) {
		$file->dir() =~ $author;
		relation($project,$file,
			 "file is in a subdirectory of an author's directory");
	    }
	    # file name approximately matches project name
	    # test
	}
    }
}


# search for  documentation on software  we want, and try  to identify
# acronyms in file listings
