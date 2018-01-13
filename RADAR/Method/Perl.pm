package RADAR::Method::Perl;

use Data::Dumper;
use Manager::Dialog qw (Approve);
use RADAR::Method::Perl::Module;

use strict;
use Carp;
use CPAN;

use vars qw($VERSION);

$VERSION = '1.00';

use Class::MethodMaker new_with_init => 'new',
  get_set => [ qw / Modules Debug / ];

sub init {
  my ($self,%args) = @_;
  $self->Modules([]);
  $self->Debug(1);
}

sub AddItems {
  my ($self,%args) = @_;
  foreach my $name (@{$args{Items}}) {
    print "Adding module <$name>\n" if $self->Debug;
    $self->AddModule(RADAR::Method::Perl::Module->new(Name => $name));
  }
}

sub AddModule {
  my ($self,$mod) = @_;
  my $mods = $self->Modules;
  push @$mods, $mod;
  $self->Modules($mods);
}

sub Install {
  my ($self,%args) = @_;
  $self->Arm;
  my $aptgetcommand = "sudo apt-get install";
  my $useapt = 0;
  foreach my $mod (@{$self->Modules}) {
    if ($mod->Status eq "apt-get") {
      $useapt = 1;
      $aptgetcommand .= " ".$mod->DebName;
    } elsif ($mod->Status eq "built") {
      $self->QueueCommand("sudo dpkg -i ".$mod->DebLoc);
    }
  }
  if ($useapt) {
    $self->QueueCommand($aptgetcommand);
  }
}

sub Arm {
  my ($self,%args) = @_;
  $self->Status;
  foreach my $mod (@{$self->Modules}) {
    if ($mod->Status eq "apt-get") {
      # nothing
    } elsif ($mod->Status eq "debaux") {
      $self->ModuleToPackage($mod);
    }
  }
}

sub Status {
  my ($self,%args) = @_;
  foreach my $mod (@{$self->Modules}) {
    $self->CheckModule($mod);
    if (defined $mod->Status) {
      if ($mod->Status eq "installed") {
	print "Status: Already installed\n";
      } elsif ($mod->Status eq "built") {
	print "Status: Already built\n";
      } elsif ($mod->Status eq "broken") {
	print "Status: Installation broken\n";
      } elsif ($mod->Status eq "apt-get") {
 	print "Status: Available through apt-get\n";
      } elsif ($mod->Status eq "debaux") {
	print "Status: Available through debaux\n";
      } elsif ($mod->Status eq "not found") {
	print "Status: Not found\n";
      } elsif ($mod->Status eq "unknown") {
	print "Status: Unknown\n";
      }
    } else {
      print "Status: Undef\n";
    }
  }
}

sub PossibleMatches {
  my ($self,%args) = @_;
  # determine whether this looks to be here, return a list of probable matches
  my $query = $args{Query};
  my @matches;
  for my $module (CPAN::Shell->expand("Module","/$query/")) {
    push @matches,$module->id;
  }
  return \@matches;
}

sub Search {
  my ($self,%args) = @_;
  foreach my $mod (@{$self->Modules}) {
    my $name = $mod->Name;
    for my $module (CPAN::Shell->expand("Module","/$name/")) {
      print sprintf("%-40s<%s><%s>\n", $module->id, $module->cpan_file, $module->description || "");
    }
  }
}

sub Remove {
  my ($self,%args) = @_;
  $self->Status;
  foreach my $mod (@{$self->Modules}) {
    if ($mod->Status eq "broken") {
      print "rm -rf /var/tmp/debaux/".$mod->ShortName."\n";
      print "rm -rf /var/tmp/debaux-root/".$mod->ShortName."\n";
      if (Approve()) {
	system "rm -rf /var/tmp/debaux/".$mod->ShortName;
	system "rm -rf /var/tmp/debaux-root/".$mod->ShortName;
      }
    }
  }
}

sub QueueCommand {
  my ($self,$command) = @_;
  print "Command: $command\n";
  if (1 || Approve()) {
    system($command);
    if ($? == -1) {
      print "failed to execute: $!\n";
      return;
    } elsif ($? & 127) {
      printf "child died with signal %d, %s coredump\n",
	($? & 127),  ($? & 128) ? 'with' : 'without';
      return ($? & 127);
    } else {
      printf "child exited with value %d\n", $? >> 8;
      return ($? >> 8);
    }
  }
  return;
}


sub ModuleToPackage {
  my ($self,$mod) = @_;
  $ENV{DEBFULLNAME}="Andrew Dougherty";
  $ENV{DEBEMAIL}="andrewdo\@frdcsa.org";
  my $result = $self->QueueCommand("debaux-build --cpan ".$mod->Name);
  if ($result) {
    $mod->Status("broken");
  } else {
    $mod->Status("built");
  }
  # make sure to get the exact information
  $mod->DebLoc($self->AlreadyBuilt($mod));
}

########################################



