package RADAR::Mod::Retrieve;

use PerlLib::SwissArmyKnife;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       =>
  [

   qw /  /

  ];

sub init {
  my ($self,%args) = @_;
}

sub Retrieve {
  my ($self,%args) = @_;
  print Dumper(Systems => $args{Systems});
  if ($args{Systems}) {
    my $query = join(' ',@{$args{Systems}});
    my $command = 'launch-searches.pl -s '.$query;
    ApproveCommands
      (
       Commands => [$command],
       AutoApprove => 1,
      );
  }
}

sub RetrieveReal {
  my ($self,%args) = @_;

  # first we try to normalize the names

  # for every possible match, we determine whether it is installed

  # to determine whether it is installed, first check for an installed package

  # then check dlocate, apt-file results
  # then check locate results

  # if this does not work, then check online.  Search CSO

  # if this does not work, use radar web search without the 'software
  # download' added

  # # probably best is to search and obtain the URI for the item, then
  # # use existing CSA (RADAR/Packager) to package/install

}

1;

# #!/usr/bin/perl -w

# use BOSS::Config;
# use PerlLib::SwissArmyKnife;

# $specification = q(
# 	-n <name>		Search for system by this name
# );

# my $config =
#   BOSS::Config->new
#   (Spec => $specification);
# my $conf = $config->CLIConfig;
# # $UNIVERSAL::systemdir = "/var/lib/myfrdcsa/codebases/minor/system";

# my $commands =
#   {
#    CPAN => {
# 	    search => q{perl -MData::Dumper -MCPAN -e 'print Dumper([CPAN::Shell->expandany("$search")])'},
# 	    parse => q{},
# 	   },
#    PIP => {
# 	   search => q{pip search $qsearch},
# 	   parse => q{},
# 	  },
#    GitHub => {
# 	      search => q{},
# 	      parse => q{},
# 	     },
#    NPM => {
# 	   search => q{},
# 	   parse => q{},
# 	  },
#   };

# # # loaded package types:
# # - dir
# # - gem
# # - deb
# # - npm
# # - rpm
# # - tar
# # - cpan
# # - pear
# # - empty
# # - puppet
# # - python
# # - osxpkg
# # - solaris
# # - p5p
# # - pkgin
# # - freebsd
# # - apk
# # - pacman
# # - pleaserun
# # - sh
# # - virtualenv
# # - zip


# #!/usr/bin/perl -w

# # THIS REALLY BELONGS IN RADAR



# # try to obtain it

# # is it a system package?

# # is it a gem? cpan? cran? etc?

# # is it a github?

# # is it available on a metasite?

# # can we search for and download it?  radar-web-search

# # get it, put it in sandbox.
# # then attempt to.

# my $methods = {
# 	       'SystemPackage' => {},
# 	       'CPAN' => {},
# 	       'CRAN' => {},
# 	       'PIP' => {},
# 	       'GEM' => {},
# 	       'EmacsPackage' => {},
# 	       'Github' => {},
# 	       '' => {},
# 	      };

# my $methodorder = [];
# TryMethod

# # write a query interface, see if someone wrote a software meta site search api
