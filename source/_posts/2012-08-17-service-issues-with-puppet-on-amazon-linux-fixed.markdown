---
layout: post
title: "Service Issues with Puppet on Amazon Linux - Fixed!"
date: 2012-08-17 08:39
comments: true
categories: Tech
---
Puppet has been on my list of tools to learn for a while now (and Chef and cfengine and Ansible and ...) and I finally had a chance to take it for a spin.

I started with the [Puppet Enterprise virtual machine](http://info.puppetlabs.com/download-learning-puppet-VM.html) from Puppet Labs and the excellent [Learning Puppet](http://docs.puppetlabs.com/learning/) series. Soon I had the basics down and decided to try Puppet "in the wild" on Amazon EC2 with an Amazon Linux AMI.

Installing Puppet was as easy as running `sudo yum install puppet` and setting up a module was just as easy as in the VM, but Puppet wouldn't start my service as I had instructed. My very basic httpd module looked like this:

``` ruby 
class httpd {

  package { 'httpd':
    ensure => installed,
  }

  service { 'httpd':
    ensure => running,
    enable => true,
  }

}
```

Puppet would enable the httpd service properly with `chkconfig`, but it would not start it.

I started debugging Puppet with the `-d` flag and saw this:

``` bash
[ec2-user@ip-10-252-3-70 modules]$ sudo puppet apply -de "include httpd"
...
info: Applying configuration version '1345229077'
debug: Service[httpd](provider=redhat): Executing 'ps -ef'
debug: Service[httpd](provider=redhat): PID is 26564
debug: Puppet::Type::Service::ProviderRedhat: Executing '/sbin/chkconfig httpd'
debug: Finishing transaction 70128127580220
debug: Storing state
debug: Stored state in 0.00 seconds
notice: Finished catalog run in 0.07 seconds
[ec2-user@ip-10-252-3-70 modules]$ 
```

For some reason Puppet wasn't using the service commands, but was using `ps` to look for the httpd process and deciding it was running when in fact it wasn't.

I initially thought it may have been because Puppet wasn't recognizing Amazon Linux appropriately, but `provider=redhat` indicated it was. After some googling I found a post on Stack Exchange with the question [Why can't puppet start the dropbox daemon?](http://stackoverflow.com/questions/9202574/why-cant-puppet-start-the-dropbox-daemon). It turns out Puppet versions prior to 2.7 don't use the `/etc/init.d/service status` command by default and the Puppet version from the Amazon Linux package repository was version 2.6.16. This was explained in the Puppet tutorial ([here](http://docs.puppetlabs.com/learning/ordering.html)) but I had glossed over it.

I added `hasstatus => true` to my module and it worked.

``` bash
[ec2-user@ip-10-252-3-70 modules]$ sudo puppet apply -de "include httpd"
...
info: Applying configuration version '1345229517'
debug: Service[httpd](provider=redhat): Executing '/sbin/service httpd status'
debug: Puppet::Type::Service::ProviderRedhat: Executing '/sbin/chkconfig httpd'
debug: Service[httpd](provider=redhat): Executing '/sbin/service httpd start'
debug: Puppet::Type::Service::ProviderRedhat: Executing '/sbin/chkconfig httpd'
notice: /Stage[main]/Httpd/Service[httpd]/ensure: ensure changed 'stopped' to 'running'
debug: Finishing transaction 70256658307520
debug: Storing state
debug: Stored state in 0.00 seconds
notice: Finished catalog run in 0.25 seconds
```

My module now looks like this and successfully installs and starts httpd on Amazon Linux.

``` ruby 
class httpd {

  package { 'httpd':
    ensure => installed,
  }

  service { 'httpd':
    ensure => running,
    enable => true,
    hasstatus => true,
  }

}
```
