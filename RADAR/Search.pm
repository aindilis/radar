package RADAR::Search;

use Manager::Dialog qw ( ChooseSpecial PrintList );
use MyFRDCSA;
use Packager;

use Data::Dumper;
use AI::DecisionTree;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       => [ qw / Tree Items DebugMode ItemsFile Categories
                          Command / ];

sub init {
  my ($self,%args) = @_;
}

sub Execute {
  my ($self,%args) = @_;
  my $conf = $UNIVERSAL::radar->Config->CLIConfig;

  # set the command
  $self->Command("status");
  foreach my $command (qw( remove install arm status search )) {
    if (exists $conf->{$command}) {
      $self->Command($command);
    }
  }

  # execute methods on all items
  $self->Categories
    ({
      "Debian Package" => "Packager",
      "Perl Module" => "RADAR::Method::Perl",
      "CPAN Module (Experimental)" => "RADAR::Method::CPAN",
      "SourceForge" => "RADAR::Method::SourceForge",
      "SourceForge SVN" => "RADAR::Method::SourceForge::SVN",
      "SourceForge CVS" => "RADAR::Method::SourceForge::CVS",
      "Freshmeat" => "RADAR::Method::Freshmeat",
      "Local File" => "Packager",
      "URL" => "RADAR::Method::URL",
      "SVN" => "RADAR::Method::SVN",
      "Git" => "RADAR::Method::Git",
      "CVS" => "RADAR::Method::CVS",
      "Google Code" => "RADAR::Method::GoogleCode",
      # "FTP Site" => "radar",
     });

  $self->LoadItems;
  $self->Tree
    (AI::DecisionTree->new
     (noise_mode => "pick_best"));
  $self->TrainTree;
  # $self->PrintTree;
  $self->ClassifyItems;
}

# sub Test {
#   # try to determine what this is and what are the options
#   # check whether it is included in CPAN, apt-get sources, or whatever
# }

sub LoadItems {
  my ($self,%args) = @_;
  $self->ItemsFile(ConcatDir(Dir("internal codebases"),"radar","data","radar-items.dat"));
  $self->Items({});
  if (-f $self->ItemsFile) {
    my $command = "cat ".$self->ItemsFile;
    $self->Items(eval `$command`);
  }
}

sub RunMethods {
  my ($self,%args) = @_;
  # print Dumper({RunMethodsArgs => \%args});
  my $mod = $self->Categories->{$args{Category}};
  my $require = $mod;
  $require =~ s/::/\//g;
  require "${require}.pm";
  my $method = "$mod"->new();
  my @items = ($args{Item});
  if (exists $args{PD} and $args{PD} ne '') {
    push @items, $args{PSD}, $args{PLD};
  }
  $method->AddItems
    (
     Items => \@items,
    );
  $method->Execute
    (
     PD => $args{PD},
     Command => $self->Command,
     Noninteractively => $args{Noninteractively},
    );
}

sub ClassifyItems {
  my ($self,%args) = @_;
  my $conf = $UNIVERSAL::radar->Config->CLIConfig;
  my $pd = exists $conf->{'--pd'};
  if (defined $conf->{'<items>'}) {

    while (@{$conf->{'<items>'}}) {
      my $item = shift @{$conf->{'<items>'}};
      my ($psd,$pld);
      if ($pd) {
	$psd = shift @{$conf->{'<items>'}};
	$pld = shift @{$conf->{'<items>'}};
      }
      print "<ITEM:$item>\n";
      my @list = keys %{$self->Categories};
      if (scalar keys %{$self->Items}) {
	# my $category = $self->Classify(Item => $item);
	# print "<CATEGORY:$category>\n";
	# unshift @list, $category;
      }
      if (exists $conf->{'-m'}) { # $self->Items->{$item} = $conf->{-m};
	$self->Items->{$item} = $conf->{'-m'};
      } else {
	$self->Items->{$item} = ChooseSpecial(List => \@list,
					      Format => "multiple");
	# 	$self->Tree->add_instance
	# 	  (attributes => $self->GetAttributes(Item => $item),
	# 	   result => $self->Items->{$item});

      }
      # now execute the action for that item
      # print Dumper($item,$self->Items->{$item});
      $self->RunMethods
	(
	 PD => $pd,

	 Item => $item,
	 PSD => $psd,
	 PLD => $pld,

	 Category => $self->Items->{$item},
	 Noninteractively => (exists $conf->{'-y'}),
	);
    }
  }
}


sub TrainTree {
  my ($self,%args) = @_;
  foreach my $key (keys %{$self->Items}) {
    my %hash = %{$self->GetAttributes(Item => $key)};
    if ($self->DebugMode) {
      foreach my $key (keys %hash) {
	print "$key><".$hash{$key}."\n"
      }
      print $self->Items->{$key}."\n";
      print "****************************************\n";
    }
#     $self->Tree->add_instance
#       (attributes => $self->GetAttributes(Item => $key), result => $self->Items->{$key});
  }
}


sub GetAttributes {
  my ($self,%args) = @_;
  my $item = $args{Item};
  my $attributes = {};
  if ($item =~ /^[a-z0-9][a-z0-9+-\.]+$/) {
    $attributes->{"deb-name"} = "yes";
  }
  if ($item =~ /\.deb$/) {
    $attributes->{"deb-tail"} = "yes";
  }
  if ($item =~ /^([A-Za-z0-9]+(::)?)+$/) {
    $attributes->{"perlmod-name"} = "yes";
  }
  if (-f $item) {
    $attributes->{"existing-file"} = "yes";
  }
  if ($item =~ /^((https?|ftp):\/\/)?([A-Za-z0-9-]+(\.)?)+\.(edu|com|org|net|biz|gov|mil|jp|tw|cn|de)$/) {
    $attributes->{"URL"} = "yes";
  }
  if ($item =~ /^(ftp:\/\/)?([A-Za-z0-9-]+(\.)?)+\.(edu|com|org|net|biz|gov|mil|jp|tw|cn|de)$/) {
    $attributes->{"FTP-Site"} = "yes";
  }
  if ($item =~ /^(svn:\/\/)?([A-Za-z0-9-]+(\.)?)+\.(edu|com|org|net|biz|gov|mil|jp|tw|cn|de)$/) {
    $attributes->{"SVN-Site"} = "yes";
  }
  return $attributes;
}

sub Classify {
  my ($self,%args) = @_;
  return $self->Tree->get_result
    (attributes => $self->GetAttributes(Item => $args{Item}));
}

sub PrintTree {
  my ($self,%args) = @_;
  my $OUT = 1;
  open(OUT,">/tmp/temp.ps") or
    die "Cannot open /tmp/temp.ps\n";
  print OUT $self->Tree->as_graphviz->as_ps;
  close OUT;
  system "gv /tmp/temp.ps";
}

sub DESTROY {
  my ($self,%args) = @_;
  # save the newly classified data
  my $OUT;
  open(OUT,">".$self->ItemsFile) or
    die "Cannot open itemsfile for writing.\n";
  print OUT Dumper($self->Items);
  close(OUT);
}

1;
