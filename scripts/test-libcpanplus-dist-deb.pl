#!/usr/bin/perl -w

use CPANPLUS::Backend;
use CPANPLUS::Dist::Deb;
use Data::Dumper;

my $cb      = CPANPLUS::Backend->new;
my $modobj  = $cb->module_tree($ARGV[0]);

print Dumper($modobj);

### the long way around
print "Fetch\n";
# $modobj->fetch;

print "Extract\n";
$modobj->extract;

print "New\n";
my $deb = CPANPLUS::Dist->new(
			      format  => 'CPANPLUS::Dist::Deb',
			      module  => $modobj,
			     );

print "Prepare\n";
# $bool   = $deb->prepare;

print "Create\n";
$bool   = $deb->create(verbose => 1);	# create a .deb file

print "Install\n";
$bool   = $deb->install(verbose => 1);	# installs the .deb file

print "Status\n";
$where  = $deb->status->dist;		       # from the dist obj
$where  = $modobj->status->dist->status->dist; # from the mod obj


### from the CPANPLUS Default shell
# CPAN Terminal> i --format=CPANPLUS::Dist::Deb Some::Module

### using the commandline tool
# cpan2dist -f CPANPLUS::Dist::Deb Some::Module
