--- 
layout: post
title: Compressed Content, Amazon S3, and CloudFront
comments: true
categories: Tech
---
I recently published a static website to <a href="http://aws.amazon.com/s3/">Amazon Simple Storage Service (Amazon S3)</a> and started looking for ways to improve performance. There weren't any inherent performance problems using S3 by itself but I wanted to squeeze out every bit of performance I could. I first looked at typical website performance techniques such as <a href="http://developer.yahoo.com/performance/rules.html#minify">minifying files</a>, <a href="http://developer.yahoo.com/performance/rules.html#css_top">putting stylesheets at the top</a>, and <a href="http://developer.yahoo.com/performance/rules.html#js_bottom">scripts at the bottom</a>, but wanted to keep going. My next steps were to <a href="http://developer.yahoo.com/performance/rules.html#gzip">GZIP components</a> and <a href="http://developer.yahoo.com/performance/rules.html#cdn">use a content delivery network</a>. Fortunately Amazon makes both of these easy with S3 and <a href="http://aws.amazon.com/cloudfront/">Amazon CloudFront</a>.

Storing GZIP content on S3 takes a mere 3 steps:

1. GZIP content
2. Upload to S3
3. Set metadata on content

For my small site I ran GZIP on all of my files manually at the command-line, but this could be easily scripted. From the command-line it looks like this:
``` plain 
$ gzip -c site/index.html &gt; compressed/index.html
$ gzip -c site/_packed/application.js &gt; compressed/_packed/application.js
$ gzip -c site/_packed/application.css &gt; compressed/_packed/application.css 
```
After uploading the files to S3 I needed to set their metadata to indicate they're GZIP encoded. In the <em>S3</em> tab within the Amazon Management Console, this is done by selecting each object and going to the <em>Metadata</em> tab on an object's properties and adding the <em>Content-Encoding</em> key and value shown here:

{% img /wp-content/uploads/2011/07/metadata-gzip.png 466 204 metadata-gzip %}

At this point you can test your compressed content by opening one of your files in your browser and making sure it renders appropriately.

Distributing content on the Amazon CloudFront CDN takes even fewer steps:

1. Setup CloudFront distribution
2. Setup DNS CNAME record (such as www.example.com)

Back in the AWS Management Console, in the <em>CloundFront</em> tab, click <em>Create Distribution</em> and select your S3 bucket from above as your origin. Enter the <em>CNAME</em> you plan to use and your <em>Default Root Object</em> and click through the rest of the wizard. At this point Amazon distributes your configuration to its CloudFront network, which seems to take about 5-10 minutes on average. Meanwhile, Amazon will assign your CloudFront <em>Domain Name</em> which you should set  CNAME  to in your DNS provider. You're done...

At this point  your website  content is compressed, stored in a bucket on S3 and distributed on CloudFront. If you use Amazon's <a href="http://aws.amazon.com/route53/">Route53</a> DNS service, your entire site is running in the cloud.

Cursory tests show significant improvements across each level of changes:

{% img /wp-content/uploads/2011/07/cloudfront-response-times.png 504 329 cloudfront-response-times %}

To summarize, hosting a static website on S3 and CloudFront from Amazon Web Services is not only easy but also can drastically improve performance of your site.

<em>(If you use Amazon's Route53 DNS service, I find <a href="http://www.interstate53.com/">www.interstate53.com</a> to be the best management interface out there currently.)</em>
