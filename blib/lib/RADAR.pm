package RADAR;

# radar system, to find and install systems

use BOSS::Config;
use RADAR::Search;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       => [ qw / Config Command MySearch / ];

sub init {
  my ($self,%args) = @_;

  $specification = q(
	-m <method>	Select methods <methods> (web cpan etc)

	search		Issue a query for item in question.
	status		Check the installation status.
	arm		Create a package.
	install		Install
	remove		Remove

	<items>...	Items to be acted upon
  );

  $self->Config
    (BOSS::Config->new
     (
      Spec => $specification,
      # ConfFile => "/etc/radar/radar.conf",
     ));


  $self->MySearch
    (RADAR::Search->new());
}

sub Execute {
  my ($self,%args) = @_;
  $self->MySearch->Execute;
}

sub ProcessMessage {
  my ($self,%args) = @_;
  my $m = $args{Message};
  my $it = $m->Contents;
  if ($it) {
    if ($it =~ /^echo\s*(.*)/) {
      $UNIVERSAL::agent->SendContents
	(Contents => $1,
	 Receiver => $m->{Sender});
    } elsif ($it =~ /^(quit|exit)$/i) {
      $UNIVERSAL::agent->Deregister;
      exit(0);
    }
  }
}

1;





