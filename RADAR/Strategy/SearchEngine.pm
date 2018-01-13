package RADAR::Strategy::SearchEngine;

use WWW::Search;
use MyFRDCSA qw ( Dir ConcatDir );
use Spider::Classifier;

use vars qw/ $VERSION /;
$VERSION = '1.00';
use Class::MethodMaker
  new_with_init => 'new',
  get_set       => [ qw / Classifier / ];

sub init {
  my ($self,%args) = (shift,@_);
  $self->Classifier
    (Spider::Classifier->new
     (WebKBLocation =>
      ConcatDir(MyFRDCSA::Dir("internal codebases"),
		"spider","webkb")));
}

sub Query {
  my ($self,@terms) = (shift,@_);
  my @urls;
  my $oSearch = new WWW::Search('Yahoo');
  my $sQuery = WWW::Search::escape_query(join '+', @terms);
  $oSearch->native_query($sQuery);
  while (my $oResult = $oSearch->next_result()) {
    #print $oResult->url, "\n";
    push @urls, $oResult->url;
  }
  my $url, $result;
  do {
    $url = pop @urls;
    $result = $self->Classifier->Classify(URI => $url);
    print "<$result>";
  } while ($result ne "Project");
  OpenURLInBrowser($url);
}

sub OpenURLInBrowser {
  print "<<<".$_.">>>\n";
}

1;

# this online  algorithm finds systems  by either name or  keywords by
# query expansion  and classification and  returns a list  of matching
# software systems

# for     instance    "radar     search     ivia"    should     return
# http://infomine.ucr.edu/iVia/ at the time of this writing.
