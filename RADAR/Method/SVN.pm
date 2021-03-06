package RADAR::Method::SVN;

use Manager::Dialog::Record qw (Approve ApproveCommand ApproveCommands Choose
				QueryUser Message);
use MyFRDCSA qw ( Dir ConcatDir );
use RADAR::Method::CodeBase;

use String::ShellQuote;
use URI::URL;

use vars qw($VERSION);
use strict;
use Carp;


$VERSION = '1.00';

use Class::MethodMaker new_with_init => 'new',
  get_set => [ qw / Items / ];

sub init {
  my ($self,%args) = @_;
  $self->Items($args{Items} || []);
}

sub AddItems {
  my ($self,%args) = @_;
  push @{$self->Items}, @{$args{Items}};
}

sub Execute {
  my ($self,%args) = @_;
  # need to obtain the name of the place to put the archive
  foreach my $item (@{$self->Items}) {
    $self->Retrieve(Item => $item);
  }
}

sub Retrieve {
  my ($self,%args) = @_;
  my $item = $args{Item};
  my @possible = ("Other");
  my $url;
  my $branch;
  if ($item =~ /^((svn|ftp|https?):\/\/(.+?)\/(.*)\/)(\s+(.+?))?$/) {
    push @possible, map lc($_), split q{/},$3;
    $url = $1;
    $branch = $6;
  }
  # get the name of this codebase

  Message(Message => "What is the name of this codebase?");
  my $name = Choose(Record => 1, List => \@possible);
  if ($name eq "Other") {
    $name = QueryUser(Contents => "Please enter the correct name of this codebase.");
  }
  @possible = ("Other");
  my $location = ConcatDir(MyFRDCSA::Dir("svn repositories"));
  my $testdir = ConcatDir(MyFRDCSA::Dir("svn repositories"), $name);
  if (! -d $testdir) {
    ApproveCommand
      (Command => "cd ".shell_quote($location)." && svn co ".shell_quote($url).
       (defined $branch ? " ".shell_quote($branch) : ""));
  } else {
    print "Directory already exists: $testdir\n";
    # FIXME check to see if it's the same repo or not
    ApproveCommand
      (Command => "cd ".shell_quote($testdir)." && svn update");
  }
  ApproveCommand(Command => "packager $name");
}

1;
