package RADAR::Strategy;

use Manager::Dialog qw( QueryUser Choose Message );

sub MostWantedPackages {
  # The Most Wanted Packages are automatically computed from FRDCSA goals.
}

sub PackagesInProgress {

}

sub CompletedPackages {

}

sub AddStrategy { }

sub RemoveStategy { }

sub AdaptStrategy { }

sub QueryStrategies { }

1;

=head1

  The retrieval strategist  manages the strategies that we  can use to
  locate  software.   This  is  governed by  general  strategies,  and
  specific strategies.  The user is able to select a general strategy,
  and then planning is handled through the PSE component.

=cut

# this specifies all  the various properties of actions,  and so makes
# them  easier to reason  about, than  had they  been hard  coded into
# various functions