sub CheckModule {
  my ($self,$mod) = @_;
  if ($self->NameCompletion($mod)) {
    # check that the module hasn't already been built or installed
    if ($self->AlreadyInstalled($mod)) {
      $mod->Status("installed");
    } elsif ($self->AlreadyBuilt($mod)) {
      $mod->Status("built");
    } elsif ($self->IsBroken($mod)) {
      $mod->Status("broken");
    } elsif ($self->SearchAptCache($mod)) {
      $mod->Status("apt-get");
    } elsif ($self->SearchCPAN($mod)) {
      $mod->Status("debaux");
    } else {
      $mod->Status("unknown");
    }
  } else {
    $mod->Status("not found");
  }
}

sub NameCompletion {
  my ($self,$mod) = @_;
  if ($self->ChooseUnique($mod)) {
    my $module = $mod->Name;
    $module =~ s/::/-/g;
    $module =~ tr/[A-Z]/[a-z]/;
    my $short = "${module}-perl";
    $mod->ShortName($short);
    $mod->DebName("lib${short}");
    return 1;
  }
  return;
}

sub IsBroken {
  my ($self,$mod) = @_;
  # lookup to see if the file exists
  my $lookup = "/var/tmp/debaux/".$mod->ShortName;
  my $result = `ls $lookup 2> /dev/null`;
  chomp $result;
  if ($result =~ /^$/) {
    return 0;
  } else {
    return $result;
  }
  return 0;
}

sub AlreadyInstalled {
  my ($self,$mod) = @_;
  return $mod->uptodate();
}

sub AlreadyBuilt {
  my ($self,$mod) = @_;
  # test for the module
  my $lookup = "/var/tmp/debaux-root/".$mod->ShortName."/".$mod->DebName."*.deb";
  my $result = `ls $lookup 2> /dev/null`;
  chomp $result;
  if ($result =~ /^$/) {
    return 0;
  } else {
    return $result;
  }
}

sub SearchAptCache {
  my ($self,$mod) = @_;
  my $debname = $mod->DebName;
  my $command = "apt-cache search '^${debname}\$'";
  return `$command`;
}

sub SearchCPAN {
  my ($self,$mod) = @_;
  return CPAN::Shell->expand('Module',$mod->Name);
}

sub ChooseUnique {
  my ($self,$mod) = @_;
  my @matches = $self->MatchCPAN($mod);
  if (@matches == 1) {
    $mod->Name($matches[0]);
    return 1;
  } elsif (@matches) {
    print "ambiguous module name.  please select:\n";
    my $i = 1;
    my $antwort;
    foreach my $match (@matches) {
      print $i++.") $match\n";
    }
    while ((defined ($antwort = <STDIN>)) and ($antwort !~ /^[0-9]+$/)) {
      print "please give a number\n";
    }
    chomp $antwort;
    $mod->Name($matches[$antwort - 1]);
    return 1;
  } else {
    print "No matches\n";
    return;
  }
}

sub MatchCPAN {
  my ($self,$mod) = @_;
  my $modname = $mod->Name;
  my $module;
  my @returnlist;
  if (defined ($module = CPAN::Shell->expand("Module","$modname"))) {
    # just return this as an unsound optimization
    push @returnlist, $module->id;
  } else {
    for my $module (CPAN::Shell->expand("Module","/$modname/")) {
      push @returnlist, $module->id;
    }
  }
  return @returnlist;
}

sub Extract {
  my ($self,%args) = @_;
  my @lines;
  while (<>) {
    push @lines, $_ if ($_ =~ /::/ and $_ !~ /-perl/);
  }
  foreach my $line (@lines) {
    $line =~ s/^\s+//;
    $line =~ s/\s+$//;
    $line =~ s/.*?(((::[A-Za-z]+)|([A-Za-z]+::))((::|[A-Za-z])+)).*/$1/;
    print "$line ";
  }
  print "\n";
}

sub Execute {
  my ($self,%args) = @_;
  my $command = $args{Command};
  if ($command =~ /^extract$/i) {
    $self->Extract;
  } else {
    if ($command =~ /^install$/i) {
      $self->Install;
    } elsif ($command =~ /^arm$/i) {
      $self->Arm;
    } elsif ($command =~ /^status$/i) {
      $self->Status;
    } elsif ($command =~ /^search$/i) {
      $self->Search;
    } elsif ($command =~ /^remove$/i) {
      $self->Remove;
    }
  }
}

################################################################################
# Special Purpose Functions

# 
# sub RecDepends {
#   my ($self,%args) = @_;
#   my $output = "sudo apt-get install";
#   my $perlmodule = "([a-zA-Z]+(::[a-zA-Z]+)+)";
#   my $depends = `grep missing dependencies`;
#   foreach $module (split /\n/,$depends) {
#     $module =~ s/^.*?${perlmodule}.*$/$1/;
#     AptSearch($module);
#   }
#   print "$output\n";
# }
# 
# sub AptSearch {
#   my ($self,%args) = @_;
#   $module =~ s/::/-/g;
#   $module =~ tr/[A-Z]/[a-z]/;
#   my $package = "lib${module}-perl";
#   if (`apt-cache search $package`) {
#     $output .= " $package";
#   } else {
#     print "!$package";
#   }
# }

1;
