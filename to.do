(setup automatic downloads of wikileaks/cryptome/etc datasets)

(12:33:28 <aindilis> I was thinking of writing a BDI agent that downloads
 software from the web and packages it for Debian
 12:34:13 <aindilis> so for instance, in academician, you can assert that you
 are interested in a topic
 12:35:03 <aindilis> when that topical assertion is made to the KB, the Jason
 agent should trigger on it and launch my scripts for searching for
 software for a topic.  (these need to be fixed because Yahoo closed
			 their search interface)
 12:35:29 <aindilis> it should then take the results and use radar to download
 them, create the directories (it filling out all the answers to radar's
			       questions)
 12:35:54 <aindilis> and then the icing on the cake is a much fuller BDI agent
 for generating packages according to Debian standards
 12:36:03 <aindilis> then add it to the repo
 12:36:24 <aindilis> this entire process more or less works now, but requires a
 lot of manual oversight, it would be nice to automate the full process
 12:36:43 <aindilis> then messages should be sent to the user that various
 systems were obtained, and entries entered into the software ontology
 #chiglug>
 )