---
layout: post
title: "Overriding Hibernate in a Grails Application"
date: 2012-08-13 21:30
comments: true
categories: Tech
---
I was working on a proof of concept application recently in which I needed to use an internal middleware library to access some backend services. As I usually do, I jumped to Grails for my POC and worked to pull in our middleware library. After struggling with many other issues unrelated to Grails, I ended up with some incompatibilities between the Hibernate version included in Grails and the Hibernate version in our library. On a whim, I removed the Grails version from the packaged application and was able to get things up and running.

If you need to do remove Hibernate from your generated war file, add the following lines to the bottom of your _./application-name/grails-app/conf/BuildConfig.groovy_ file:

```
grails.war.resources = { stagingDir ->
  delete( file: "${stagingDir}/WEB-INF/lib/grails-hibernate-2.0.3.jar" )
}
```

More information on customizing the Grails build can be found [here](http://grails.org/doc/latest/guide/single.html#buildCustomising).

### _Warning!_

This can potentially cause other issues in your application as swapping dependency versions can cause other incompatibilities to surface. Having said that, in my case it worked and it may work for you too.
