# radar
Rapid Application Discovery And Retrieval

<system>
  <title>RADAR</title>
  <acronym-expansion>
    Rapid Application Discovery And Retrieval
  </acronym-expansion>
  <short-description>
  </short-description>
  <medium-description>
    RADAR is  a catch-all system  for creating ontologies  of software
    systems  from web sources.   It is  responsible for  modelling the
    state   of  various  online   software,  and   uses  sophisticated
    heuristics for  retrieval.  Just as  an example, it  estimates the
    stability  (future availability)  of the  software  in determining
    whether to  retrieve it to ration storage  and bandwidth capacity,
    and uses  previous release timing to prioritize  link checking and
    reindexing  of already indexed  codebases.  It  has many  modes of
    operation (spidering, request brokering), and we have not yet been
    able to  come up with  a formal model  of these behaviours,  or to
    diagram  the architecture  effectively.  The  list of  features is
    also  very  extensive  and,  as  we  do not  yet  have  a  working
    capabilities  management  system  at   time  of  writing,  is  not
    compiled.  Shortly,  we expect to list  its features automatically
    on the FRDCSA website.
  </medium-description>
  <long-description>
    <p>
      The  goal   of  the  FRDCSA  is  to   maximize  problem  solving
      capabilities in a formal sense.  Without reference to a specific
      logic,  one can simply  think in  terms of  computing functions.
      From  this abstract  perspective it  is possible  to demonstrate
      that the complexity  of the function must grow  in proportion to
      the   complexity  of   the   problem  it   purports  to   solve.
      Traditionally,   complexity   is   measured  using   Kolomogorov
      complexity.   There are  several  kinds of  problems, those  for
      which a  computable function  is a solution,  those for  which a
      solution exists  but is not  computable, and those for  which no
      solution exists.   From a practical  point of view,  although no
      program exists  which can  compute arbitrary functions,  using a
      sequence of increasingly complex programs we can approximate any
      function with  increasing coverage and  accuracy.  Although some
      would say  this is not  "interesting", we can however  use these
      improved  approximations  to  reconsider and  potentially  solve
      outstanding problems of undisputed importance.
    </p>
    <p>
      Much depends,  of course, on  the availability of  software, and
      the  integration  of  this  software  into  mainstream  software
      distributions  like Debian  GNU/Linux  and FreeBSD,  as well  as
      public awareness.
    </p>
    <p>
      Now a  brief explanation of the role  of artificial intelligence
      in computer science is necessary.   AI is to CS as Philosophy of
      Science is to Science.  That  is, it is simply a designation for
      currently  unsolved problems  in  the field.   Therefore when  a
      problem is solved, for instance  chess, it no longer is "chess",
      rather  it becomes  "parallel  brute force  negamax search  with
      alpha-beta pruning".
    </p>
    <p>
      Software which  implements desired capabilities  must be located
      and  incorporated.   A  thorough  study  of  available  software
      systems indicates that there is  a great deal of useful software
      that  simply has not  been incorporated  into the  public domain
      distributions.  A quick look  around reveals a tremendous amount
      of substance, yet interrelation  could be improved.  I.e., there
      exists a lot of free or potentially free software, yet as of yet
      there does not appear to exist a popular and thoroughly complete
      map of this software.
    </p>
    <p>
      The  goal   of  the  RADAR  project,  which   stands  for  Rapid
      Application Detection and Retrieval,  is to create this thorough
      map using  various techniques.   Therefore RADAR is  an advanced
      tool  which employs  several methods  to locate  existing online
      codebases and extract ontological information from web pages and
      online documentation.  These  ontological relations include some
      that associate codebases with authors, documentation, licensing,
      releases,  capabilities and so  on.  In  practice we  have found
      that  a number  of strategies  employed simulatenously  have the
      greatest  benefit.   (I.e.  focused  crawling  of project  sites
      (iVia,  WebKB, Rainbow,  Spider, WebSphinx,  etc), automatically
      mapping  of web  site  content (Minorthird,  MnM, Melita,  Gate,
      Alembic, etc.)   to ontology management  systems (Kaon, Protege,
      Cyc,  Powerloom.   In  addition  to spidering,  we  use  various
      methods in online search  engines, like query expansion, keyword
      lists,  search templates,  etc.  to  identify online  pages.  We
      also  perform  document analysis,  using  various techniques  to
      identify codebases from documents. and ftp sites, and so on.)).
    </p>
    <p>
      When  software systems  have  been found  and their  ontological
      relations  mapped   out,  it  then  becomes   possible  to  make
      deductions about whether  their capabilities may be incorporated
      to  our systems, i.e.,  we can  determine to  what extent  it is
      possible   to   use  the   codebase,   according  to   licensing
      restrictions.  So for instance, if the license permits, packages
      are created for various architectures using our Packager system,
      and these  are uploaded to our package  repositories for various
      systems  (Linux (Debian, Gentoo,  RHN, apt-rpm),  BSD (FreeBSD),
      etc.).
    </p>
    <p>
      As our  goal is  to increase the  capabilities of  free software
      systems,  an  as of  yet  unnamed  subsystem employs  key-player
      analysis   to   determine  which   software   must  be   somehow
      transplanted to open source, either  by appeal to the authors to
      change  license, or  by reimplementation  or  substitution where
      possible.
    </p>
    <p>
      The software ontology maintained  by RADAR serves to interrelate
      discovered  capabilities  with  the  existing needs  of  various
      internal  projects and  codebases, as  well as  answer questions
      about capabilities and  systems.  Eventually, these capabilities
      will  be  refactored  into   separate  systems.   But  the  most
      interesting aspect  is how quickly functionality  can be applied
      to  support  the goals  of  the  project.   As functionality  is
      identified, the system is able  in many cases to quickly package
      the best codebases which support this, and then various existing
      system take over the  role of incorporating this capability into
      the system  effectively.  Therefore the system  builds on itself
      intelligently, in a positive feedback loop.
    </p>
    <p>
      Here is  just a  routine trace of  radar in action.   This trace
      involves install a complex perl  module.  Note that in this case
      the bulk of the work is done by debaux, a program for generating
      debs from perl modules.
    </p>
    <pre>
/var/lib/myfrdcsa/codebases/data/frdcsa-perl $ sudo radar install Text::NSP
&lt;ITEM:Text::NSP>
&lt;CATEGORY:Perl Module>
0) Perl Module
1) URL
2) Freshmeat
3) Local File
4) SourceForge
5) FTP Site
6) Perl Module
7) Debian Package
0
Module: Text::NSP
Going to read /home/jasayne/.cpan/Metadata
  Database was generated on Thu, 02 Jun 2005 23:05:55 GMT
Fetching with LWP:
  ftp://archive.progeny.com/CPAN/authors/01mailrc.txt.gz
Going to read /home/jasayne/.cpan/sources/authors/01mailrc.txt.gz
CPAN: Compress::Zlib loaded ok
Fetching with LWP:
  ftp://archive.progeny.com/CPAN/modules/02packages.details.txt.gz
Going to read /home/jasayne/.cpan/sources/modules/02packages.details.txt.gz
  Database was generated on Sat, 04 Jun 2005 21:58:53 GMT
Fetching with LWP:
  ftp://archive.progeny.com/CPAN/modules/03modlist.data.gz
Going to read /home/jasayne/.cpan/sources/modules/03modlist.data.gz
Going to write /home/jasayne/.cpan/Metadata
Status: Available through debaux
Command: debaux-build --cpan Text::NSP
CPAN: Storable loaded ok
Going to read /home/jasayne/.cpan/Metadata
  Database was generated on Sat, 04 Jun 2005 21:58:53 GMT
&lt;&lt;&lt;DIR:Text-NSP-0.71>>>
&lt;&lt;&lt;ANA:Text-NSP>>>
Text-NSP - 0.71
Running get for module Text::NSP
Fetching with LWP:
  ftp://archive.progeny.com/CPAN/authors/id/T/TP/TPEDERSE/Text-NSP-0.71.tar.gz
CPAN: Digest::MD5 loaded ok
Fetching with LWP:
  ftp://archive.progeny.com/CPAN/authors/id/T/TP/TPEDERSE/CHECKSUMS
