--- 
layout: post
title: Grails and 204 "No Content" responses
categories: Tech
---
Hacking away on a project recently I decided to use the lesser-known HTTP status code 204 <em>No Content</em>. A 204 <em>No Content</em> indicates a successful request, but also that there's no content to return. I'm using 204's for responding to AJAX calls to server-side resources for which no content is needed to return. Technically I could use a 200 status code but I want to be as semantically correct as possible.

Using <a href="http://grails.org/">Grails</a> for the project it was super simple to return 204 from my controller. Here's how you do it:
``` plain 
class ResourceController {

  def update = {

    // service.update params

    render status: 204

  }

} 
```
That's it.
