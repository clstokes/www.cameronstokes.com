--- 
layout: post
title: Global Website Performance with Amazon EC2
comments: true
categories: Tech
---
{% img right /wp-content/uploads/2011/01/ec2-china-response-times-crop.png 141 100 ec2-china-response-times-crop %}

Recently I've been looking at options to improve the performance of our websites in certain regions of the world, specifically China. While there are an infinite number of ways to improve performance a pretty basic one is to reduce the physical distance between users and the website. This means if our users are in China, we need to run our website in China or as close as we can get.

To get a feel for how our website would perform if it was hosted in region I setup a test to compare a U.S. hosted website and an in-region hosted website, in this case in <a href="http://aws.amazon.com/">Amazon Web Services EC2's</a> <a href="http://aws.amazon.com/about-aws/whats-new/2010/04/29/announcing-asia-pacific-singapore-region/">Singapore location</a>. Throwing another hat in the ring, I decided to test the same U.S. website but delivered via <a href="http://www.akamai.com/">Akamai</a>. For those who don't know, Akamai has a global <a href="http://en.wikipedia.org/wiki/Content_delivery_network">content delivery network</a> (CDN) providing accelerated network delivery for static and dynamic content.  This gives us the following test resources:

1. A static resource  served from the East coast of the U.S.
2. A static resource served from the East coast of the U.S. but delivered by Akamai.
3. A static resource served from Amazon's Asia Pacific region in  Singapore.

The resource is the same static 30KB image in each case. Using a monitoring service, I sampled each resource every 5 minutes from Beijing, Hong Kong, and Shanghai. The test ran for a little over 3 weeks. Without further ado, here are results...

### Response Times
{% img /wp-content/uploads/2011/01/ec2-china-response-times-e1296404574953.png 479 289 ec2-china-response-times %}

Average response times over the 2 weeks  were:

1. Origin - <em>3.49 seconds.</em>
2. Akamai - <em>1.73 seconds.</em>
3. EC2 - <em>0.66 seconds.</em>

From these numbers you can see how much of an impact distance can have and even more so how much of a positive impact Akamai can have on delivering your content. In this case the physical distance "as the crow flies" between the origin and the same content through Akamai is the same but Akamai can greatly increase performance over the "normal internet".

### Availability
{% img /wp-content/uploads/2011/01/ec2-china-availability-e1296404625651.png 478 288 ec2-china-availability %}

Average availability over the 2 weeks  were:

1. Origin - <em>99.90%</em>
2. Akamai - <em>99.25%</em>
3. EC2 - <em>99.92%</em>

These numbers might seem low for serving a static image but are typical of what we've seen for China. Akamai's availability is surprising as its the lowest of the lot.

### Conclusion
The test results certainly support the hypothesis that reducing the distance between a website and its users will result in better performance. This is a function of the "speed of light problem" and reducing the number of hops between the two points. Reducing the number of hops would also improve availability by reducing the points of failure in between.

To summarize, no big surprises here, moving your applications and data closer to your customers can substantially improve the performance of your applications. Amazon's  availability regions in North America, Europe, and Asia Pacific greatly reduce the barrier to deploying your applications globally and making for a better customer experience. This, of course, assumes your applications can be deployed in multiple locations and not impact data or transaction integrity...this is easier said than done. If you absolutely can't move host your applications globally, Akamai can certainly help deliver your website faster. I expect we would see an even better improvement combining Akamai and an in-region hosted application.
