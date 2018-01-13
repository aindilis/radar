#############################################################################
#
# RADAR::CLI;
# CLI
# Copyright(c) 2004, Andrew John Dougherty (ajd@frdcsa.org)
# Distribute under the GPL
#
############################################################################

package RADAR::CLI;

use BOSS::Config;
use Manager::Dialog qw ( ChooseSpecial PrintList );
use RADAR::Method::Perl;
use RADAR::Method::URL;
use RADAR::Method::SourceForge;
use RADAR::Method::Freshmeat;
use Packager;

use Data::Dumper;
use AI::DecisionTree;

use vars qw/ $VERSION /;
$VERSION = '1.00';

use Class::MethodMaker
  new_with_init => 'new',
  get_set       => [ qw / Config Tree Items DebugMode ItemsFile Categories
                          Command / ];

sub init {
  my ($self,%args) = (shift,@_);
  $self->Command("status");
  $self->ItemsFile($args{ItemsFile});
  $self->LoadItems;
  $specification = q(
	-m <method>	Select methods <methods> (web cpan etc)
	-l		List methods

	search		Issue a query for item in question.
	status		Check the installation status.
	arm		Create a package.
	install		Install
	remove		Remove

	<items>...	Items to be acted upon
  );

  $self->Config(BOSS::Config->new
		(Spec => $specification,
		 ConfFile => "/etc/radar/radar.conf"));
  my $conf = $self->Config->CLIConfig;

  # set the command
  foreach my $command (qw( remove install arm status search )) {
    if (exists $conf->{$command}) {
      $self->Command($command);
    }
  }

  # execute methods on all items
  $self->Categories
    (
     {
      "Debian Package" => Packager->new(),
      "Perl Module" => RADAR::Method::Perl->new(),
      "SourceForge" => RADAR::Method::SourceForge->new(),
      "Freshmeat" => RADAR::Method::Freshmeat->new(),
      "Local File" => Packager->new(),
      "URL" => RADAR::Method::URL->new(),
      "FTP Site" => "radar",
      "Other" => sub {print "OKAY\n"},
     }
    );


  if ($conf->{'-l'}) {
    print Dumper([keys %{$self->Categories}]);
  } else {
    $self->Tree(AI::DecisionTree->new(noise_mode => "pick_best"));
    $self->TrainTree;
    #$self->PrintTree;
    $self->ClassifyItems;
  }
}

sub LoadItems {
  my ($self,%args) = (shift,@_);
  if (-f $self->ItemsFile) {
    my $command = "cat ".$self->ItemsFile;
    $self->Items(eval `$command`);
  } else {
    $self->Items({});
  }
}

sub TrainTree {
  my ($self,%args) = (shift,@_);
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

sub ClassifyItems {
  my ($self,%args) = (shift,@_);
  my $conf = $self->Config->CLIConfig;
  if (defined $conf->{'<items>'}) {
    foreach my $item (@{$conf->{'<items>'}}) {
      print "<ITEM:$item>\n";
      my @list = keys %{$self->Categories};
      if (scalar keys %{$self->Items}) {
	# my $category = $self->Classify(Item => $item);
	# print "<CATEGORY:$category>\n";
	# unshift @list, $category;
      }
      if (exists $conf->{-m}) {
	$self->Items->{$item} = $conf->{-m};
      } else {
	$self->Items->{$item} = ChooseSpecial(List => \@list,
					      Format => "multiple");
# 	$self->Tree->add_instance
# 	  (attributes => $self->GetAttributes(Item => $item),
# 	   result => $self->Items->{$item});
      }
      # now execute the action for that item
      # print Dumper($item,$self->Items->{$item});
      $self->Execute(Item => $item,
		     Category => $self->Items->{$item});
    }
  }
}

sub Classify {
  my ($self,%args) = (shift,@_);
  return $self->Tree->get_result
    (attributes => $self->GetAttributes(Item => $args{Item}));
}

sub GetAttributes {
  my ($self,%args) = (shift,@_);
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
  return $attributes;
}

sub PrintTree {
  my ($self,%args) = (shift,@_);
  my $OUT = 1;
  open(OUT,">/tmp/temp.ps") or
    die "Cannot open /tmp/temp.ps\n";
  print OUT $self->Tree->as_graphviz->as_ps;
  close OUT;
  system "gv /tmp/temp.ps";
}

sub Execute {
  my ($self,%args) = (shift,@_);
  my $method = $self->Categories->{$args{Category}};
  $method->AddItems(Items => [$args{Item}]);
  $method->Execute(Command => $self->Command);
}

sub DESTROY {
  my ($self,%args) = (shift,@_);
  # save the newly classified data
  my $OUT;
  open(OUT,">".$self->ItemsFile) or
    die "Cannot open itemsfile for writing.\n";
  print OUT Dumper($self->Items);
  close(OUT);
}

1;

