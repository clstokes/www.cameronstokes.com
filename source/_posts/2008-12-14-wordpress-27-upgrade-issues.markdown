--- 
layout: post
title: Wordpress 2.7 Upgrade Issues
categories: Tech
---
I decided to upgrade to <a href="http://codex.wordpress.org/Version_2.7">Wordpress 2.7</a> despite my usual reservations in performing any type of upgrade.  Unfortunately, I was correct in my reservations and had a few issues during the upgrade.  Despite the very manual process of <a href="http://codex.wordpress.org/Upgrading_WordPress_Extended">performing backups and installing the new version</a> I still ran into some issues that I may have anticipated but nevertheless ran into.

After changing the <a href="http://codex.wordpress.org/Editing_wp-config.php">wp-config.php</a> file for my database I let the Wordpress script make the necessary database changes and then logged into the administration site.  I was quite impressed by the <a href="http://wordpress.org/development/2008/10/the-visual-design-of-27/">new interface</a> but my enthusiasm soon faded when I tried to access my blog and was presented with a very unfriendly blank page.  After reading <a href="http://wordpress.org/support/topic/224460">several different forum posts</a> regarding various reasons for the blank pages experiences after upgrading, I went to the Themes page in the administration portion of the application and saw a message that my current theme wasn't supported by 2.7 and that it had been disabled.  I was now back to the default Wordpress theme.  After googling I found that the <a href="http://wpthemes.info/misty-look/">MistyLook</a> theme I had been using didn't support the new Wordpress version, at least <a href="http://wprocks.com/forums/comments.php?DiscussionID=1602">not yet</a>.

Having the default theme I was able to see that the photos I had uploaded in my previous posts, weren't working.  This was easy to fix as I had actually followed the backup instructions above and just copied the <em>uploads</em> folder back into the new install.  The next hiccup I rant into was that all of my plugins had disappeared.  I copied the <em>plugins</em> folder over from my backup, re-activated them and everything seemed fine, except I had to re-enter my site keys for <a href="http://wordpress.org/extend/plugins/wp-recaptcha/">WP-reCAPTCHA</a>.

Now that everything seemed to be functional, I started looking for a new theme.  I settled on the <a href="http://wordpress.org/extend/themes/big-city">Big City theme</a> which I actually like better than my previous theme.

<img class="size-full wp-image-285" title="Big City Screenshot" src="http://cameronstokes.com/wp-content/uploads/2008/12/big-city-screenshot.png" alt="Big City Theme" width="300" height="225" />

I removed the default logo and would like to eventually replace the skyline rendering with perhaps a rendering of the <a href="http://en.wikipedia.org/wiki/Atlanta,_Georgia">Atlanta</a> skyline.  We'll have to see how good my Photoshop skills are.

All in all the upgrade didn't go too bad.  I didn't lose any data, only spent about an hour on the upgrade and fixing the issues, and am now on the latest and greatest version with a cool new theme.  Some of the issues were probably due to me reading the upgrade instructinos too quickly but the upgrade process could probably be streamlined by the Wordpress developers.  Hopefully I won't have to upgrade again for a while.