CPAN: Compress::Zlib loaded ok
Checksum for /home/jasayne/.cpan/sources/authors/id/T/TP/TPEDERSE/Text-NSP-0.71.tar.gz ok
Scanning cache /home/jasayne/.cpan/build for sizes
Text-NSP-0.71/
Text-NSP-0.71/Makefile.PL
Text-NSP-0.71/CHANGES
Text-NSP-0.71/FDL
Text-NSP-0.71/GPL
Text-NSP-0.71/INSTALL
Text-NSP-0.71/MANIFEST
Text-NSP-0.71/statistic.pl
Text-NSP-0.71/NSP.pm
Text-NSP-0.71/README
Text-NSP-0.71/count.pl
Text-NSP-0.71/Docs/
Text-NSP-0.71/Docs/cicling2003.pdf
Text-NSP-0.71/Docs/ChangeLog-v0.50.txt
Text-NSP-0.71/Docs/ChangeLog-v0.51.txt
Text-NSP-0.71/Docs/ChangeLog-v0.53.txt
Text-NSP-0.71/Docs/ChangeLog-v0.55.txt
Text-NSP-0.71/Docs/ChangeLog-v0.57.txt
Text-NSP-0.71/Docs/ChangeLog-v0.59.txt
Text-NSP-0.71/Docs/ChangeLog-v0.61.txt
Text-NSP-0.71/Docs/ChangeLog-v0.63.txt
Text-NSP-0.71/Docs/ChangeLog-v0.65.txt
Text-NSP-0.71/Docs/ChangeLog-v0.67.txt
Text-NSP-0.71/Docs/ChangeLog-v0.69.txt
Text-NSP-0.71/Docs/ChangeLog-v0.71.txt
Text-NSP-0.71/Docs/FAQ.pod
Text-NSP-0.71/Docs/Measures.pod
Text-NSP-0.71/Docs/NewStats.pod
Text-NSP-0.71/Docs/README.pod
Text-NSP-0.71/Docs/Todo.pod
Text-NSP-0.71/Docs/Usage.pod
Text-NSP-0.71/Docs/cicling2003.ps
Text-NSP-0.71/Measures/
Text-NSP-0.71/Measures/leftFisher.pm
Text-NSP-0.71/Measures/dice.pm
Text-NSP-0.71/Measures/odds.pm
Text-NSP-0.71/Measures/ll.pm
Text-NSP-0.71/Measures/ll3.pm
Text-NSP-0.71/Measures/measure2d.pm
Text-NSP-0.71/Measures/measure3d.pm
Text-NSP-0.71/Measures/phi.pm
Text-NSP-0.71/Measures/pmi.pm
Text-NSP-0.71/Measures/rightFisher.pm
Text-NSP-0.71/Measures/tmi.pm
Text-NSP-0.71/Measures/tmi3.pm
Text-NSP-0.71/Measures/tscore.pm
Text-NSP-0.71/Measures/x2.pm
Text-NSP-0.71/Testing/
Text-NSP-0.71/Testing/combig/
Text-NSP-0.71/Testing/combig/normal-op.sh
Text-NSP-0.71/Testing/combig/README.txt
Text-NSP-0.71/Testing/combig/error-handling.sh
Text-NSP-0.71/Testing/combig/test-A1.big
Text-NSP-0.71/Testing/combig/test-A1.reqd
Text-NSP-0.71/Testing/combig/test-A2.big
Text-NSP-0.71/Testing/combig/test-A2.reqd
Text-NSP-0.71/Testing/combig/test-A3.big
Text-NSP-0.71/Testing/combig/test-A3.reqd
Text-NSP-0.71/Testing/combig/test-A4.big
Text-NSP-0.71/Testing/combig/test-A4.reqd
Text-NSP-0.71/Testing/combig/test-A5.big
Text-NSP-0.71/Testing/combig/test-A5.reqd
Text-NSP-0.71/Testing/combig/test-A6.big
Text-NSP-0.71/Testing/combig/test-A6.reqd
Text-NSP-0.71/Testing/combig/test-B1.big
Text-NSP-0.71/Testing/combig/test-B1.reqd
Text-NSP-0.71/Testing/combig/test-B2.big
Text-NSP-0.71/Testing/combig/test-B2.reqd
Text-NSP-0.71/Testing/combig/test-B3.big
Text-NSP-0.71/Testing/combig/test-B3.reqd
Text-NSP-0.71/Testing/combig/testA1.sh
Text-NSP-0.71/Testing/combig/testA2.sh
Text-NSP-0.71/Testing/combig/testA3.sh
Text-NSP-0.71/Testing/combig/testA4.sh
Text-NSP-0.71/Testing/combig/testA5.sh
Text-NSP-0.71/Testing/combig/testA6.sh
Text-NSP-0.71/Testing/combig/testB1.sh
Text-NSP-0.71/Testing/combig/testB2.sh
Text-NSP-0.71/Testing/combig/testB3.sh
Text-NSP-0.71/Testing/ll/
Text-NSP-0.71/Testing/ll/normal-op.sh
Text-NSP-0.71/Testing/ll/README.txt
Text-NSP-0.71/Testing/ll/error-handling.sh
Text-NSP-0.71/Testing/ll/test-1.cnt
Text-NSP-0.71/Testing/ll/test-1.sub-1.cnt
Text-NSP-0.71/Testing/ll/test-1.sub-1.reqd
Text-NSP-0.71/Testing/ll/test-1.sub-2.cnt
Text-NSP-0.71/Testing/ll/test-1.sub-2.reqd
Text-NSP-0.71/Testing/ll/test-1.sub-2.freq_combo.txt
Text-NSP-0.71/Testing/ll/test-1.sub-3.cnt
Text-NSP-0.71/Testing/ll/test-1.sub-3.reqd
Text-NSP-0.71/Testing/ll/test-1.sub-4.cnt
Text-NSP-0.71/Testing/ll/test-1.sub-4.error.reqd
Text-NSP-0.71/Testing/ll/test-1.sub-4.reqd
Text-NSP-0.71/Testing/ll/test-2.sub-1-a.cnt
Text-NSP-0.71/Testing/ll/test-2.sub-1-a.reqd
Text-NSP-0.71/Testing/ll/test-2.sub-1-b.cnt
Text-NSP-0.71/Testing/ll/test-2.sub-1-b.freq_combo.txt
Text-NSP-0.71/Testing/ll/test-2.sub-1-b.reqd
Text-NSP-0.71/Testing/ALL-TESTS.sh
Text-NSP-0.71/Testing/count/
Text-NSP-0.71/Testing/count/normal-op.sh
Text-NSP-0.71/Testing/count/README.txt
Text-NSP-0.71/Testing/count/test-1.freq_comb.out
Text-NSP-0.71/Testing/count/error-handling.sh
Text-NSP-0.71/Testing/count/test-1.sub-1-a.token.txt
Text-NSP-0.71/Testing/count/test-1.sub-1-a.reqd
Text-NSP-0.71/Testing/count/test-1.sub-1-b.token.txt
Text-NSP-0.71/Testing/count/test-1.sub-1-b.reqd
Text-NSP-0.71/Testing/count/test-1.sub-1-c.token.txt
Text-NSP-0.71/Testing/count/test-1.sub-1-c.reqd
Text-NSP-0.71/Testing/count/test-1.sub-1-d.token.txt
Text-NSP-0.71/Testing/count/test-1.sub-1-d.reqd
Text-NSP-0.71/Testing/count/test-1.sub-1-e.token.txt
Text-NSP-0.71/Testing/count/test-1.sub-1-e.reqd
Text-NSP-0.71/Testing/count/test-1.sub-1-f.token.txt
Text-NSP-0.71/Testing/count/test-1.sub-1-f.reqd
Text-NSP-0.71/Testing/count/data-dir/
Text-NSP-0.71/Testing/count/data-dir/data-subdir-1/
Text-NSP-0.71/Testing/count/data-dir/data-subdir-1/test-1.txt
Text-NSP-0.71/Testing/count/data-dir/test-5.txt
Text-NSP-0.71/Testing/count/data-dir/test-6.txt
Text-NSP-0.71/Testing/count/data-dir/data-subdir-2/
Text-NSP-0.71/Testing/count/data-dir/data-subdir-2/test-2.txt
Text-NSP-0.71/Testing/count/data-dir/data-subdir-3/
Text-NSP-0.71/Testing/count/data-dir/data-subdir-3/test-3.txt
Text-NSP-0.71/Testing/count/data-dir/data-subdir-4/
Text-NSP-0.71/Testing/count/data-dir/data-subdir-4/test-4.txt
Text-NSP-0.71/Testing/count/test-1.txt
Text-NSP-0.71/Testing/count/test-1.sub-10-a.nontoken.txt
Text-NSP-0.71/Testing/count/test-1.sub-10-a.reqd
Text-NSP-0.71/Testing/count/test-1.sub-10-b.nontoken.txt
Text-NSP-0.71/Testing/count/test-1.sub-10-b.reqd
Text-NSP-0.71/Testing/count/test-1.sub-10-c.nontoken.txt
Text-NSP-0.71/Testing/count/test-1.sub-10-c.reqd
Text-NSP-0.71/Testing/count/test-1.sub-2-a.reqd
Text-NSP-0.71/Testing/count/test-1.sub-2-b.reqd
Text-NSP-0.71/Testing/count/test-1.sub-2-c.reqd
Text-NSP-0.71/Testing/count/test-1.sub-2-d.reqd
Text-NSP-0.71/Testing/count/test-1.sub-2-e.reqd
Text-NSP-0.71/Testing/count/test-1.sub-3-a.freq_combo.txt
Text-NSP-0.71/Testing/count/test-1.sub-3-b.freq_combo.txt
Text-NSP-0.71/Testing/count/test-1.sub-3-c.reqd
Text-NSP-0.71/Testing/count/test-1.sub-3-c.freq_combo.txt
Text-NSP-0.71/Testing/count/test-1.sub-3-d.freq_combo.txt
Text-NSP-0.71/Testing/count/test-1.sub-3-d.reqd
Text-NSP-0.71/Testing/count/test-1.sub-4-a.reqd
Text-NSP-0.71/Testing/count/test-1.sub-4-b.reqd
Text-NSP-0.71/Testing/count/test-1.sub-4-c.reqd
Text-NSP-0.71/Testing/count/test-1.sub-4-c.stop.txt
Text-NSP-0.71/Testing/count/test-1.sub-4-d.reqd
Text-NSP-0.71/Testing/count/test-1.sub-4-d.stop.txt
Text-NSP-0.71/Testing/count/test-1.sub-4-e.reqd
Text-NSP-0.71/Testing/count/test-1.sub-4-e.stop.txt
Text-NSP-0.71/Testing/count/test-1.sub-4.stop.txt
Text-NSP-0.71/Testing/count/test-1.sub-5-a.reqd
Text-NSP-0.71/Testing/count/test-1.sub-5-b.reqd
Text-NSP-0.71/Testing/count/test-1.sub-5-c.reqd
Text-NSP-0.71/Testing/count/test-1.sub-5-d.reqd
Text-NSP-0.71/Testing/count/test-2.txt
Text-NSP-0.71/Testing/count/test-1.sub-5.txt
Text-NSP-0.71/Testing/count/test-1.sub-6-a.reqd
Text-NSP-0.71/Testing/count/test-1.sub-6-b.reqd
Text-NSP-0.71/Testing/count/test-1.sub-6.txt
Text-NSP-0.71/Testing/count/test-1.sub-7-a.histo.reqd
Text-NSP-0.71/Testing/count/test-1.sub-7-b.histo.reqd
Text-NSP-0.71/Testing/count/test-1.sub-8-a.reqd
Text-NSP-0.71/Testing/count/test-1.sub-8-b.reqd
Text-NSP-0.71/Testing/count/test-1.sub-9.reqd
Text-NSP-0.71/Testing/count/test-2.sub-1.reqd
Text-NSP-0.71/Testing/count/test-2.sub-2.reqd
Text-NSP-0.71/Testing/count/test-2.sub-3.reqd
Text-NSP-0.71/Testing/count/test-2.sub-4.reqd
Text-NSP-0.71/Testing/count/test-2.sub-5.reqd
Text-NSP-0.71/Testing/count/test-2.sub-6.reqd
Text-NSP-0.71/Testing/count/test-2.sub-7.reqd
Text-NSP-0.71/Testing/count/test-2.sub-8.freq_combo.txt
Text-NSP-0.71/Testing/count/test-2.sub-8.reqd
Text-NSP-0.71/Testing/dice/
Text-NSP-0.71/Testing/dice/normal-op.sh
Text-NSP-0.71/Testing/dice/README.txt
Text-NSP-0.71/Testing/dice/error-handling.sh
Text-NSP-0.71/Testing/dice/test-1.cnt
Text-NSP-0.71/Testing/dice/test-1.sub-1.cnt
Text-NSP-0.71/Testing/dice/test-1.sub-1.reqd
Text-NSP-0.71/Testing/dice/test-1.sub-2.cnt
Text-NSP-0.71/Testing/dice/test-1.sub-2.reqd
Text-NSP-0.71/Testing/dice/test-1.sub-2.freq_combo.txt
Text-NSP-0.71/Testing/dice/test-1.sub-3.cnt
Text-NSP-0.71/Testing/dice/test-1.sub-3.reqd
Text-NSP-0.71/Testing/dice/test-1.sub-4.cnt
Text-NSP-0.71/Testing/dice/test-1.sub-4.error.reqd
Text-NSP-0.71/Testing/dice/test-1.sub-4.reqd
Text-NSP-0.71/Testing/dice/test-2.sub-1-a.cnt
Text-NSP-0.71/Testing/dice/test-2.sub-1-a.reqd
Text-NSP-0.71/Testing/dice/test-2.sub-1-b.cnt
Text-NSP-0.71/Testing/dice/test-2.sub-1-b.freq_combo.txt
Text-NSP-0.71/Testing/dice/test-2.sub-1-b.reqd
Text-NSP-0.71/Testing/huge-combine/
Text-NSP-0.71/Testing/huge-combine/normal-op.sh
Text-NSP-0.71/Testing/huge-combine/README.txt
Text-NSP-0.71/Testing/huge-combine/error-handling.sh
Text-NSP-0.71/Testing/huge-combine/test-A1.count1
Text-NSP-0.71/Testing/huge-combine/test-A1.count2
Text-NSP-0.71/Testing/huge-combine/test-A1.reqd
Text-NSP-0.71/Testing/huge-combine/test-A2.count1
Text-NSP-0.71/Testing/huge-combine/test-A2.count2
Text-NSP-0.71/Testing/huge-combine/test-A2.reqd
Text-NSP-0.71/Testing/huge-combine/test-A3.count1
Text-NSP-0.71/Testing/huge-combine/test-A3.count2
Text-NSP-0.71/Testing/huge-combine/test-A3.reqd
Text-NSP-0.71/Testing/huge-combine/test-A4.count1
Text-NSP-0.71/Testing/huge-combine/test-A4.count2
Text-NSP-0.71/Testing/huge-combine/test-A4.reqd
Text-NSP-0.71/Testing/huge-combine/test-A5.count1
Text-NSP-0.71/Testing/huge-combine/test-A5.count2
Text-NSP-0.71/Testing/huge-combine/test-A5.reqd
Text-NSP-0.71/Testing/huge-combine/test-A6.count1
Text-NSP-0.71/Testing/huge-combine/test-A6.count2
Text-NSP-0.71/Testing/huge-combine/test-A6.reqd
Text-NSP-0.71/Testing/huge-combine/test-A7.count1
Text-NSP-0.71/Testing/huge-combine/test-A7.count2
Text-NSP-0.71/Testing/huge-combine/test-A7.reqd
Text-NSP-0.71/Testing/huge-combine/test-B1.count1
Text-NSP-0.71/Testing/huge-combine/test-B1.count2
Text-NSP-0.71/Testing/huge-combine/test-B1.reqd
Text-NSP-0.71/Testing/huge-combine/test-B2.count1
Text-NSP-0.71/Testing/huge-combine/test-B2.count2
Text-NSP-0.71/Testing/huge-combine/test-B2.reqd
Text-NSP-0.71/Testing/huge-combine/testA1.sh
Text-NSP-0.71/Testing/huge-combine/testA2.sh
Text-NSP-0.71/Testing/huge-combine/testA3.sh
Text-NSP-0.71/Testing/huge-combine/testA4.sh
Text-NSP-0.71/Testing/huge-combine/testA5.sh
Text-NSP-0.71/Testing/huge-combine/testA6.sh
Text-NSP-0.71/Testing/huge-combine/testA7.sh
Text-NSP-0.71/Testing/huge-combine/testB1.sh
Text-NSP-0.71/Testing/huge-combine/testB2.sh
Text-NSP-0.71/Testing/huge-count/
Text-NSP-0.71/Testing/huge-count/README.txt
Text-NSP-0.71/Testing/huge-count/lc.pl
Text-NSP-0.71/Testing/huge-count/test-A1.reqd/
Text-NSP-0.71/Testing/huge-count/test-A1.reqd/test-A1.data1.bigrams
Text-NSP-0.71/Testing/huge-count/test-A1.reqd/huge-count.output
Text-NSP-0.71/Testing/huge-count/test-A1.reqd/test-A1.data1
Text-NSP-0.71/Testing/huge-count/test-A1.reqd/test-A1.data2
Text-NSP-0.71/Testing/huge-count/test-A1.reqd/test-A1.data3
Text-NSP-0.71/Testing/huge-count/test-A1.reqd/test-A1.data2.bigrams
Text-NSP-0.71/Testing/huge-count/test-A1.reqd/test-A1.data3.bigrams
Text-NSP-0.71/Testing/huge-count/test-A1.reqd/test-A1.data4
Text-NSP-0.71/Testing/huge-count/test-A1.reqd/test-A1.data4.bigrams
Text-NSP-0.71/Testing/huge-count/error-handling.sh
Text-NSP-0.71/Testing/huge-count/nontoken.regex
Text-NSP-0.71/Testing/huge-count/normal-op.sh
Text-NSP-0.71/Testing/huge-count/stoplist
Text-NSP-0.71/Testing/huge-count/test-A1.data
Text-NSP-0.71/Testing/huge-count/test-A3.data1
Text-NSP-0.71/Testing/huge-count/test-A3.data2
Text-NSP-0.71/Testing/huge-count/test-A3.data3
Text-NSP-0.71/Testing/huge-count/test-A3.data4
Text-NSP-0.71/Testing/huge-count/test-A41.data
Text-NSP-0.71/Testing/huge-count/test-A41.reqd
Text-NSP-0.71/Testing/huge-count/test-A42.reqd
Text-NSP-0.71/Testing/huge-count/test-A43.data1
Text-NSP-0.71/Testing/huge-count/test-A43.data2
Text-NSP-0.71/Testing/huge-count/test-A43.data3
Text-NSP-0.71/Testing/huge-count/test-A43.data4
Text-NSP-0.71/Testing/huge-count/test-A43.reqd
Text-NSP-0.71/Testing/huge-count/testA1.sh
Text-NSP-0.71/Testing/huge-count/test-A51.data
Text-NSP-0.71/Testing/huge-count/test-A53.data1
Text-NSP-0.71/Testing/huge-count/test-A53.data2
Text-NSP-0.71/Testing/huge-count/test-A53.data3
Text-NSP-0.71/Testing/huge-count/test-A53.data4
Text-NSP-0.71/Testing/huge-count/test-A6.reqd
Text-NSP-0.71/Testing/huge-count/test-A61.data
Text-NSP-0.71/Testing/huge-count/test-A63.data1
Text-NSP-0.71/Testing/huge-count/test-A63.data2
Text-NSP-0.71/Testing/huge-count/test-A63.data3
Text-NSP-0.71/Testing/huge-count/test-A63.data4
Text-NSP-0.71/Testing/huge-count/test-A71.data
Text-NSP-0.71/Testing/huge-count/test-A73.data1
Text-NSP-0.71/Testing/huge-count/test-A73.data2
Text-NSP-0.71/Testing/huge-count/test-A73.data3
Text-NSP-0.71/Testing/huge-count/test-A73.data4
Text-NSP-0.71/Testing/huge-count/test-A8.count
Text-NSP-0.71/Testing/huge-count/test-A81.data
Text-NSP-0.71/Testing/huge-count/test-A83.data1
Text-NSP-0.71/Testing/huge-count/test-A83.data2
Text-NSP-0.71/Testing/huge-count/test-A83.data3
Text-NSP-0.71/Testing/huge-count/test-A83.data4
Text-NSP-0.71/Testing/huge-count/test-B1.data1
Text-NSP-0.71/Testing/huge-count/test-B1.data3
Text-NSP-0.71/Testing/huge-count/test-B1.reqd
Text-NSP-0.71/Testing/huge-count/test-B2.data
Text-NSP-0.71/Testing/huge-count/test-B2.reqd
Text-NSP-0.71/Testing/huge-count/testA2.sh
Text-NSP-0.71/Testing/huge-count/testA3.sh
Text-NSP-0.71/Testing/huge-count/testA4.sh
Text-NSP-0.71/Testing/huge-count/testA51.sh
Text-NSP-0.71/Testing/huge-count/testA52.sh
Text-NSP-0.71/Testing/huge-count/testA53.sh
Text-NSP-0.71/Testing/huge-count/testA6.sh
Text-NSP-0.71/Testing/huge-count/testA71.sh
Text-NSP-0.71/Testing/huge-count/testA72.sh
Text-NSP-0.71/Testing/huge-count/testA73.sh
Text-NSP-0.71/Testing/huge-count/testA8.sh
Text-NSP-0.71/Testing/huge-count/testB1.sh
Text-NSP-0.71/Testing/huge-count/testB2.sh
Text-NSP-0.71/Testing/huge-count/token.regex
Text-NSP-0.71/Testing/huge-count/test-A2.data/
Text-NSP-0.71/Testing/huge-count/test-A2.data/test-A2.data1
Text-NSP-0.71/Testing/huge-count/test-A2.data/test-A2.data2
Text-NSP-0.71/Testing/huge-count/test-A2.data/test-A2.data3
Text-NSP-0.71/Testing/huge-count/test-A2.data/test-A2.data4
Text-NSP-0.71/Testing/huge-count/test-A2.reqd/
Text-NSP-0.71/Testing/huge-count/test-A2.reqd/test-A2.data1.bigrams
Text-NSP-0.71/Testing/huge-count/test-A2.reqd/huge-count.output
Text-NSP-0.71/Testing/huge-count/test-A2.reqd/test-A2.data2.bigrams
Text-NSP-0.71/Testing/huge-count/test-A2.reqd/test-A2.data3.bigrams
Text-NSP-0.71/Testing/huge-count/test-A2.reqd/test-A2.data4.bigrams
Text-NSP-0.71/Testing/huge-count/test-A3.reqd/
Text-NSP-0.71/Testing/huge-count/test-A3.reqd/test-A3.data1.bigrams
Text-NSP-0.71/Testing/huge-count/test-A3.reqd/huge-count.output
Text-NSP-0.71/Testing/huge-count/test-A3.reqd/test-A3.data2.bigrams
Text-NSP-0.71/Testing/huge-count/test-A3.reqd/test-A3.data3.bigrams
Text-NSP-0.71/Testing/huge-count/test-A3.reqd/test-A3.data4.bigrams
Text-NSP-0.71/Testing/huge-count/test-A42.data/
Text-NSP-0.71/Testing/huge-count/test-A42.data/test-A42.data1
Text-NSP-0.71/Testing/huge-count/test-A42.data/test-A42.data2
Text-NSP-0.71/Testing/huge-count/test-A42.data/test-A42.data3
Text-NSP-0.71/Testing/huge-count/test-A42.data/test-A42.data4
Text-NSP-0.71/Testing/huge-count/test-A5.reqd/
Text-NSP-0.71/Testing/huge-count/test-A5.reqd/test-A5.data1.bigrams
Text-NSP-0.71/Testing/huge-count/test-A5.reqd/huge-count.output
Text-NSP-0.71/Testing/huge-count/test-A5.reqd/test-A5.data1
Text-NSP-0.71/Testing/huge-count/test-A5.reqd/test-A5.data2
Text-NSP-0.71/Testing/huge-count/test-A5.reqd/test-A5.data3
Text-NSP-0.71/Testing/huge-count/test-A5.reqd/test-A5.data2.bigrams
Text-NSP-0.71/Testing/huge-count/test-A5.reqd/test-A5.data3.bigrams
Text-NSP-0.71/Testing/huge-count/test-A5.reqd/test-A5.data4
Text-NSP-0.71/Testing/huge-count/test-A5.reqd/test-A5.data4.bigrams
Text-NSP-0.71/Testing/huge-count/test-A52.data/
Text-NSP-0.71/Testing/huge-count/test-A52.data/test-A52.data1
Text-NSP-0.71/Testing/huge-count/test-A52.data/test-A52.data2
Text-NSP-0.71/Testing/huge-count/test-A52.data/test-A52.data3
Text-NSP-0.71/Testing/huge-count/test-A52.data/test-A52.data4
Text-NSP-0.71/Testing/huge-count/test-A62.data/
Text-NSP-0.71/Testing/huge-count/test-A62.data/test-A42.data1
Text-NSP-0.71/Testing/huge-count/test-A62.data/test-A42.data2
Text-NSP-0.71/Testing/huge-count/test-A62.data/test-A42.data3
Text-NSP-0.71/Testing/huge-count/test-A62.data/test-A42.data4
Text-NSP-0.71/Testing/huge-count/test-A7.reqd/
Text-NSP-0.71/Testing/huge-count/test-A7.reqd/test-A7.data1.bigrams
Text-NSP-0.71/Testing/huge-count/test-A7.reqd/huge-count.output
Text-NSP-0.71/Testing/huge-count/test-A7.reqd/test-A7.data1
Text-NSP-0.71/Testing/huge-count/test-A7.reqd/test-A7.data2
Text-NSP-0.71/Testing/huge-count/test-A7.reqd/test-A7.data3
Text-NSP-0.71/Testing/huge-count/test-A7.reqd/test-A7.data2.bigrams
Text-NSP-0.71/Testing/huge-count/test-A7.reqd/test-A7.data3.bigrams
Text-NSP-0.71/Testing/huge-count/test-A7.reqd/test-A7.data4
Text-NSP-0.71/Testing/huge-count/test-A7.reqd/test-A7.data4.bigrams
Text-NSP-0.71/Testing/huge-count/test-A72.data/
Text-NSP-0.71/Testing/huge-count/test-A72.data/test-A72.data1
Text-NSP-0.71/Testing/huge-count/test-A72.data/test-A72.data2
Text-NSP-0.71/Testing/huge-count/test-A72.data/test-A72.data3
Text-NSP-0.71/Testing/huge-count/test-A72.data/test-A72.data4
Text-NSP-0.71/Testing/huge-count/test-A82.data/
Text-NSP-0.71/Testing/huge-count/test-A82.data/test-A82.data1
Text-NSP-0.71/Testing/huge-count/test-A82.data/test-A82.data2
Text-NSP-0.71/Testing/huge-count/test-A82.data/test-A82.data3
Text-NSP-0.71/Testing/huge-count/test-A82.data/test-A82.data4
Text-NSP-0.71/Testing/huge-count/test-B1.data2/
Text-NSP-0.71/Testing/huge-count/test-B1.data2/test-A2.data1
Text-NSP-0.71/Testing/huge-count/test-B1.data2/test-A2.data2
Text-NSP-0.71/Testing/huge-count/test-B1.data2/test-A2.data3
Text-NSP-0.71/Testing/huge-count/test-B1.data2/test-A2.data4
Text-NSP-0.71/Testing/kocos/
Text-NSP-0.71/Testing/kocos/integration/
Text-NSP-0.71/Testing/kocos/integration/normal-op.sh
Text-NSP-0.71/Testing/kocos/integration/README.txt
Text-NSP-0.71/Testing/kocos/integration/error-handling.sh
Text-NSP-0.71/Testing/kocos/integration/test-A1.in
Text-NSP-0.71/Testing/kocos/integration/test-A1a.reqd
Text-NSP-0.71/Testing/kocos/integration/test-A1b.reqd
Text-NSP-0.71/Testing/kocos/integration/test-A1c.reqd
Text-NSP-0.71/Testing/kocos/integration/test-A1d.reqd
Text-NSP-0.71/Testing/kocos/integration/test-A2.in
Text-NSP-0.71/Testing/kocos/integration/test-A2a.reqd
Text-NSP-0.71/Testing/kocos/integration/test-A2b.reqd
Text-NSP-0.71/Testing/kocos/integration/test-A2c.reqd
Text-NSP-0.71/Testing/kocos/integration/test-A2d.reqd
Text-NSP-0.71/Testing/kocos/integration/test-A3.in
Text-NSP-0.71/Testing/kocos/integration/test-A3a.reqd
Text-NSP-0.71/Testing/kocos/integration/test-A3b.reqd
Text-NSP-0.71/Testing/kocos/integration/test-A3c.reqd
Text-NSP-0.71/Testing/kocos/integration/test-A3d.reqd
Text-NSP-0.71/Testing/kocos/integration/testA1.sh
Text-NSP-0.71/Testing/kocos/integration/testA2.sh
Text-NSP-0.71/Testing/kocos/integration/testA3.sh
Text-NSP-0.71/Testing/kocos/unit/
Text-NSP-0.71/Testing/kocos/unit/normal-op.sh
Text-NSP-0.71/Testing/kocos/unit/README.txt
Text-NSP-0.71/Testing/kocos/unit/error-handling.sh
Text-NSP-0.71/Testing/kocos/unit/test-A1.count
Text-NSP-0.71/Testing/kocos/unit/test-A10.count
Text-NSP-0.71/Testing/kocos/unit/test-A10.regex
Text-NSP-0.71/Testing/kocos/unit/test-A10a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A10b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A10c.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A10d.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A10e.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A11.count
Text-NSP-0.71/Testing/kocos/unit/test-A11.regex
Text-NSP-0.71/Testing/kocos/unit/test-A11a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A11b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A11c.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A11d.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A12.count
Text-NSP-0.71/Testing/kocos/unit/test-A12.regex
Text-NSP-0.71/Testing/kocos/unit/test-A12a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A12b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A12c.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A12d.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A13.count
Text-NSP-0.71/Testing/kocos/unit/test-A13.regex
Text-NSP-0.71/Testing/kocos/unit/test-A13a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A13b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A13c.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A13d.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A13e.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A14.count
Text-NSP-0.71/Testing/kocos/unit/test-A14.regex
Text-NSP-0.71/Testing/kocos/unit/test-A14a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A14b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A14c.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A14d.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A15.count
Text-NSP-0.71/Testing/kocos/unit/test-A15.regex
Text-NSP-0.71/Testing/kocos/unit/test-A15a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A15b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A15c.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A16.count
Text-NSP-0.71/Testing/kocos/unit/test-A16.regex
Text-NSP-0.71/Testing/kocos/unit/test-A16a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A16b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A16c.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A16d.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A16e.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A17.count
Text-NSP-0.71/Testing/kocos/unit/test-A17a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A17b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A18.count
Text-NSP-0.71/Testing/kocos/unit/test-A18.regex
Text-NSP-0.71/Testing/kocos/unit/test-A18a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A18b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A18c.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A19.count
Text-NSP-0.71/Testing/kocos/unit/test-A19a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A19b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A1a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A1b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A1c.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A1d.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A2.count
Text-NSP-0.71/Testing/kocos/unit/test-A2a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A2b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A3.count
Text-NSP-0.71/Testing/kocos/unit/test-A3a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A3b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A4.count
Text-NSP-0.71/Testing/kocos/unit/test-A4a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A4b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A4c.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A5.count
Text-NSP-0.71/Testing/kocos/unit/test-A5a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A5b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A5c.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A6.count
Text-NSP-0.71/Testing/kocos/unit/test-A6a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A6b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A6c.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A6d.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A7.count
Text-NSP-0.71/Testing/kocos/unit/test-A7a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A7b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A7c.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A7d.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A7e.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A8.count
Text-NSP-0.71/Testing/kocos/unit/test-A8.regex
Text-NSP-0.71/Testing/kocos/unit/test-A8a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A8b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A8c.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A8d.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A9.count
Text-NSP-0.71/Testing/kocos/unit/test-A9.regex
Text-NSP-0.71/Testing/kocos/unit/test-A9a.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A9b.reqd
Text-NSP-0.71/Testing/kocos/unit/test-A9c.reqd
Text-NSP-0.71/Testing/kocos/unit/test-B1.count
Text-NSP-0.71/Testing/kocos/unit/test-B1.reqd
Text-NSP-0.71/Testing/kocos/unit/test-B2.count
Text-NSP-0.71/Testing/kocos/unit/test-B2.reqd
Text-NSP-0.71/Testing/kocos/unit/testA10a.sh
Text-NSP-0.71/Testing/kocos/unit/testA10b.sh
Text-NSP-0.71/Testing/kocos/unit/testA10c.sh
Text-NSP-0.71/Testing/kocos/unit/testA10d.sh
Text-NSP-0.71/Testing/kocos/unit/testA10e.sh
Text-NSP-0.71/Testing/kocos/unit/testA11a.sh
Text-NSP-0.71/Testing/kocos/unit/testA11b.sh
Text-NSP-0.71/Testing/kocos/unit/testA11c.sh
Text-NSP-0.71/Testing/kocos/unit/testA11d.sh
Text-NSP-0.71/Testing/kocos/unit/testA12a.sh
Text-NSP-0.71/Testing/kocos/unit/testA12b.sh
Text-NSP-0.71/Testing/kocos/unit/testA12c.sh
Text-NSP-0.71/Testing/kocos/unit/testA12d.sh
Text-NSP-0.71/Testing/kocos/unit/testA13a.sh
Text-NSP-0.71/Testing/kocos/unit/testA13b.sh
Text-NSP-0.71/Testing/kocos/unit/testA13c.sh
Text-NSP-0.71/Testing/kocos/unit/testA13d.sh
Text-NSP-0.71/Testing/kocos/unit/testA13e.sh
Text-NSP-0.71/Testing/kocos/unit/testA14a.sh
Text-NSP-0.71/Testing/kocos/unit/testA14b.sh
Text-NSP-0.71/Testing/kocos/unit/testA14c.sh
Text-NSP-0.71/Testing/kocos/unit/testA14d.sh
Text-NSP-0.71/Testing/kocos/unit/testA15a.sh
Text-NSP-0.71/Testing/kocos/unit/testA15b.sh
Text-NSP-0.71/Testing/kocos/unit/testA15c.sh
Text-NSP-0.71/Testing/kocos/unit/testA16a.sh
Text-NSP-0.71/Testing/kocos/unit/testA16b.sh
Text-NSP-0.71/Testing/kocos/unit/testA16c.sh
Text-NSP-0.71/Testing/kocos/unit/testA16d.sh
Text-NSP-0.71/Testing/kocos/unit/testA16e.sh
Text-NSP-0.71/Testing/kocos/unit/testA17a.sh
Text-NSP-0.71/Testing/kocos/unit/testA17b.sh
Text-NSP-0.71/Testing/kocos/unit/testA18a.sh
Text-NSP-0.71/Testing/kocos/unit/testA18b.sh
Text-NSP-0.71/Testing/kocos/unit/testA18c.sh
Text-NSP-0.71/Testing/kocos/unit/testA19a.sh
Text-NSP-0.71/Testing/kocos/unit/testA19b.sh
Text-NSP-0.71/Testing/kocos/unit/testA1a.sh
Text-NSP-0.71/Testing/kocos/unit/testA1b.sh
Text-NSP-0.71/Testing/kocos/unit/testA1c.sh
Text-NSP-0.71/Testing/kocos/unit/testA1d.sh
Text-NSP-0.71/Testing/kocos/unit/testA2a.sh
Text-NSP-0.71/Testing/kocos/unit/testA2b.sh
Text-NSP-0.71/Testing/kocos/unit/testA3a.sh
Text-NSP-0.71/Testing/kocos/unit/testA3b.sh
Text-NSP-0.71/Testing/kocos/unit/testA4a.sh
Text-NSP-0.71/Testing/kocos/unit/testA4b.sh
Text-NSP-0.71/Testing/kocos/unit/testA4c.sh
Text-NSP-0.71/Testing/kocos/unit/testA5a.sh
Text-NSP-0.71/Testing/kocos/unit/testA5b.sh
Text-NSP-0.71/Testing/kocos/unit/testA5c.sh
Text-NSP-0.71/Testing/kocos/unit/testA6a.sh
Text-NSP-0.71/Testing/kocos/unit/testA6b.sh
Text-NSP-0.71/Testing/kocos/unit/testA6c.sh
Text-NSP-0.71/Testing/kocos/unit/testA6d.sh
Text-NSP-0.71/Testing/kocos/unit/testA7a.sh
Text-NSP-0.71/Testing/kocos/unit/testA7b.sh
Text-NSP-0.71/Testing/kocos/unit/testA7c.sh
Text-NSP-0.71/Testing/kocos/unit/testA7d.sh
Text-NSP-0.71/Testing/kocos/unit/testA7e.sh
Text-NSP-0.71/Testing/kocos/unit/testA8a.sh
Text-NSP-0.71/Testing/kocos/unit/testA8b.sh
Text-NSP-0.71/Testing/kocos/unit/testA8c.sh
Text-NSP-0.71/Testing/kocos/unit/testA8d.sh
Text-NSP-0.71/Testing/kocos/unit/testA9a.sh
Text-NSP-0.71/Testing/kocos/unit/testA9b.sh
Text-NSP-0.71/Testing/kocos/unit/testA9c.sh
Text-NSP-0.71/Testing/kocos/unit/testB1.sh
Text-NSP-0.71/Testing/kocos/unit/testB2.sh
Text-NSP-0.71/Testing/leftFisher/
Text-NSP-0.71/Testing/leftFisher/normal-op.sh
Text-NSP-0.71/Testing/leftFisher/README.txt
Text-NSP-0.71/Testing/leftFisher/error-handling.sh
Text-NSP-0.71/Testing/leftFisher/test-1.cnt
Text-NSP-0.71/Testing/leftFisher/test-1.sub-1.cnt
Text-NSP-0.71/Testing/leftFisher/test-1.sub-1.reqd
Text-NSP-0.71/Testing/leftFisher/test-1.sub-2.cnt
Text-NSP-0.71/Testing/leftFisher/test-1.sub-2.reqd
Text-NSP-0.71/Testing/leftFisher/test-1.sub-2.freq_combo.txt
Text-NSP-0.71/Testing/leftFisher/test-1.sub-3.cnt
Text-NSP-0.71/Testing/leftFisher/test-1.sub-3.reqd
Text-NSP-0.71/Testing/leftFisher/test-1.sub-4.cnt
Text-NSP-0.71/Testing/leftFisher/test-1.sub-4.error.reqd
Text-NSP-0.71/Testing/leftFisher/test-1.sub-4.reqd
Text-NSP-0.71/Testing/leftFisher/test-2.sub-1-a.cnt
Text-NSP-0.71/Testing/leftFisher/test-2.sub-1-a.reqd
Text-NSP-0.71/Testing/leftFisher/test-2.sub-1-b.cnt
Text-NSP-0.71/Testing/leftFisher/test-2.sub-1-b.freq_combo.txt
Text-NSP-0.71/Testing/leftFisher/test-2.sub-1-b.reqd
Text-NSP-0.71/Testing/ll3/
Text-NSP-0.71/Testing/ll3/normal-op.sh
Text-NSP-0.71/Testing/ll3/README.txt
Text-NSP-0.71/Testing/ll3/error-handling.sh
Text-NSP-0.71/Testing/ll3/test-1.cnt
Text-NSP-0.71/Testing/ll3/test-1.sub-1.cnt
Text-NSP-0.71/Testing/ll3/test-1.sub-1.reqd
Text-NSP-0.71/Testing/ll3/test-1.sub-2.cnt
Text-NSP-0.71/Testing/ll3/test-1.sub-2.reqd
Text-NSP-0.71/Testing/ll3/test-1.sub-2.freq_combo.txt
Text-NSP-0.71/Testing/ll3/test-1.sub-3.cnt
Text-NSP-0.71/Testing/ll3/test-1.sub-3.reqd
Text-NSP-0.71/Testing/ll3/test-1.sub-4.cnt
Text-NSP-0.71/Testing/ll3/test-1.sub-4.error.reqd
Text-NSP-0.71/Testing/ll3/test-1.sub-4.reqd
Text-NSP-0.71/Testing/ll3/test-2.sub-1-a.cnt
Text-NSP-0.71/Testing/ll3/test-2.sub-1-a.reqd
Text-NSP-0.71/Testing/ll3/test-2.sub-1-b.cnt
Text-NSP-0.71/Testing/ll3/test-2.sub-1-b.freq_combo.txt
Text-NSP-0.71/Testing/ll3/test-2.sub-1-b.reqd
Text-NSP-0.71/Testing/odds/
Text-NSP-0.71/Testing/odds/normal-op.sh
Text-NSP-0.71/Testing/odds/README.txt
Text-NSP-0.71/Testing/odds/error-handling.sh
Text-NSP-0.71/Testing/odds/test-1.cnt
Text-NSP-0.71/Testing/odds/test-1.sub-1.cnt
Text-NSP-0.71/Testing/odds/test-1.sub-1.reqd
Text-NSP-0.71/Testing/odds/test-1.sub-2.cnt
Text-NSP-0.71/Testing/odds/test-1.sub-2.reqd
Text-NSP-0.71/Testing/odds/test-1.sub-2.freq_combo.txt
Text-NSP-0.71/Testing/odds/test-1.sub-3.cnt
Text-NSP-0.71/Testing/odds/test-1.sub-3.reqd
Text-NSP-0.71/Testing/odds/test-1.sub-4.cnt
Text-NSP-0.71/Testing/odds/test-1.sub-4.error.reqd
Text-NSP-0.71/Testing/odds/test-1.sub-4.reqd
Text-NSP-0.71/Testing/odds/test-2.sub-1-a.cnt
Text-NSP-0.71/Testing/odds/test-2.sub-1-a.reqd
Text-NSP-0.71/Testing/odds/test-2.sub-1-b.cnt
Text-NSP-0.71/Testing/odds/test-2.sub-1-b.freq_combo.txt
Text-NSP-0.71/Testing/odds/test-2.sub-1-b.reqd
Text-NSP-0.71/Testing/phi/
Text-NSP-0.71/Testing/phi/normal-op.sh
Text-NSP-0.71/Testing/phi/README.txt
Text-NSP-0.71/Testing/phi/error-handling.sh
Text-NSP-0.71/Testing/phi/test-1.cnt
Text-NSP-0.71/Testing/phi/test-1.sub-1.cnt
Text-NSP-0.71/Testing/phi/test-1.sub-1.reqd
Text-NSP-0.71/Testing/phi/test-1.sub-2.cnt
Text-NSP-0.71/Testing/phi/test-1.sub-2.reqd
Text-NSP-0.71/Testing/phi/test-1.sub-2.freq_combo.txt
Text-NSP-0.71/Testing/phi/test-1.sub-3.cnt
Text-NSP-0.71/Testing/phi/test-1.sub-3.reqd
Text-NSP-0.71/Testing/phi/test-1.sub-4.cnt
Text-NSP-0.71/Testing/phi/test-1.sub-4.error.reqd
Text-NSP-0.71/Testing/phi/test-1.sub-4.reqd
Text-NSP-0.71/Testing/phi/test-2.sub-1-a.cnt
Text-NSP-0.71/Testing/phi/test-2.sub-1-a.reqd
Text-NSP-0.71/Testing/phi/test-2.sub-1-b.cnt
Text-NSP-0.71/Testing/phi/test-2.sub-1-b.freq_combo.txt
Text-NSP-0.71/Testing/phi/test-2.sub-1-b.reqd
Text-NSP-0.71/Testing/pmi/
Text-NSP-0.71/Testing/pmi/normal-op.sh
Text-NSP-0.71/Testing/pmi/README.txt
Text-NSP-0.71/Testing/pmi/error-handling.sh
Text-NSP-0.71/Testing/pmi/test-1.cnt
Text-NSP-0.71/Testing/pmi/test-1.sub-1.cnt
Text-NSP-0.71/Testing/pmi/test-1.sub-1.reqd
Text-NSP-0.71/Testing/pmi/test-1.sub-2.cnt
Text-NSP-0.71/Testing/pmi/test-1.sub-2.reqd
Text-NSP-0.71/Testing/pmi/test-1.sub-2.freq_combo.txt
Text-NSP-0.71/Testing/pmi/test-1.sub-3.cnt
Text-NSP-0.71/Testing/pmi/test-1.sub-3.reqd
Text-NSP-0.71/Testing/pmi/test-1.sub-4.cnt
Text-NSP-0.71/Testing/pmi/test-1.sub-4.error.reqd
Text-NSP-0.71/Testing/pmi/test-1.sub-4.reqd
Text-NSP-0.71/Testing/pmi/test-2.sub-1-a.cnt
Text-NSP-0.71/Testing/pmi/test-2.sub-1-a.reqd
Text-NSP-0.71/Testing/pmi/test-2.sub-1-b.cnt
Text-NSP-0.71/Testing/pmi/test-2.sub-1-b.freq_combo.txt
Text-NSP-0.71/Testing/pmi/test-2.sub-1-b.reqd
Text-NSP-0.71/Testing/rank/
Text-NSP-0.71/Testing/rank/normal-op.sh
Text-NSP-0.71/Testing/rank/README.txt
Text-NSP-0.71/Testing/rank/test-1.sub-1-a.reqd
Text-NSP-0.71/Testing/rank/error-handling.sh
Text-NSP-0.71/Testing/rank/test-1-1.txt
Text-NSP-0.71/Testing/rank/test-1-2.txt
Text-NSP-0.71/Testing/rank/test-1.sub-1-b.reqd
Text-NSP-0.71/Testing/rank/test-1.sub-1-c.reqd
Text-NSP-0.71/Testing/rank/test-1.sub-2.reqd
Text-NSP-0.71/Testing/rank/test-1.sub-3.reqd
Text-NSP-0.71/Testing/rank/test-1.sub-4a.reqd
Text-NSP-0.71/Testing/rank/test-1.sub-4b.reqd
Text-NSP-0.71/Testing/rank/test-1.sub-4c.reqd
Text-NSP-0.71/Testing/rank/test-1.sub-4d.reqd
Text-NSP-0.71/Testing/rank/test-1.sub-5.reqd
Text-NSP-0.71/Testing/rank/test-2-1.txt
Text-NSP-0.71/Testing/rank/test-2-2.txt
Text-NSP-0.71/Testing/rank/test-2.sub-1.reqd
Text-NSP-0.71/Testing/rank/test-2.sub-2.reqd
Text-NSP-0.71/Testing/rank/test-3-1.txt
Text-NSP-0.71/Testing/rank/test-3-2.txt
Text-NSP-0.71/Testing/rank/test-4-1.txt
Text-NSP-0.71/Testing/rank/test-4-2.txt
Text-NSP-0.71/Testing/rank/test-5-1.txt
Text-NSP-0.71/Testing/rank/test-5-2.txt
Text-NSP-0.71/Testing/rightFisher/
Text-NSP-0.71/Testing/rightFisher/normal-op.sh
Text-NSP-0.71/Testing/rightFisher/README.txt
Text-NSP-0.71/Testing/rightFisher/error-handling.sh
Text-NSP-0.71/Testing/rightFisher/test-1.cnt
Text-NSP-0.71/Testing/rightFisher/test-1.sub-1.cnt
Text-NSP-0.71/Testing/rightFisher/test-1.sub-1.reqd
Text-NSP-0.71/Testing/rightFisher/test-1.sub-2.cnt
Text-NSP-0.71/Testing/rightFisher/test-1.sub-2.reqd
Text-NSP-0.71/Testing/rightFisher/test-1.sub-2.freq_combo.txt
Text-NSP-0.71/Testing/rightFisher/test-1.sub-3.cnt
Text-NSP-0.71/Testing/rightFisher/test-1.sub-3.reqd
Text-NSP-0.71/Testing/rightFisher/test-1.sub-4.cnt
Text-NSP-0.71/Testing/rightFisher/test-1.sub-4.error.reqd
Text-NSP-0.71/Testing/rightFisher/test-1.sub-4.reqd
Text-NSP-0.71/Testing/rightFisher/test-2.sub-1-a.cnt
Text-NSP-0.71/Testing/rightFisher/test-2.sub-1-a.reqd
Text-NSP-0.71/Testing/rightFisher/test-2.sub-1-b.cnt
Text-NSP-0.71/Testing/rightFisher/test-2.sub-1-b.freq_combo.txt
Text-NSP-0.71/Testing/rightFisher/test-2.sub-1-b.reqd
Text-NSP-0.71/Testing/sort-bigrams/
Text-NSP-0.71/Testing/sort-bigrams/normal-op.sh
Text-NSP-0.71/Testing/sort-bigrams/README.txt
Text-NSP-0.71/Testing/sort-bigrams/error-handling.sh
Text-NSP-0.71/Testing/sort-bigrams/test-A1.bigram
Text-NSP-0.71/Testing/sort-bigrams/test-A1.reqd
Text-NSP-0.71/Testing/sort-bigrams/test-A2.bigram
Text-NSP-0.71/Testing/sort-bigrams/test-A2.reqd
Text-NSP-0.71/Testing/sort-bigrams/test-A3.bigram
Text-NSP-0.71/Testing/sort-bigrams/test-A3.reqd
Text-NSP-0.71/Testing/sort-bigrams/test-A4.bigram
Text-NSP-0.71/Testing/sort-bigrams/test-A4.reqd
Text-NSP-0.71/Testing/sort-bigrams/test-A5.bigram
Text-NSP-0.71/Testing/sort-bigrams/test-A5.reqd
Text-NSP-0.71/Testing/sort-bigrams/test-A61.bigram
Text-NSP-0.71/Testing/sort-bigrams/test-A61.reqd
Text-NSP-0.71/Testing/sort-bigrams/test-A62.bigram
Text-NSP-0.71/Testing/sort-bigrams/test-A62.reqd
Text-NSP-0.71/Testing/sort-bigrams/test-A63.bigram
Text-NSP-0.71/Testing/sort-bigrams/test-A63.reqd
Text-NSP-0.71/Testing/sort-bigrams/test-A71.bigram
Text-NSP-0.71/Testing/sort-bigrams/test-A71.reqd
Text-NSP-0.71/Testing/sort-bigrams/test-A72.bigram
Text-NSP-0.71/Testing/sort-bigrams/test-A72.reqd
Text-NSP-0.71/Testing/sort-bigrams/test-B1.bigram
Text-NSP-0.71/Testing/sort-bigrams/test-B1.reqd
Text-NSP-0.71/Testing/sort-bigrams/testA1.sh
Text-NSP-0.71/Testing/sort-bigrams/testA2.sh
Text-NSP-0.71/Testing/sort-bigrams/testA3.sh
Text-NSP-0.71/Testing/sort-bigrams/testA4.sh
Text-NSP-0.71/Testing/sort-bigrams/testA5.sh
Text-NSP-0.71/Testing/sort-bigrams/testA6.sh
Text-NSP-0.71/Testing/sort-bigrams/testA7.sh
Text-NSP-0.71/Testing/sort-bigrams/testB1.sh
Text-NSP-0.71/Testing/split-data/
Text-NSP-0.71/Testing/split-data/normal-op.sh
Text-NSP-0.71/Testing/split-data/README.txt
Text-NSP-0.71/Testing/split-data/error-handling.sh
Text-NSP-0.71/Testing/split-data/test-A1.data
Text-NSP-0.71/Testing/split-data/test-A1.data1.reqd
Text-NSP-0.71/Testing/split-data/test-A1.data2.reqd
Text-NSP-0.71/Testing/split-data/test-A1.data3.reqd
Text-NSP-0.71/Testing/split-data/test-A2.data
Text-NSP-0.71/Testing/split-data/test-A2.data1.reqd
Text-NSP-0.71/Testing/split-data/test-A2.data2.reqd
Text-NSP-0.71/Testing/split-data/test-A2.data3.reqd
Text-NSP-0.71/Testing/split-data/test-A3.data
Text-NSP-0.71/Testing/split-data/test-A3.data1.reqd
Text-NSP-0.71/Testing/split-data/test-A4.data
Text-NSP-0.71/Testing/split-data/test-A4.data1.reqd
Text-NSP-0.71/Testing/split-data/test-A4.data2.reqd
Text-NSP-0.71/Testing/split-data/test-A4.data3.reqd
Text-NSP-0.71/Testing/split-data/test-A4.data4.reqd
Text-NSP-0.71/Testing/split-data/test-B1.data
Text-NSP-0.71/Testing/split-data/test-B1.reqd
Text-NSP-0.71/Testing/split-data/testA1.sh
Text-NSP-0.71/Testing/split-data/testA2.sh
Text-NSP-0.71/Testing/split-data/testA3.sh
Text-NSP-0.71/Testing/split-data/testA4.sh
Text-NSP-0.71/Testing/split-data/testB1.sh
Text-NSP-0.71/Testing/statistic/
Text-NSP-0.71/Testing/statistic/normal-op.sh
Text-NSP-0.71/Testing/statistic/README.txt
Text-NSP-0.71/Testing/statistic/t1
Text-NSP-0.71/Testing/statistic/error-handling.sh
Text-NSP-0.71/Testing/statistic/t2
Text-NSP-0.71/Testing/statistic/test_2.pm
Text-NSP-0.71/Testing/statistic/test-1.pm
Text-NSP-0.71/Testing/statistic/test-1.sub-1-a.reqd
Text-NSP-0.71/Testing/statistic/test-1.sub-1-b.reqd
Text-NSP-0.71/Testing/statistic/test-1.sub-1-c.reqd
Text-NSP-0.71/Testing/statistic/test-1.sub-1.cnt
Text-NSP-0.71/Testing/statistic/test-1.sub-2-a.reqd
Text-NSP-0.71/Testing/statistic/test-1.sub-2-b.reqd
Text-NSP-0.71/Testing/statistic/test-1.sub-2.cnt
Text-NSP-0.71/Testing/statistic/test-1.sub-2.freq_combo.txt
Text-NSP-0.71/Testing/statistic/test-1.sub-3-a.reqd
Text-NSP-0.71/Testing/statistic/test-1.sub-3-b.reqd
Text-NSP-0.71/Testing/statistic/test-1.sub-3-c.reqd
Text-NSP-0.71/Testing/statistic/test-1.sub-3-d.reqd
Text-NSP-0.71/Testing/statistic/test-1.sub-4-a.reqd
Text-NSP-0.71/Testing/statistic/test-1.sub-4-b.reqd
Text-NSP-0.71/Testing/statistic/test-1.sub-5.cnt
Text-NSP-0.71/Testing/statistic/test-1.sub-5.freq_comb.txt
Text-NSP-0.71/Testing/statistic/test-1.sub-5.reqd
Text-NSP-0.71/Testing/statistic/test-1.sub-6.cnt
Text-NSP-0.71/Testing/statistic/test-1.sub-6.reqd
Text-NSP-0.71/Testing/statistic/test-2.sub-1-a.cnt
Text-NSP-0.71/Testing/statistic/test-2.sub-1-a.freq_combo.txt
Text-NSP-0.71/Testing/statistic/test-2.sub-1-a.reqd
Text-NSP-0.71/Testing/statistic/test-2.sub-2-a.reqd
Text-NSP-0.71/Testing/statistic/test-2.sub-2-b.reqd
Text-NSP-0.71/Testing/statistic/test-2.sub-2.cnt
Text-NSP-0.71/Testing/statistic/test-2.sub-3-a.reqd
Text-NSP-0.71/Testing/statistic/test-2.sub-3-b.reqd
Text-NSP-0.71/Testing/statistic/test-2.sub-4-a.reqd
Text-NSP-0.71/Testing/statistic/test-2.sub-4-b.reqd
Text-NSP-0.71/Testing/statistic/test-2.sub-4-c.reqd
Text-NSP-0.71/Testing/statistic/test-2.sub-5-a.reqd
Text-NSP-0.71/Testing/statistic/test-2.sub-5-b.reqd
Text-NSP-0.71/Testing/statistic/test-2.sub-6.reqd
Text-NSP-0.71/Testing/statistic/test-2.sub-7-a.reqd
Text-NSP-0.71/Testing/statistic/test-2.sub-7-b.reqd
Text-NSP-0.71/Testing/statistic/test-2.sub-7.cnt
Text-NSP-0.71/Testing/statistic/test_1_sub_3_a.pm
Text-NSP-0.71/Testing/statistic/test_1_sub_3_b.pm
Text-NSP-0.71/Testing/statistic/test_1_sub_3_c.pm
Text-NSP-0.71/Testing/statistic/test_1_sub_3_d.pm
Text-NSP-0.71/Testing/tmi/
Text-NSP-0.71/Testing/tmi/normal-op.sh
Text-NSP-0.71/Testing/tmi/README.txt
Text-NSP-0.71/Testing/tmi/error-handling.sh
Text-NSP-0.71/Testing/tmi/test-1.cnt
Text-NSP-0.71/Testing/tmi/test-1.sub-1.cnt
Text-NSP-0.71/Testing/tmi/test-1.sub-1.reqd
Text-NSP-0.71/Testing/tmi/test-1.sub-2.cnt
Text-NSP-0.71/Testing/tmi/test-1.sub-2.reqd
Text-NSP-0.71/Testing/tmi/test-1.sub-2.freq_combo.txt
Text-NSP-0.71/Testing/tmi/test-1.sub-3.cnt
Text-NSP-0.71/Testing/tmi/test-1.sub-3.reqd
Text-NSP-0.71/Testing/tmi/test-1.sub-4.cnt
Text-NSP-0.71/Testing/tmi/test-1.sub-4.error.reqd
Text-NSP-0.71/Testing/tmi/test-1.sub-4.reqd
Text-NSP-0.71/Testing/tmi/test-2.sub-1-a.cnt
Text-NSP-0.71/Testing/tmi/test-2.sub-1-a.reqd
Text-NSP-0.71/Testing/tmi/test-2.sub-1-b.cnt
Text-NSP-0.71/Testing/tmi/test-2.sub-1-b.freq_combo.txt
Text-NSP-0.71/Testing/tmi/test-2.sub-1-b.reqd
Text-NSP-0.71/Testing/tmi3/
Text-NSP-0.71/Testing/tmi3/normal-op.sh
Text-NSP-0.71/Testing/tmi3/README.txt
Text-NSP-0.71/Testing/tmi3/error-handling.sh
Text-NSP-0.71/Testing/tmi3/test-1.cnt
Text-NSP-0.71/Testing/tmi3/test-1.sub-1.cnt
Text-NSP-0.71/Testing/tmi3/test-1.sub-1.reqd
Text-NSP-0.71/Testing/tmi3/test-1.sub-2.cnt
Text-NSP-0.71/Testing/tmi3/test-1.sub-2.reqd
Text-NSP-0.71/Testing/tmi3/test-1.sub-2.freq_combo.txt
Text-NSP-0.71/Testing/tmi3/test-1.sub-3.cnt
Text-NSP-0.71/Testing/tmi3/test-1.sub-3.reqd
Text-NSP-0.71/Testing/tmi3/test-1.sub-4.cnt
Text-NSP-0.71/Testing/tmi3/test-1.sub-4.error.reqd
Text-NSP-0.71/Testing/tmi3/test-1.sub-4.reqd
Text-NSP-0.71/Testing/tmi3/test-2.sub-1-a.cnt
Text-NSP-0.71/Testing/tmi3/test-2.sub-1-a.reqd
Text-NSP-0.71/Testing/tmi3/test-2.sub-1-b.cnt
Text-NSP-0.71/Testing/tmi3/test-2.sub-1-b.freq_combo.txt
Text-NSP-0.71/Testing/tmi3/test-2.sub-1-b.reqd
Text-NSP-0.71/Testing/tmi3/test-3.sub-1-a.cnt
Text-NSP-0.71/Testing/tmi3/test-3.sub-1-a.reqd
Text-NSP-0.71/Testing/tscore/
Text-NSP-0.71/Testing/tscore/normal-op.sh
Text-NSP-0.71/Testing/tscore/README.txt
Text-NSP-0.71/Testing/tscore/error-handling.sh
Text-NSP-0.71/Testing/tscore/test-1.cnt
Text-NSP-0.71/Testing/tscore/test-1.sub-1.cnt
Text-NSP-0.71/Testing/tscore/test-1.sub-1.reqd
Text-NSP-0.71/Testing/tscore/test-1.sub-2.cnt
Text-NSP-0.71/Testing/tscore/test-1.sub-2.reqd
Text-NSP-0.71/Testing/tscore/test-1.sub-2.freq_combo.txt
Text-NSP-0.71/Testing/tscore/test-1.sub-3.cnt
Text-NSP-0.71/Testing/tscore/test-1.sub-3.reqd
Text-NSP-0.71/Testing/tscore/test-1.sub-4.cnt
Text-NSP-0.71/Testing/tscore/test-1.sub-4.error.reqd
Text-NSP-0.71/Testing/tscore/test-1.sub-4.reqd
Text-NSP-0.71/Testing/tscore/test-2.sub-1-a.cnt
Text-NSP-0.71/Testing/tscore/test-2.sub-1-a.reqd
Text-NSP-0.71/Testing/tscore/test-2.sub-1-b.cnt
Text-NSP-0.71/Testing/tscore/test-2.sub-1-b.freq_combo.txt
Text-NSP-0.71/Testing/tscore/test-2.sub-1-b.reqd
Text-NSP-0.71/Testing/x2/
Text-NSP-0.71/Testing/x2/normal-op.sh
Text-NSP-0.71/Testing/x2/README.txt
Text-NSP-0.71/Testing/x2/error-handling.sh
Text-NSP-0.71/Testing/x2/test-1.cnt
Text-NSP-0.71/Testing/x2/test-1.sub-1.cnt
Text-NSP-0.71/Testing/x2/test-1.sub-1.reqd
Text-NSP-0.71/Testing/x2/test-1.sub-2.cnt
Text-NSP-0.71/Testing/x2/test-1.sub-2.reqd
Text-NSP-0.71/Testing/x2/test-1.sub-2.freq_combo.txt
Text-NSP-0.71/Testing/x2/test-1.sub-3.cnt
Text-NSP-0.71/Testing/x2/test-1.sub-3.reqd
Text-NSP-0.71/Testing/x2/test-1.sub-4.cnt
Text-NSP-0.71/Testing/x2/test-1.sub-4.error.reqd
Text-NSP-0.71/Testing/x2/test-1.sub-4.reqd
Text-NSP-0.71/Testing/x2/test-2.sub-1-a.cnt
Text-NSP-0.71/Testing/x2/test-2.sub-1-a.reqd
Text-NSP-0.71/Testing/x2/test-2.sub-1-b.cnt
Text-NSP-0.71/Testing/x2/test-2.sub-1-b.freq_combo.txt
Text-NSP-0.71/Testing/x2/test-2.sub-1-b.reqd
Text-NSP-0.71/Utils/
Text-NSP-0.71/Utils/combig-script.sh
Text-NSP-0.71/Utils/combig.pl
Text-NSP-0.71/Utils/huge-combine.pl
Text-NSP-0.71/Utils/huge-count.pl
Text-NSP-0.71/Utils/kocos-script.sh
Text-NSP-0.71/Utils/kocos.pl
Text-NSP-0.71/Utils/rank-script.sh
Text-NSP-0.71/Utils/rank.pl
Text-NSP-0.71/Utils/sort-bigrams.pl
Text-NSP-0.71/Utils/split-data.pl
Text-NSP-0.71/t/
Text-NSP-0.71/t/1.t
dpkg-buildpackage: source package is text-nsp-perl
dpkg-buildpackage: source version is 0.71-1
dpkg-buildpackage: source maintainer is Andrew Dougherty &lt;ajd@frdcsa.dyndns.org>
dpkg-buildpackage: host architecture is i386
 fakeroot debian/rules clean
