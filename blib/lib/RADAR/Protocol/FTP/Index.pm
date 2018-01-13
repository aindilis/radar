package RADAR::Protocol::FTP::Index;

sub index {
    foreach $it (@_) {
	print "ftp $it -e \"ls -alR; exit\" > /tmp/$it\n";
	system "ftp $it -e \"ls -alR; exit\" > /tmp/$it";
    }
}

1;
