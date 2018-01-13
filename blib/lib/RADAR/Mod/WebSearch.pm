package RADAR::Mod::WebSearch;

# Deal with conversion to RADAR from software-finder.  use this to
# send urls to to get the results

use BOSS::Config;
use Cache::FileCache;
use Capability::QueryExpansion;
use Capability::Tokenize;
use Manager::Dialog qw(SubsetSelect);
use PerlLib::SwissArmyKnife;

use File::Stat;
use POSIX;
use WWW::Mechanize::Cached;
use Yahoo::Search;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw / CacheObj Cacher Config Conf Scores TimeOut AllLinks Verbose /

  ];

sub init {
  my ($self,%args) = @_;
  $specification = q(
	-l		List existing searches

	-d <depth>	Number or results to include in search
	-i		Include non-html documents
	-D		Include additional search parameters for software download
	-q		Perform query expansion

	-a <stuff>	Additional stuff for the query
	--or		Split the topic into a bunch of tokens ORed together
	-o		Overwrite cached result

	-p		Prompt for download of systems
	--download	Download all the results and store into a place for analysis

	-r		Reduced search

	--links		Do link analysis
	--list-sites	List sites that probably are homepages for software...

	--mt		Multi-threaded search (enabled by default)
	--st		Multi-threaded search

	--brute		Search then get, extract and build all results
	--ul <file>	Just use this url list file instead

	<search>...	Searches to be acted upon
	-t <file>	File containing topics, 1 per line
);

  $self->Config
    (BOSS::Config->new
     (Spec => $specification));
  $self->Conf
    ($self->Config->CLIConfig);
  $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/software-finder";

  $self->TimeOut(15);
  $self->CacheObj
    (Cache::FileCache->new
     ({
       namespace => 'software-finder',
       default_expires_in => "2 years",
       cache_root => "$UNIVERSAL::systemdir/data/FileCache",
      }));
  $self->Cacher
    (WWW::Mechanize::Cached->new
     (
      cache => $self->CacheObj,
      timeout => $self->TimeOut,
     ));
  $self->AllLinks([]);
  $self->Scores({});
  $self->Verbose($args{Verbose} || 0);
}

sub Execute {
  my ($self,%args) = @_;
  if (! exists $self->Conf->{'--st'}) {
    $self->Conf->{'--mt'} = 1;
  }
  if (exists $self->Conf->{'<search>'}) {
    push @topics, @{$self->Conf->{'<search>'}};
  }
  if (exists $self->Conf->{'-t'}) {
    my $file = $self->Conf->{'-t'};
    if (-f $file) {
      my $c = `cat "$file"`;
      push @topics, split /\n/, $c;
    }
  }
  if ($self->Conf->{'--mt'}) {
    $searchdir = "$UNIVERSAL::systemdir/data/mt-searches/";
  } else {
    $searchdir = "$UNIVERSAL::systemdir/data/searches/";
  }
  if ($self->Conf->{'-l'}) {
    foreach my $entry 
      (SubsetSelect
       (Set => [split /\n/, `ls -1 $searchdir`])) {
      $entry =~ s/_/ /g;
      push @topics, $entry;
    }
  }
  foreach my $line (split /\n/, `cat $UNIVERSAL::systemdir/search/la-2/scores.txt`) {
    # 7.10230367827613	download.php	22	33	84
    my ($score,$token) = split(/\t/,$line);
    $self->Scores->{lc($token)} = $score;
  }
  foreach my $topic (@topics) {
    $self->Search
      (
       Topic => $topic,
      );
    if ($self->Conf->{'--links'}) {
      my $OUT;
      open(OUT,">$UNIVERSAL::systemdir/search/link-analysis/alllinks.pl") or die "no alllinks.pl\n";
      print OUT Dumper($self->AllLinks);
      close(OUT);
    }
  }
}