dh_testdir
dh_testroot
rm -f build-stamp
# Add here commands to clean up after the build process.
dh_clean
 dpkg-source -b text-nsp-perl-0.71
dpkg-source: building text-nsp-perl in text-nsp-perl_0.71.orig.tar.gz
dpkg-source: building text-nsp-perl in text-nsp-perl_0.71-1.diff.gz
dpkg-source: building text-nsp-perl in text-nsp-perl_0.71-1.dsc
 debian/rules build
dh_testdir
/usr/bin/perl Makefile.PL INSTALLDIRS=vendor
Checking if your kit is complete...
Looks good
#################################################################
 You are running Makefile.PL. When this finishes, remember that you
 will also need to run the following to finish the install of NSP:

        make
        make test
        make install

 if "make install" fails and indicates that you don't have proper
 permissions to install, you do have the option to install NSP in
 a local directory of your own choosing. You can do this as follows:

        perl Makefile.PL PREFIX=/MYDIR/NSP
        make
        make test
        make install

 where /MYDIR is a directory that you own and can write to, and
 NSP is a new subdirectory. (The name NSP is not required, it
 can be anything)

 After all this is done, you can run "make clean" to remove some
 of the files created during installation
#################################################################
Writing Makefile for Text::NSP
if ! grep ^install_vendor Makefile >/dev/null; then \
	/usr/bin/make clean; \
	/usr/bin/perl Makefile.PL ...
