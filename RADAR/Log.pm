package RADAR::Log;

use FileHandle;
use File::Spec;

use vars qw/ $VERSION /;
$VERSION = '1.00';
use Class::MethodMaker
  new_with_init => 'new',
  get_set       => [ qw / LogFile LogHandle / ];

sub init {
  my ($self, %args) = (shift, @_);

  $self->ChooseLogFile or
    die "No valid log file found.\n";
  my $HI;
  open($HI,">>".$self->LogFile->Name) or 
    die "Cannot open Log File ".$self->LogFile->Name."\n";
  $HI->autoflush(1);
  $self->LogHandle($HI);
}

sub ChooseLogFile {
  my ($self, %args) = (shift, @_);
  my ($logfile, $file, $dontquit);
  my @files = (
	       $self->LogFile,
	       $self->get_conf->{LogFile},
	       "/var/lib/pse",
	       "/home/jasayne/.pse",
	       "/tmp",
	      );

  $dontquit = 1;
  while ($dontquit) {
    $file = undef;
    while (@files && ! defined $file) {
      $file = shift @files
    }
    if (defined $file) {
      $logfile = UniLang::Util::LogFile->new($file);
      if ($self->TryLog($logfile)) {
	$self->LogFile($logfile);
	print "Using logfile: ".$self->LogFile->Name."\n";
	return $self->LogFile;
      }
    } else {
      $dontquit = 0;
    }
  }
  return;
}

sub TryLog {
  my ($self, $logfile) = (shift, shift);
  return unless $logfile;

  # test if it is a directory
  if ($logfile->Directory) {
    if ($logfile->Writable) {
      return $self->FindOrCreateValidLog($logfile);
    }
  } elsif ($logfile->Writable) {
    if ($self->ValidLog($logfile)) {
      return 1;
    } else {
      return $self->FindOrCreateValidLog($logfile->DirName);
    }
  }
  return;
}

sub FindOrCreateValidLog {
  my ($self, $logfile) = (shift, shift);
  # in a directory, choose a valid logfile and return true
  $logfile->Name(File::Spec->catpath('',$logfile->Name,"pse.log"));
  return $self->ValidLog($logfile);
}

sub ValidLog {
  my ($self, $logfile) = (shift, shift);
  if ($logfile->Exists && ! $logfile->Writable) { # check that it exists and is writable

  } else {
    if ($logfile->Validate) {
      $self->LogFile($logfile);
      return 1;
    }
  }
  return;
}

sub Commit {
  my ($self, $message) = (shift, shift);
  my $H = $self->LogHandle;
  # print $message->Generate;
  print $H $message->Generate
}

1;
