--- 
layout: post
title: Fast Twitter Widget for Wordpress
comments: true
categories: Tech
---
<em><strong>tl;dr version...</strong> for loading your Twitter stream on your Wordpress blog, <a href="http://wordpress.org/extend/plugins/reliable-twitter/">Reliable Twitter</a></em><em> is a fast and </em><em>reliable way to do it without impacting performance and usability of your blog.</em>

I noticed my blog  performing slowly recently and, knowing that <a href="http://www.useit.com/alertbox/response-times.html">performance impacts site engagement</a>, I set out to fix it.

In particular, the main column loaded quickly but my Twitter stream in the right column would hang.  A quick look showed that the Twitter widget I was using, <a href="http://wordpress.org/extend/plugins/twitter-widget-pro/">Twitter Widget Pro</a>, was loading the stream on the server and that response times from Twitter were likely the culprit. I began looking for an AJAX-based widget knowing that loading the data asynchronously could help initial page load time without impacting usability of my blog. After too much searching, I found an AJAX-based widget, coincidentally called <a href="http://wordpress.org/extend/plugins/reliable-twitter/">Reliable Twitter</a>, that fit the bill. After installing Reliable Twitter, I immediately noticed page loads were quicker and after a bit of time <a href="http://pingdom.com/">Pingdom</a> confirmed this.

{% img /wp-content/uploads/2011/06/pingdom-cameronstokes-com.png 563 206 pingdom-cameronstokes-com %} 