fi
/usr/bin/make OPTIMIZE="-O2 -g -Wall"
make[1]: Entering directory `/var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71'
cp Measures/pmi.pm blib/lib/pmi.pm
cp Measures/rightFisher.pm blib/lib/rightFisher.pm
cp Measures/tmi3.pm blib/lib/tmi3.pm
cp Measures/measure3d.pm blib/lib/measure3d.pm
cp Measures/odds.pm blib/lib/odds.pm
cp Measures/ll3.pm blib/lib/ll3.pm
cp Measures/ll.pm blib/lib/ll.pm
cp Measures/dice.pm blib/lib/dice.pm
cp NSP.pm blib/lib/Text/NSP.pm
AutoSplitting blib/lib/Text/NSP.pm (blib/lib/auto/Text/NSP)
cp Measures/x2.pm blib/lib/x2.pm
cp Measures/measure2d.pm blib/lib/measure2d.pm
cp Measures/leftFisher.pm blib/lib/leftFisher.pm
cp Measures/phi.pm blib/lib/phi.pm
cp Measures/tmi.pm blib/lib/tmi.pm
cp Measures/tscore.pm blib/lib/tscore.pm
cp statistic.pl blib/script/statistic.pl
/usr/bin/perl "-MExtUtils::MY" -e "MY->fixin(shift)" blib/script/statistic.pl
cp Utils/split-data.pl blib/script/split-data.pl
/usr/bin/perl "-MExtUtils::MY" -e "MY->fixin(shift)" blib/script/split-data.pl
cp Utils/combig-script.sh blib/script/combig-script.sh
/usr/bin/perl "-MExtUtils::MY" -e "MY->fixin(shift)" blib/script/combig-script.sh
cp Utils/huge-count.pl blib/script/huge-count.pl
/usr/bin/perl "-MExtUtils::MY" -e "MY->fixin(shift)" blib/script/huge-count.pl
cp Utils/rank-script.sh blib/script/rank-script.sh
/usr/bin/perl "-MExtUtils::MY" -e "MY->fixin(shift)" blib/script/rank-script.sh
cp Utils/kocos.pl blib/script/kocos.pl
/usr/bin/perl "-MExtUtils::MY" -e "MY->fixin(shift)" blib/script/kocos.pl
cp Utils/huge-combine.pl blib/script/huge-combine.pl
/usr/bin/perl "-MExtUtils::MY" -e "MY->fixin(shift)" blib/script/huge-combine.pl
cp count.pl blib/script/count.pl
/usr/bin/perl "-MExtUtils::MY" -e "MY->fixin(shift)" blib/script/count.pl
cp Utils/rank.pl blib/script/rank.pl
/usr/bin/perl "-MExtUtils::MY" -e "MY->fixin(shift)" blib/script/rank.pl
cp Utils/kocos-script.sh blib/script/kocos-script.sh
/usr/bin/perl "-MExtUtils::MY" -e "MY->fixin(shift)" blib/script/kocos-script.sh
cp Utils/combig.pl blib/script/combig.pl
/usr/bin/perl "-MExtUtils::MY" -e "MY->fixin(shift)" blib/script/combig.pl
cp Utils/sort-bigrams.pl blib/script/sort-bigrams.pl
/usr/bin/perl "-MExtUtils::MY" -e "MY->fixin(shift)" blib/script/sort-bigrams.pl
Manifying blib/man1/statistic.pl.1p
Manifying blib/man1/split-data.pl.1p
Manifying blib/man1/huge-count.pl.1p
Manifying blib/man1/kocos.pl.1p
Manifying blib/man1/huge-combine.pl.1p
Manifying blib/man1/count.pl.1p
Manifying blib/man1/rank.pl.1p
Manifying blib/man1/combig.pl.1p
Manifying blib/man1/sort-bigrams.pl.1p
Manifying blib/man3/pmi.3
Manifying blib/man3/rightFisher.3
Manifying blib/man3/measure3d.3
Manifying blib/man3/tmi3.3
Manifying blib/man3/odds.3
Manifying blib/man3/ll3.3
Manifying blib/man3/ll.3
Manifying blib/man3/dice.3
Manifying blib/man3/x2.3
Manifying blib/man3/measure2d.3
Manifying blib/man3/leftFisher.3
Manifying blib/man3/tmi.3
Manifying blib/man3/phi.3
Manifying blib/man3/tscore.3
make[1]: Leaving directory `/var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71'
touch build-stamp
 fakeroot debian/rules binary
