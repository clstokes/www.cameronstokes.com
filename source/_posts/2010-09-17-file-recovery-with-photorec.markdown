--- 
layout: post
title: File recovery with PhotoRec
categories: Tech
---
Last Fall, Rhonda and I spent a week in Panama (the country, not the city in Florida). We had an awesome time...saw the canal, the five-hundred year old ruins of Panama Viejo, shopped in Casco Viejo, got lost driving in Ciudad de Panamá more times than I'll openly admit, had many great meals, and spent a couple days at the end of the trip relaxing at Playa Bonita. All in all it was a fantastic trip.

We took tons of photos all of which I promptly (but accidentally) deleted when we returned home. In my defense I had just received an SSD for my laptop and was giddy to install it. In performing backups of all my known data and files I forgot the Panama photos. Fortunately I realized what I had done before doing a full wipe of the old drive or writing much new data to it.
In looking for ways to recover the files I found an application called <a href="http://www.cgsecurity.org/wiki/PhotoRec">PhotoRec</a>, an open source multi-platform application for recovering lost files.

According to the author, Christophe GRENIER, "PhotoRec ignores the file system and goes after the underlying data, so it will still work even if your media's file system has been severely damaged or reformatted." Given that, PhotoRec doesn't allow you to target specific files or directories, it essentially recovers all files of any given type and dumps them into flat folders. In my case it recovered all JPEG files, including our Panama photos and all other photos on the old drive. A quick bash script helped me find the relevant ones and rename them. It was after I recovered all of them that I told Rhonda what had happened.

Here's a photo of my goofy face I did not want to lose:

{% img /wp-content/uploads/2010/08/panama-canal.jpg 480 321 panama-canal %}

The rest of the recovered photos are <a href="http://cameronstokes.com/gallery/panama-november-2009/">here</a>.
