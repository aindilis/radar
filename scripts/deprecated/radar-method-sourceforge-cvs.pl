#!/usr/bin/perl -w
use Cvs;

# http://sourceforge.net/project/showfiles.php?group_id=21448

if ($usecvs) {
  my $project = $ARGV[0];
  my $localsourceforge = "/home/jasayne/frdcsa/source-archives";
  system "mkdirhier $localsourceforge/$project";
  my $cvs = new Cvs
    (
     "$localsourceforge/$project",
     cvsroot => ":pserver:anonymous\@cvs.sf.net:/cvsroot/$project",
     password => ""
    ) or die $Cvs::ERROR;
  $cvs->checkout("$project") or die "WTF";
  $cvs->update();
  $cvs->logout();
} elsif ($usepserver) {
  system "echo | cvs -d:pserver:anonymous\@cvs.sf.net:/cvsroot/logicmoo login";
  system "cd $localsourceforge/$project && cvs -d:pserver:anonymous\@cvs.sourceforge.net:/cvsroot/logicmoo co logicmoo";
} else {
  #http://unc.dl.sourceforge.net/sourceforge/emdros/emdros-1.1.18.tar.gz

  use strict;
  use WWW::SourceForge::Project;
  use Data::Dumper;

  foreach my $pname (shift @ARGV) {
    my $proj = WWW::SourceForge::Project->new($pname);
    print Dumper $proj->Member;
  }

  # http://gd.tuwien.ac.at/opsys/linux/sourceforge/f/frd/
  # http://gd.tuwien.ac.at/hci/sf/f/frd/
  # http://gd.tuwien.ac.at/hci/sf/l/largo/
}
