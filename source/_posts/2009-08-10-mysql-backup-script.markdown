--- 
layout: post
title: MySQL Backup Script
categories: Tech
---
I've posted a <a href="http://en.wikipedia.org/wiki/Mysql">MySQL</a> backup script to the <a href="http://cameronstokes.com/lab/">lab</a> for anyone that is interested.  The script will backup all MySQL databases and allows you to configure the filename and path for backups and how long to keep older backups in number of days.  I have mine set to run via <a href="http://en.wikipedia.org/wiki/Cron">cron</a> every night at midnight and to retain 31 days of files so that I can revert to any day within the past month should anything happen.

It's a simple script but it gets the job done.  Hope you find it helpful.  You can find the script <a href="http://lab.cameronstokes.com/bash/mysql-backup/">here</a>.
