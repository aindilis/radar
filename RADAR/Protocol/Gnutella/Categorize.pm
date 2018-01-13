package RADAR::Protocol::Gnutella::Categorize;

# The point  of these  functions is  to take all  files on  STDIN, and
# query  the  user  as  to  how  to index  them,  based  on  different
# categories,  for instance: you  might categorize  one file  as being
# windows/academic-software, while  another file  might be put  in the
# library.    The  functions  should   should  handle   the  namespace
# correctly, that is, find-or-create  a unique directory for that file
# and create a control file.

# Among other things it  should propose several possible package names
# using a variety of methods, indicating if they are in use.

sub categories_files {
    foreach (@_) {
	chomp;
	print "<$_>\n";
    }
}

1;
