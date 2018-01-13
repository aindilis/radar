package RADAR::Method::SVN;

use Manager::Dialog::Record qw (Approve ApproveCommand ApproveCommands Choose
                        QueryUser Message);
use MyFRDCSA qw ( Dir ConcatDir );
use RADAR::Method::CodeBase;

use Data::Dumper;
use URI::URL;

use vars qw($VERSION);
use strict;
use Carp;

$VERSION = '1.00';

use Class::MethodMaker new_with_init => 'new',
  get_set => [ qw / Items FRDCSAHome Mech / ];

sub init {
  my ($self,%args) = @_;
  $self->Items($args{Items} || []);
  $self->FRDCSAHome($args{FRDCSAHome} || "/home/jasayne/frdcsa");
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
  if ($item =~ q|^svn://(.+?)/(.*)$|) {
    push @possible, map lc($_), split q{/},$2;
  }
  # get the name of this codebase

  Message(Message => "What is the name of this codebase?");
  my $name = Choose(Record => 1, List => \@possible);
  if ($name eq "Other") {
    $name = QueryUser(Contents => "Please enter the correct name of this codebase.");
  }
  @possible = ("Other");
  Message(Message => "What is the version of this codebase?");
  my $version = Choose(Record => 1, List => \@possible);
  if ($version eq "Other") {
    $version = QueryUser(Contents => "Please enter the correct version of this codebase.");
  }
  my $location = ConcatDir(MyFRDCSA::Dir("external codebases"),"${name}-$version");
  ApproveCommand
    (Command => "mkdir ".$location. " && cd ".
     $location." && svn co $item");
  ApproveCommand(Command => "packager $name");
}

1;
