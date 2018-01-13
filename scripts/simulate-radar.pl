#!/usr/bin/perl -w

my $search = shift;

# determine what this is

# determine what possible items it is based on its name:
foreach my $source (@sources) {
  if ($source->MeetsSyntax($search)) {
    push @passessyntax, $source;
  }
}

# determine whether it is available through each source
foreach my $source (@passessyntax) {
  if ($source->Test($search)) {
    push @insources, $source;
  }
}

# print results and ask the user what to do
foreach my $source (@insources) {
  print $source->SPrint."\n";
}
