package RADAR::Method::Perl::Module;

use strict;
use Carp;

use vars qw($VERSION);

$VERSION = '1.00';

use Class::MethodMaker new_with_init => 'new',
  get_set => [ qw / Name DebName Version ShortName DebLoc Status / ];

sub init {
  my ($self,%args) = (shift,@_);
  $self->Name($args{Name});
}

sub uptodate {
  my ($self,%args) = (shift,@_);
  my $mod = CPAN::Shell->expand('Module',$self->Name);
  if ($mod->uptodate) {
    return 1;
  } else {
    return 0;
  }
}

sub print {
  my ($self,%args) = (shift,@_);
  foreach my $method (qw / Name DebName Version ShortName DebLoc Status /) {
    print "$method:\t".$self->$method."\n";
  }
}

1;
