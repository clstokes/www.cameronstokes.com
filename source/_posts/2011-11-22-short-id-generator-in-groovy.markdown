---
layout: post
title: "Short ID Generator in Groovy"
date: 2011-11-22 22:08
comments: true
categories: Tech
---
On my latest side project I needed to create IDs for items in a database, but without using a database sequence or artificial counter. I generally would use a UUID but for this project I wanted to minimize the size of the identifier to save on space and make the IDs usable similar to a URL shortener service.

Here's what I whipped up in Groovy:
``` java 
class IDUtils {

  def NUMBER_OF_CHARS = 5
  def CHARS = ('0'..'9') +
          ('a'..'h') +
          ('j'..'k') +
          ('m'..'z') +
          ('A'..'H') +
          ('H'..'H') +
          ('M'..'Z')

  def random = new Random()

  def generateID() {
    def id = ""
    for ( i in 1..NUMBER_OF_CHARS ) {
      id += CHARS[random.nextInt(CHARS.size())]
    }
    return id
  }

}
```
_CHARS_ specifies the available character set and _NUMBER_OF_CHARS_ specifies the length of the ID generated. I specifically omit _i_ and _l_ to cut down on confusion and readability issues across different fonts. The output of _generateID()_ is an ID in the form of 9reaZ, CfrDS, a22mE, etc. With this character set and 5 characters in length there are 601,692,057 combinations available.
