package RADAR::Mod::WebSearch::Retrieve;

# I thought there was something that looked much deeper than
# this... use the code similarity search to locate it and have it as
# an option here for even deeper search.

sub Retrieve {
  my ($self,%args) = @_;
  my $result = $args{Result};
  my $url = $args{URL} || $result->Url;
  return [] unless $url !~ /\.(doc|ps|pdf|rtf|txt|ps.gz|ps.Z|ppt)$/i;
  $self->Cacher->get( $url );
  my @links;
  foreach my $link ($self->Cacher->links) {
    my $item = $link->URI->abs->as_string;
    # print "\t$item\n";
    if (
	$item =~
	/\.(tar.z|tar.gz|tar.bz2|tbz2|zip|gz|bz2|tgz|exe|sit|bin|tar|rar|jar|ace|iso|Z)$/i and
	$item !~
	/\.(ps.gz|ps.Z|ps.zip|pdf.gz|pdf.Z|pdf.zip)/i
       ) {
      push @links, $item;
    } else {
      # attempt to give the links a score
      my $thing = $item;
      $thing =~ s/\#.*//;
      my $token = lc([split /\//, $thing]->[-1]);
      # print "$token ";
      if (exists $self->Scores->{$token} and $self->Scores->{$token} > 2.0) {
	# go after this one
	print "getting $item with score ".$self->Scores->{$token}."\n";
	$self->Cacher->get( $item );
	foreach my $link2 ($self->Cacher->links) {
	  my $thing2 = $link2->URI->abs->as_string;
	  # print "$thing2\n";
	  if (
	      $thing2 =~
	      /\.(tar.z|tar.gz|tar.bz2|tbz2|zip|gz|bz2|tgz|exe|sit|bin|tar|rar|jar|ace|iso|Z)$/i and
	      $thing2 !~
	      /\.(ps.gz|ps.Z|ps.zip|pdf.gz|pdf.Z|pdf.zip)/i
	     ) {
	    push @links, $thing2;
	  }
	}
      }
    }
    if ($self->Conf->{'--links'}) {
      if (exists $link->attrs->{title}) {
	push @{$self->AllLinks}, [$url, $link->URI->abs->as_string, $link->attrs->{title}];
      } else {
	push @{$self->AllLinks}, [$url, $link->URI->abs->as_string, ''];
      }
    }
  }
  print Dumper(\@links);
  return {
	  URL => $args{URL} || $result->Url,
	  Summary => $args{URL} || $result->Summary,
	  Links => \@links,
	 };
}

1;
