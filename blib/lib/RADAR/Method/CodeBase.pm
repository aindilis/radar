package RADAR::Method::CodeBase;

use Manager::Dialog::Record qw (Approve ApproveCommand ApproveCommands Choose
                        QueryUser Message);
use MyFRDCSA qw ( Dir ConcatDir );
use Packager::Rename qw (Rename Root Normalize);
use PerlLib::SwissArmyKnife;

use File::Basename;
use File::Temp;
use Sort::Versions;

use vars qw($VERSION);
use strict;
use Carp;

$VERSION = '1.00';

use Class::MethodMaker new_with_init => 'new',
  get_set => [ qw / URI Contents FRDCSAHome CodeBaseLocation / ];

sub init {
  my ($self,%args) = @_;
  $self->URI($args{URI} || []);
  $self->FRDCSAHome(MyFRDCSA::Dir("home"));
}

sub GetVersion {
  my ($filename) = (Normalize(shift));
  # this function needs to be greatly enhanced
  my ($name,$match) = ("","");
  my @ext = qw/tar.gz tgz tar gz jar tar.bz2 bz2 zip/;
  if ($filename) {
    foreach my $e (@ext) {
      if ($filename =~ /^(.*)\.$e$/) {
	if (! $match) {
	  $filename = $1;
	  $match = $e;
	}
      }
    }
    if ($filename =~ /(.*?)-?([0-9\.]+)/) {
      return ($1,$2,$match);
    } elsif ($filename =~ /^(.*)\.(.*)$/) {
      return ($1,"",$2);
    } else {
      return ($filename,"","");
    }
  } else {
    return ("","","");
  }
}

sub VersionGreater {
  my ($v1,$v2) = @_;
  return versioncmp($v1,$v2);
}

sub GetURIBasename {
  my ($self,$uri) = @_;
  $uri =~ s|^.*::||;
  return basename($uri);
}

sub Execute {
  my ($self,%args) = @_;
  # my $command = "$mirror/$projectname/$new";
  # now choose the name for this

  my ($p1,$p2);

  my $date = GetDateYYYYMMDD();
  $p2->{$date} = 1;

  foreach my $uri (@{$self->URI}) {
    my ($name,$version,$filetype) = GetVersion
      ($self->GetURIBasename($uri));
    $name =~ s/\.$//;
    $version =~ s/\.$//;
    $p1->{$name}++;
    $p2->{$version}++;
  }

  Message(Message => "What is the name of this codebase?");
  my $name = Choose(Record => 1, List => ["Other", sort keys %$p1]);
  if ($name eq "Other") {
    $name = QueryUser(Contents => "Please enter the correct name of this codebase.");
  }
  Message(Message => "What is the version of this codebase?");
  my $version = Choose(Record => 1, List => ["Other", sort keys %$p2]);
  if ($version eq "Other") {
    $version = QueryUser(Contents => "Please enter the correct version of this codebase.");
  }

  my $location = ConcatDir(MyFRDCSA::Dir("external codebases"),"${name}-$version");

  my @wget;
  my @cp;
  if (Approve(Contents => "Check whether files already exist on server?")) {
    foreach my $uri (@{$self->URI}) {
      my $file = $self->GetURIBasename($uri);
      Message(Message => $file);
      my @matches = split /\n/,`locate -r '/$file\$'`;
      my $flag = 0;
      if (@matches) {
	my @opt = ("Cancel");
	push @opt, @matches;
	my $res = Choose(Record => 1, List => \@opt);
	if ($res eq "Cancel") {
	} else {
	  $flag = 1;
	  push @cp, $res;
	}
      }
      if (!$flag) {
	Message(Message => "no matches");
	push @wget, $uri;
      }
    }
  } else {
    foreach my $uri (@{$self->URI}) {
      if ($uri =~ /^file:\/\/(.+)$/i) {
	push @cp, $1;
      } else {
	push @wget, $uri;
      }
    }
  }
  if (@wget or @cp) {
    my $commands = ["mkdir \"".$location."\""];
    if (@wget) {
      # push @$commands, "wget -P \"$location\" ".(join " ", map {"\"$_\""} @wget);
      push @$commands, "wget --no-check-certificate -P \"$location\" ".(join " ", map {"$_"} @wget);
    }
    if (@cp) {
      push @$commands, "cp -ar ".join(" ",map "\"$_\"",@cp)." \"$location\"";
    }
    if (ApproveCommands
	(Method => "parallel",
	 Commands => $commands)) {
      # now save the FRDCSA file
      my $OUT;
      if (0) {
	open (OUT,">$location/.radar");
	print OUT Dumper($self);
	print OUT Dumper([@wget]);
	print OUT Dumper([@cp]);
      } else {
	open (OUT,">$location/.radar2");
	# information that needs to be here - what site was obtained from
	# maybe choices, but that should go with the new manager editor system
	# need to create a new manager dialog system
	# manager dialog recorder
	print OUT Dumper($self);
	print OUT Dumper([@wget]);
	print OUT Dumper([@cp]);
      }
      close(OUT);
      ApproveCommand(Command => "packager $name");
    }
  }
}

sub AddURIs {
  my ($self,%args) = @_;
  push @{$self->URI}, @{$args{URI}};
}

sub ProcessURI {
  my ($self,%args) = @_;
  my $item = $args{URI};
  print "<URI:".$item.">\n";
  $self->ChooseName(URI => $item);
  ApproveCommand
    (Command => "mkdir ".$self->CodeBaseLocation. " && cd ".
     $self->CodeBaseLocation." && wget -rl1 \"$item\"");
}

sub ChooseName {
  my ($self,%args) = @_;
  my $item = $args{URI};
  my @possible;
  push @possible, "Other";
  $self->GetSite(URI => $item);
  my $title = $self->GetTitle;
  if ($title) {
    push @possible, $title;
  }
  Message(Message => "What is the name of this codebase?");
  my $choice = Choose(Record => 1, List => \@possible);
  if ($choice eq "Other") {
    $choice = QueryUser(Contents => "Please enter the correct name of this codebase.");
  }
  my @list = values %{Packager::Rename::Rename({$choice => 0})};
  $choice = $list[0];
  $self->CodeBaseLocation
    (ConcatDir(MyFRDCSA::Dir("external codebases"),"$choice"));
}

sub GetSite {
  my ($self,%args) = @_;
  my $item = $args{URI};
  my $tmpfile = mktemp("/tmp/radar.XXXXX");
  print "wget " . $item ." -O " . $tmpfile."\n";
  system "wget " . $item ." -O " . $tmpfile;
  my $contents = `cat $tmpfile`;
  $self->Contents($contents);
}

sub GetTitle {
  my ($self,%args) = @_;
  my $stuff = $self->Contents;
  $stuff =~ /<title>(.*)<\/title>/si;
  if ($1) {
    my $title = $1;
    Rename($title);
    my @list = values %{Packager::Rename::Rename({$title => 0})};
    $title = $list[0];
    return $title;
  }
}

1;