sub Search {
  my ($self,%args) = @_;
  my $topic = $args{Topic};
  return unless $topic;
  my $topic2 = $topic;
  $topic2 =~ s/\s+/_/g;
  $topic2 =~ s/(\w)/\l$1/g;
  my $file = "$UNIVERSAL::systemdir/data/searches/$topic2";
  my $dir = "$UNIVERSAL::systemdir/data/mt-searches/$topic2";
  my $downloaddir = "$UNIVERSAL::systemdir/data/download/$topic2";

  if (-f $file and ! exists $self->Conf->{'-o'}) {

  } else {
    # attempt refinement of the search topic
    mkdir $dir if exists $self->Conf->{'--mt'};
    my $refinement;
    if (exists $self->Conf->{'-r'}) {
      $refinement = `$UNIVERSAL::systemdir/software-name-recognizer/gen-query.pl 20`;
    } else {
      $refinement = `$UNIVERSAL::systemdir/software-name-recognizer/gen-query.pl`;
    }
    my $additional = "";
    if (exists $self->Conf->{'-a'}) {
      $additional .= $self->Conf->{'-a'};
    }
    my $expansion = "";
    if (exists $self->Conf->{'-q'}) {
      print "Performing query expansion of: $topic\n";
      my $h = QueryExpansion(Query => $topic);
      my @sorted = sort {$h->{$b} <=> $h->{$a}} keys %$h;
      $expansion = join(" OR ",splice @sorted,0,20);
      print "EXPANSION: $expansion\n";
    }
    my $mytopic;
    if (exists $self->Conf->{'--or'}) {
      $mytopic = "(".join (" OR ",split /\s+/, tokenize_treebank($topic)).")";
    } else {
      $mytopic = "\"$topic\"";
    }
    my $query = "$mytopic $additional $expansion $refinement";
    print "QUERY: ".$query."\n";
    my $count = $self->Conf->{'-d'} || 100;
    my @Results;
    if (exists $self->Conf->{'--ul'}) {
      my $c = read_file($self->Conf->{'--ul'});
      my $data = DeDumper($c);
      @Results = @$data;
    } else {
      @Results = Yahoo::Search->Results(Doc => $query,
					AppId => "Software-Finder",
					# The following args are optional.
					# (Values shown are package defaults).
					Mode         => 'all', # all words
					Start        => 0,
					Count        => $count,
					Type         => exists $self->Conf->{'-i'} ? 'any' : 'html',
					AllowAdult   => 0, # no porn, please
					AllowSimilar => 0, # no dups, please
					Language     => undef,
				       );
      warn $@ if $@;		# report any errors
    }
    # print Dumper(\@Results);
    my @all;
    my @sites;
    my $actualcount = scalar @Results;
    foreach my $i (0..$#Results) {
      my $amchild = 1;
      if (exists $self->Conf->{'--mt'}) {
	defined($pids[$i] = fork()) or die "Cannot fork()!\n";
	# now what do we want here
	$amchild = ! $pids[$i];
      }
      if ($amchild) {
	my $Result = $Results[$i];
	my $entry;
	if (ref $Result eq "Yahoo::Search::Result") {
	  printf "Result: #%d\n",  $Result->I + 1;
	  printf "Url:%s\n",       $Result->Url;
	  printf "%s\n",           $Result->ClickUrl;
	  printf "Summary: %s\n",  $Result->Summary;
	  printf "Title: %s\n",    $Result->Title;
	  # printf "In Cache: %s\n", $Result->CacheUrl;
	  $entry = $self->Retrieve(Result => $Result);
	} else {
	  $entry = $self->Retrieve(URL => $Result);
	}
	my $url;
	if (exists $self->Conf->{'--ul'}) {
	  $url = $Result;
	} else {
	  $url = $Result->Url;
	}
	my $res = $entry->{Links};
	if (exists $self->Conf->{'--mt'}) {
	  $url =~ s/\W/_/g;
	  if (scalar @$res) {
	    my $OUT;
	    open(OUT,">$dir/$url") or die "can't open\n";
	    print OUT Dumper($entry);
	    close(OUT);
	  } else {
	    system "touch \"$dir/$url\"";
	  }
	  exit(0);
	} else {
	  if (scalar @$res) {
	    push @all, $entry;
	    if (exists $self->Conf->{'--list-sites'}) {
	      push @sites, $url;
	    }
	  }
	}
      }
    }
    my $time = time;

    if (exists $self->Conf->{'--mt'}) {
      my $size;
      my $continue = 1;
      do {
	$size = `ls -1 "$dir" | wc -l`;
	chomp $size;
	sleep 1;
	$continue = ((time - $time) < ($self->TimeOut * 1.5));
      } while ($size < $actualcount and $continue);
      # okay supposedly we are done
      if (! $continue) {
	print "Timeout!\n";
      }
    }

    print "Done!\n";

    if (exists $self->Conf->{'--list-sites'}) {
      print Dumper(\@sites);
      exit(0);
    }

    # now there should be plenty of entries here hopefully
    # now remove all zero size files, concatenate the results, and
    my $result;
    if (exists $self->Conf->{'--mt'}) {
      my $data;
      foreach my $f1 (split /\n/, `ls $dir`) {
	my $stat = File::Stat->new("$dir/$f1");
	if ($stat->size > 0) {
	  my $c = `cat "$dir/$f1"`;
	  push @$data, DeDumper($c);
	}
      }
      $result = Dumper($data);
    } else {
      $result = Dumper(\@all);
    }
    my $OUT;
    open(OUT,">$file") or die "can't open\n";
    print OUT $result;
    close(OUT);
  }

  my $contents = `cat "$file"`;
  print "$contents\n";
  $VAR1 = undef;
  eval $contents;
  my $data = $VAR1;
  $VAR1 = undef;

  if (exists $self->Conf->{'--download'}) {
    # we want to take
    foreach my $entry (@$data) {
      foreach my $link (@{$entry->{Links}}) {
	my $c = "wget -P $downloaddir \"$link\"";
	print "$c\n";
	system $c;
      }
    }
  } elsif ($self->Conf->{'-p'}) {
    foreach my $col 
      (SubsetSelect
       (
	Set => $data,
	Processor => sub {Dumper($_)},
       )) {
      foreach my $item 
	(SubsetSelect
	 (
	  Set => $col->{Links},
	 )) {
	system "radar -m URL \"$item\"";
      }
    }
  }
}

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
	print "getting $item with score ".$self->Scores->{$token}."\n" if $self->Verbose;
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
  print Dumper(\@links) if $self->Verbose;
  return {
	  URL => $args{URL} || $result->Url,
	  Summary => $args{URL} || $result->Summary,
	  Links => \@links,
	 };
}

1;
