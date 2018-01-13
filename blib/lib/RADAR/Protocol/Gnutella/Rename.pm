package RADAR::Protocol::Gnutella::Rename;

sub Rename {
  my $list = shift;
  foreach $filename (keys %$list) {
    # function  takes a  string  which  is a  filename  and returns  a
    # possible debian package name
    $_ = $filename;

    chomp;
    # print "<$_>\n";

    s/\([^\)]*\)//g;		# get rid of things in parenthesis
    s/\{[^\}]*\}//g;
    s/^.*\///;

    # pre-encoding mannerisms
    #s/\+\s?key//;

    # encoding
    s/\_+/-/g;
    tr/[A-Z]/[a-z]/;		# downcase
    s/[^A-Za-z0-9-\.\s]//g;	# strip

    # -es
    s/[\s-]+/-/g;		# add -es

    # post-encoding mannerisms
    s/full-w-serial//;
    s/please-?share//;
    s/latest-version//;
    s/tested-and-works-great//;
    s/with-keygens?//;
    s/with-(cd)?key-(inside)?//;
    s/add-ons?//;
    s/with-serial//;
    s/serial//;
    s/full-cd//;
    s/repack//;
    s/appz//;
    s/crack//;
    s/no-activation(-required)?//;
    s/[0-9]+-?(of|to)-?[0-9]+//;
    s/[0-9]+-[0-9]+//;

    # bad suffixes
    # loop until no matches
    $i = 10;
    while ($i) {
      s/try$//;
      s/retail$//;
      s/serial$//;
      s/working$//;
      s/edition$//;
      s/deluxe$//;
      s/keygen$//;
      s/key$//;
      s/-sn$//;
      s/full$//;
      s/final$//;
      s/[0-9]+-?mb$//;
      s/.(ogg|cd[0-9]+.*|wav|bin|doc|txt|avi|mpg|wmv|mpeg|zip|pdf|tgz|gz|tar|exe|rar|ace|iso|mp3)(\.[0-9]+)?$//;
      # get rid of file extensions

      # repair -es
      s/-\./\./g;
      s/\.+/\./g;
      s/\.$//g;
      s/-+/-/g;
      s/^-*//;
      s/-*$//;

      s/and$//;
      s/and-and//;
      --$i;
    }

    s/([^0-9])\./$1-/g;
    s/\.([^0-9])/-$1/g;
    $list->{$filename} = $_;
  }
  return $list;
}

1;
