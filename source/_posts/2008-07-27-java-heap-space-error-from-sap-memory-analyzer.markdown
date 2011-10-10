--- 
layout: post
title: "\"Java heap space\" error from SAP Memory Analyzer"
categories: Tech
---
I ran into a fairly ironic error message when using the <a href="http://www.eclipse.org/projects/project_summary.php?projectid=technology.mat">SAP Memory Analyzer</a> to do some memory analysis of one of our applications at work.  The reason given for the error was "Java heap space".

<img class="size-full wp-image-4" title="sap-memory-analyzer-java-heap-space" src="http://cameronstokes.com/wp-content/uploads/2008/07/sap-memory-analyzer-java-heap-space.png" alt="&quot;Java heap space&quot; error from SAP Memory Analyzer." width="500" height="290" />

The heap dump I was trying to analyze was around 1 gigabyte so I took the error to mean that the process ran out of memory.  I finally figured out how to change the memory settings for the Mac OS X package by finding how to do the same thing for Eclipse (I'm only 2 months in using OS X as my primary OS).

In any case, to increase the heap size available to the program you have to edit the MemoryAnalyzer.ini file in the  ./MemoryAnalyzer/Contents/MacOS/ folder.  You can do this through Finder by right-clicking on the MemoryAnalyzer package and clicking Show Package Contents.

Here's what my MemoryAnalyzer.ini looked like after the change.
<pre>-showsplash
org.eclipse.platform
-vmargs
-Xdock:icon=../Resources/Eclipse.icns
-XstartOnFirstThread
-Xms40m
-Xmx1024m
-XX:MaxPermSize=256m
-Dorg.eclipse.swt.internal.carbon.smallFonts</pre>
Changing the maximum heap setting value -Xmx to 1024m allowed me to open the heap dump without a problem.
