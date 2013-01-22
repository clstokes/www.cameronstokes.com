---
layout: post
title: "Using Gradle to Build CoffeeScript"
date: 2013-01-21 16:16
comments: true
categories:
---
Here's a simple [Gradle](http://www.gradle.org/) script for building and cleaning [CoffeeScript](http://coffeescript.org/) with two tasks: _coffee_ and _clean_.
```
import org.gradle.plugins.javascript.coffeescript.CoffeeScriptCompile

apply plugin: 'coffeescript-base'

repositories {
  mavenCentral()
  mavenRepo name: "Gradle", url: "http://repo.gradle.org/gradle/repo"
}

def sourceDir = "src/main/coffeescript"
def buildDir = "src/main/webapp/compiled"

task clean( type: Delete, overwrite: true ) {
  delete buildDir
}

task coffee( type: CoffeeScriptCompile ) {
  source fileTree( sourceDir )
  destinationDir file( buildDir )
}

```
