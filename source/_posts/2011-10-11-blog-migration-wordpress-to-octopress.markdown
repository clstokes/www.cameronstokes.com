---
layout: post
title: "Blog Migration - Wordpress to Octopress"
date: 2011-10-11 21:11
comments: true
categories: Tech
---
I've used WordPress since I first started my blog, but recently started looking for 
alternatives. I found myself not needing many of the features provided by WordPress 
and not wanting to manage Apache, PHP, and MySQL through upgrades, patches, etc.
Finally, inspired by the post [No Server Required - Jekyll & Amazon S3](http://www.allthingsdistributed.com/2011/08/Jekyll-amazon-s3.html), I set out to 
find something new. In my searching I stumbled onto [Octopress](http://octopress.org/).

I searched for a tool to help migrate my WordPress blog to Octopress and found a couple 
different options. I settled on a script from [@elvvin](https://twitter.com/#!/elvvin) 
that used an XML export from WordPress and created the appropriate [Jekyll](http://jekyllrb.com/)/Octopress format.
With some tweaks I got it to convert my code snippets, images, and post categories. I had to 
make some minor [Markdown](http://daringfireball.net/projects/markdown/) 
fixes to certain posts snippets, but after an hour's worth of work, everything was cleaned up and ready to go. 
My changes to @elvvin's script are on GitHub at [wordpress-octopress-migration](https://github.com/clstokes/wordpress-octopress-migration).

As of this post, my blog is now hosted on [Amazon S3](http://aws.amazon.com/s3/).
