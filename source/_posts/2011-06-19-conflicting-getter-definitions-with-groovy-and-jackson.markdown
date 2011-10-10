--- 
layout: post
title: Conflicting getter definitions with Groovy and Jackson
categories: Tech
---
I've been piecing together <em><a href="http://groovy.codehaus.org/">Groovy</a></em> and <a href="http://jackson.codehaus.org/"><em>Jackson JSON Processor</em></a> for a recent project (both making the project a breeze to get up and running) and quickly ran into an exception that at first glance may be a bit confusing but the fix was quite simple. The exception was:
``` plain 
 java.lang.IllegalArgumentException: Conflicting getter definitions for property "error": pix.Response#isError(0 params) vs pix.Response#getError(0 params)
	at ... 
```
The reason for the exception is that Groovy automatically generates <em>isProperty()</em> and <em>getProperty()</em> methods for <em>boolean</em> properties on beans. Groovy is a little too clever in this case and Jackson gives up when it sees both.

Assuming a simple Groovy bean:
``` java 
 public class GroovyBean {

  boolean error = false
  String name

} 
```
The Groovy compiler really turns this into:
``` java 
 public class GroovyBean {

  boolean error = false
  String name

  def getError() {
    return error
  }

  def isError() {
    return error
  }

  ...

} 
```
The fix is to explicitly define a <em>getError()</em> method in our <em>GroovyBean</em> class. This way the Groovy compiler won't automatically generate both getters. (Unfortunately, the Groovy compiler still generates <em>getError() </em>if you define <em>isError()</em> so we're stuck with <em>getError().)</em> Our new GroovyBean would look like this:
``` java 
 public class GroovyBean {

  boolean error = false
  String name

  def getError() {
    return error
  }

  ...

} 
```
<em></em> After this change our GroovyBean is serialized into this:
<pre>{"name":"","error":true}</pre>
I like simple fixes.
