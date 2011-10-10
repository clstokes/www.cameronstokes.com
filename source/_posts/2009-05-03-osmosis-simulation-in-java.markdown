--- 
layout: post
title: Osmosis simulation in Java
categories: Tech
---
Back in 2005, I took an <em>Applications Development</em> class at <a href="http://www.spsu.edu/">Southern Polytechnic State University (SPSU)</a> while working towards my Bachelor's of Science in Information Technology (BSIT).  At the time the class was taught with <a href="http://en.wikipedia.org/wiki/Java_(programming_language)">Java</a> (they've since switched to <a href="http://en.wikipedia.org/wiki/C_Sharp_(programming_language)">C#</a> unfortunately) and having worked in Java at <a href="http://en.wikipedia.org/wiki/Intercontinental_Hotels_Group">InterContinental Hotels Group (IHG)</a> for a few years already I convinced the professor to let me skip the classes, show up for the exams, and work on the class project at my leisure.  The class project was to develop a computer simulation of <a href="http://en.wikipedia.org/wiki/Osmosis">osmosis</a>.  This is what I put together:

<img class="size-full wp-image-617" title="osmosis-simulation-in-java" src="http://cameronstokes.com/wp-content/uploads/2009/05/java-osmosis.png" alt="Osmosis" width="553" height="270" />

I wrote the application using <a href="http://en.wikipedia.org/wiki/Abstract_Window_Toolkit">AWT</a> and <a href="http://en.wikipedia.org/wiki/Swing_(Java)">Swing</a> and allowed the user to vary the size and number of molecules and the number of pores in the center membrane.  Upon hitting <em>Start</em> the molecules would start bouncing around the pane and pass through the membrane thus demonstrating osmosis.  For extra credit I <a href="http://en.wikipedia.org/wiki/Internationalization_and_localization">internationalized</a> the application with resource bundles for English and Spanish.  The teacher really got a kick out of that as I remember and I ended up getting an A in the class.  Looking back, the code doesn't look too bad, though I'm sure there are better practices and design for Swing applications.  My forte has always been web applications.

Click <a href="http://cameronstokes.com/misc/projects/osmosis/osmosis.jnlp">here</a> for the <a href="http://en.wikipedia.org/wiki/Java_Web_Start">Java Web Start</a> shortcut to try out the application.  You can download the full source code <a href="http://cameronstokes.com/misc/projects/osmosis/osmosis.tar.gz">here</a>.
