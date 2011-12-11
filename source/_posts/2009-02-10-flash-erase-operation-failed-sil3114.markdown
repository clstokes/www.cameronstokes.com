--- 
layout: post
title: "\"Flash erase operation failed\" with Syba SD-SATA-4P (Sil3114)"
comments: true
categories: Tech
---
### Background
I've been needing to upgrade my home fileserver for a while and finally broke down and bought some parts.  Being afraid of losing my data, I decided I'd move to <a href="http://en.wikipedia.org/wiki/OpenSolaris">OpenSolaris</a> so I could take advantage of the extra features <a href="http://en.wikipedia.org/wiki/ZFS">ZFS</a> has to keep my bits safe.  One of the first issues I encountered was that the 2 <a href="http://www.promise.com/product/product_detail_eng.asp?product_id=139">Promise SATA300 TX4</a> cards I had in my computer weren't supported in OpenSolaris.  After some googling I found that the <a href="http://www.syba.com/Product/Info/Id/34">Syba SD-SATA-4P</a> SATA controller, based on the <a href="http://www.siliconimage.com/products/product.aspx?pid=28">Sil3114 chipset</a> from <a href="http://en.wikipedia.org/wiki/Silicon_Image">Silicon Image</a>, available on <a href="http://www.newegg.com/Product/Product.aspx?Item=N82E16815124020">Newegg</a> was supported as long as the non-RAID BIOS was installed on the card.
### The Issue
After receiving it from Newegg, I fired up the <a href="http://www.sun.com/bigadmin/hcl/hcts/device_detect.jsp">Sun Device Detection Tool</a> to see if it was reported as supported.  It was not, but having read the reviews on Newegg I knew I needed to install the non-RAID BIOS on the card.  I downloaded the 5.4.0.3 version from the Silicon Imaging site (<a href="http://www.siliconimage.com/support/searchresults.aspx?pid=28&cat=15">download here</a>) and realized I needed either a DOS boot disk or a Windows machine from which I could update it.  Having neither, I pulled out one of the older computers from my closet, installed Windows XP, and proceeded to install the card's drivers.  Once that was complete I tried to flash the non-RAID BIOS, but received a pretty nasty error message:
<pre>Flash erase operation failed.</pre>
Given how finicky BIOS updates can be, I was afraid I had bricked the card.  I tried the RAID bios and it flashed without an issue.  I decided to try the first rule in troubleshooting a computer issue, reboot.  After rebooting I was still having the issue, I tried a few more times, read a few more posts online, checked the Syba website which gave me nothing.
### The Solution
About to give up hope I re-read the readme that came with the download and noticed this line:
<pre>Ensure that a SATA device is plugged into a 3114 SATA port.</pre>
I remember reading the line earlier but brushed it off, figuring that couldn't really be required.  Having tried everything else, I shutdown, plugged in a SATA drive, started back up and was able to flash the BIOS without issue.  I ran the Sun Device Detection Tool again and the card was recognized and shown as being supported.  I'm still curious why there needs to be a drive connected in order to flash the card.
