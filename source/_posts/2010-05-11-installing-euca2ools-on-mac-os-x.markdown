--- 
layout: post
title: Installing Euca2ools on Mac OS X
categories: Tech
---
Having been bit by the cloud bug, I recently looked into the cloud computing software <a href="http://en.wikipedia.org/wiki/Eucalyptus_%28computing%29">Eucalyptus</a>.  Using the <a href="http://www.ubuntu.com/cloud/private">Ubuntu Enterprise Cloud</a> distribution I setup a controller and a couple nodes and then went to install <a href="http://open.eucalyptus.com/wiki/Euca2oolsGuide_v1.1">Euca2ools</a> on my Macbook.  Following the instructions <a href="http://open.eucalyptus.com/wiki/Euca2oolsSourceInstall">here</a>, I soon ran into an issue.  Here is the error I received:
``` 
stokesc-mbp:euca2ools-1.2 stokesc$ sudo make
...
Processing dependencies for euca2ools==1.0
Finished processing dependencies for euca2ools==1.0
install: root: Invalid argument
make: *** [install] Error 67
stokesc-mbp:euca2ools-1.2 stokesc$ 
```
A quick internet search didn't reveal too much but I soon found my way into the <em>MakeFile</em> and noticed the group for the install command seemed off.  Knowing Mac OS X's ancestry is <a href="http://en.wikipedia.org/wiki/Berkeley_Software_Distribution">BSD</a> and from my past experience with OpenBSD, I knew the <em>root</em> group did not exist in the BSD operating system and was in fact named <em>wheel</em>.  I changed all references to the group <em>root</em> (the -g option), but left the owner references alone (the -o option) and Euca2ools was soon installed.  Here is the snippet from my new MakeFile:
``` 
...
	@install -g wheel -o root -m 755 -d $(PREFIX)/bin
	@install -g wheel -o root -m 755  bin/* $(PREFIX)/bin/
	@install -g wheel -o root -m 755 -d $(PREFIX)/man/man1
	@if [ -d $(MANDIR) ]; then install -g wheel -o root -m 644  $(MANDIR)/* $(PREFIX)/man/man1; fi
	@if [ -d $(BASH_COMPLETION) ]; then install -g wheel -o root -m 644  $(UTILDIR)/* $(BASH_COMPLETION); fi
...
 
```
I opened bug <a href="https://bugs.launchpad.net/eucalyptus/+bug/558420">558420</a> with the Eucalyptus project to address this.  As of this post, this issue affects version 1.2 of the Euca2ools download and likely previous versions.
