--- 
layout: post
title: Using svnversion from Ant
comments: true
categories: Tech
---
At work we use a combination of <em><a href="http://en.wikipedia.org/wiki/Subversion_%28software%29">Subversion (svn)</a></em>, <em><a href="http://en.wikipedia.org/wiki/Apache_Maven">Maven</a></em>, and <em><a href="http://en.wikipedia.org/wiki/Apache_Ant">Ant</a></em> to build and deploy our applications  and integrate the <em>svn</em> revision number into our deployment packages.  As an example, if we're packaging our <em>callcenter</em> application our build scripts will create a <em>callcenter-7175.jar</em> package.  This makes it easy for us to upgrade and rollback between versions as needed.

The   <em>svnversion</em> program makes it easy to get the revision number of your working copy by simply executing the program:
<pre>macbookpro:rel-091105 stokesc$ svnversion
7175</pre>
To use this from <em>Ant</em> we can use the <a href="http://ant.apache.org/manual/CoreTasks/exec.html">exec</a> task.  The example below will execute <em>svnversion</em> and capture its output into the <em>Ant</em> property <em>repository.revision</em> which is used later on in our build script:
``` xml 
<?xml version="1.0" encoding="ISO-8859-1"?>
<project name="Build Script" default="make" basedir=".">

    <target name="make">

        <!-- Get current working directory. -->
        <exec executable="pwd" outputproperty="dir.root" />

        <!-- Get subversion revision number. -->
        <exec executable="svnversion" outputproperty="repository.revision" />

        <echo message="Repository revision is ${repository.revision}" />

    </target>

</project> 
```
This worked well for us for a few years but when we needed to build from an older branch the revision number wasn't representative of the last revision in the branch.  Looking at the options for <em>svnversion</em> I found passing <em>-c</em> will return the revision number of the last change rather than the current revision which is what we really wanted.
<pre>macbookpro:rel-091105 stokesc$ svnversion -c
1:6985</pre>
You can see the difference in revision numbers from this command versus the one above, but this still isn't perfect due to the starting revision number that's been added.  A little change to our <em>Ant</em> script can strip this off for us.  Here we use the <a href="http://ant.apache.org/manual/CoreTypes/redirector.html">redirector</a> and <a href="http://ant.apache.org/manual/CoreTypes/filterchain.html">filterchain</a> types and a <a href="http://en.wikipedia.org/wiki/Regular_expression">regular expression</a> to modify the output.
``` xml 
<?xml version="1.0" encoding="ISO-8859-1"?>
<project name="Build Script" default="make" basedir=".">

    <target name="make">

        <!-- Get current working directory. -->
        <exec executable="pwd" outputproperty="dir.root" />

        <!-- Get subversion revision number. -->
        <exec executable="svnversion" outputproperty="repository.revision">
            <!-- Specify '-c' to get last changed rather than current revisions. -->
            <arg value="-c" />
            <!-- Use redirector/filterchain to parse output.
                 svnversion -c will return output in format [initial]:[current]
                 and we want to strip off [initial]: -->
            <redirector>
                <outputfilterchain>
                    <tokenfilter>
                        <replaceregex pattern="[0-9]+\:" replace="" />
                    </tokenfilter>
                </outputfilterchain>
            </redirector>
        </exec>

        <echo message="Repository revision is ${repository.revision}" />

    </target>

</project> 
```
We're now able to go back and package older versions of our application with a true indication of their <em>svn</em> revision.
