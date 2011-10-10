--- 
layout: post
title: PHP on AWS Elastic Beanstalk
categories: Tech
---
The latest service offering from Amazon Web Services is <a href="http://aws.amazon.com/elasticbeanstalk/">AWS Elastic Beanstalk</a>, allowing companies to deploy applications to Amazon's cloud and let Amazon handle deployment and scaling of infrastructure automatically.

From Amazon:
<blockquote>You simply upload your application, and Elastic Beanstalk automatically handles the deployment details of capacity provisioning, load balancing, auto-scaling, and application health monitoring.</blockquote>
While Amazon claims they're working on other platforms, initially Beanstalk only supports Java applications deployed in the <a href="http://tomcat.apache.org/">Apache Tomcat 6</a> container. However...using <a href="http://quercus.caucho.com/">Quercus</a>, a "100% Java implementation of PHP 5" from <a href="http://caucho.com/">Caucho</a>, we can run PHP using AWS Elastic Beanstalk. All it takes is setting up a simple <a href="http://maven.apache.org/">Maven</a> project.

The first step is to setup the Caucho Maven repository and our dependencies in our POM:
``` xml 
 <dependencies>
	<dependency>
		<groupId>com.caucho</groupId>
		<artifactId>resin</artifactId>
		<version>4.0.14</version>
	</dependency>
</dependencies>

<repositories>
	<repository>
		<id>caucho</id>
		<url>http://caucho.com/m2/</url>
		<releases>
			<enabled>true</enabled>
		</releases>
		<snapshots>
			<enabled>false</enabled>
		</snapshots>
	</repository>
</repositories>
```
For this demo, I used the <em>web.xml</em> and PHP files from Caucho's Quercus download and added a <em>phpinfo.php</em> page to show <em>phpinfo()</em> output. Here's what our Maven <em>webapp</em> directory structure looks like:

{% img /wp-content/uploads/2011/01/maven-webapp.png 613 280 maven-webapp %}

Running <em>mvn package</em> produces a war file that can be deployed to AWS Elastic Beanstalk without any further modifications. After waiting a few minutes for the EC2 instance to start up, here's our <em>phpinfo.php</em> file running on AWS:

{% img /wp-content/uploads/2011/01/aws-beanstalk-phpinfo.png 765 800 aws-beanstalk-phpinfo %}

That's it...we have PHP running on AWS Elastic Beanstalk. It could not have been easier. Chances are Amazon will add PHP support down the road but until then you can run your own PHP applications using Quercus.

The full project code can be downloaded on GitHub at <a href="https://github.com/clstokes/aws-elastic-beanstalk-php">https://github.com/clstokes/aws-elastic-beanstalk-php</a>.