dh_testdir
dh_testroot
dh_clean -k
dh_installdirs
if grep ^install_vendor Makefile; then \
	/usr/bin/make install PREFIX=/var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr; \
else \
	/usr/bin/make pure_install DESTDIR=/var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp; \
fi
install_vendor :: all pure_vendor_install doc_vendor_install
make[1]: Entering directory `/var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71'
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/pmi.pm
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/rightFisher.pm
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/tmi3.pm
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/measure3d.pm
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/odds.pm
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/ll3.pm
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/ll.pm
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/dice.pm
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/x2.pm
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/measure2d.pm
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/leftFisher.pm
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/phi.pm
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/tmi.pm
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/tscore.pm
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/Text/NSP.pm
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/perl5/auto/Text/NSP/autosplit.ix
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man1/statistic.pl.1p
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man1/split-data.pl.1p
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man1/huge-count.pl.1p
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man1/kocos.pl.1p
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man1/huge-combine.pl.1p
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man1/count.pl.1p
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man1/rank.pl.1p
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man1/combig.pl.1p
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man1/sort-bigrams.pl.1p
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man3/pmi.3
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man3/rightFisher.3
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man3/measure3d.3
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man3/tmi3.3
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man3/odds.3
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man3/ll3.3
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man3/ll.3
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man3/dice.3
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man3/x2.3
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man3/measure2d.3
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man3/leftFisher.3
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man3/tmi.3
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man3/phi.3
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/share/man/man3/tscore.3
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/bin/statistic.pl
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/bin/split-data.pl
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/bin/combig-script.sh
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/bin/huge-count.pl
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/bin/rank-script.sh
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/bin/kocos.pl
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/bin/huge-combine.pl
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/bin/count.pl
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/bin/rank.pl
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/bin/kocos-script.sh
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/bin/combig.pl
Installing /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/bin/sort-bigrams.pl
*****************************************************
Installing the Ngram Statistics Package, V 0.71...
 ...into /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/local (/doc /bin /lib /man) 
Make sure that the following are in your PATH:
     /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/local/bin
     /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/local/share/perl/5.8.4
After your paths are set, run Testing/ALL-TESTS.sh to
verify that installation is ok
*****************************************************
Installing measures documentation in /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/local/doc/html
Installing program documentation in /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/local/doc/html
Installing general documentation in /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/local/doc/html
Installing man page documentation in /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/local/man/man3
Installing pod documentation in /var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71/debian/tmp/usr/local/doc/pod
make[1]: Leaving directory `/var/tmp/debaux-root/text-nsp-perl/text-nsp-perl-0.71'
dh_testdir
dh_testroot
dh_installdocs
dh_installexamples
dh_installmenu
dh_installcron
dh_installmanpages
dh_installinfo
dh_installchangelogs 
dh_link
dh_strip
dh_compress
dh_fixperms
dh_installdeb
dh_perl
dh_shlibdeps
dh_gencontrol
dh_md5sums
dh_builddeb
dpkg-deb: building package `libtext-nsp-perl' in `../libtext-nsp-perl_0.71-1_i386.deb'.
 dpkg-genchanges
dpkg-genchanges: including full source code in upload
dpkg-buildpackage: full upload (original source is included)
child exited with value 0
Command: sudo dpkg -i /var/tmp/debaux-root/text-nsp-perl/libtext-nsp-perl_0.71-1_i386.deb
Selecting previously deselected package libtext-nsp-perl.
(Reading database ... 289068 files and directories currently installed.)
Unpacking libtext-nsp-perl (from .../libtext-nsp-perl_0.71-1_i386.deb) ...
Setting up libtext-nsp-perl (0.71-1) ...
child exited with value 0
/var/lib/myfrdcsa/codebases/data/frdcsa-perl $
</pre>
  </long-description>
</system>
