package RADAR::Util;

require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(NormalizeItem);

use Data::Dumper;

sub NormalizeItem {
  my (%args) = @_;
  foreach my $regex (@{$args{Regexes}}) {
    print Dumper
      ({
	Regex => $regex,
	Item => $args{Item},
       }) if $args{Debug};
    my $content = {};
    if ($args{Item} =~ $regex) {
      if (defined $1) {
	$content->{1} = $1;
      }
      if (defined $2) {
	$content->{2} = $2;
      }
      return {
	      Success => 1,
	      Content => $content,
	     };
    }
  }
  return {
	  Success => 0,
	 };
}

1;
