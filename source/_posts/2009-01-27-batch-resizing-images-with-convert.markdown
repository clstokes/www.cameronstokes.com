--- 
layout: post
title: "Batch resizing images with 'convert'"
comments: true
categories: Tech
---
I've hosted a <a href="http://cameronstokes.com/gallery/">photo gallery</a> in some form or fashion on my site for about as long as I've had my own domain.  I first used <a href="http://gallery.menalto.com/">Gallery</a> and switched to <a href="http://www.zenphoto.org/">zenphoto</a> sometime last year for reasons I can't remember now.  Having close to 7,000 photos as of this post I was using up a lot of disk space on my host and was close to running out of available space.  7,000 photos isn't an excessive amount but when each full-size photo is roughly 2 MB, it adds up.  I decided the best way to free up space was to resize all of the photos down to the default view size of zenphoto and not allow the full-size versions to be viewed online.  A quick test showed this would reduce the average photo down to about 100 KB, a significant reduction.

Having several thousand photos, I needed to find a way to <a href="http://en.wikipedia.org/wiki/Batch_processing">batch</a> resize them all.  A quick googling found that  <a href="http://www.imagemagick.org/script/convert.php"><strong>convert</strong></a> from the <a href="http://en.wikipedia.org/wiki/ImageMagick">ImageMagick</a> software suite could do exactly what I needed.  Using <strong>convert</strong>, <a href="http://en.wikipedia.org/wiki/Find"><strong>find</strong></a>, and <a href="http://en.wikipedia.org/wiki/Xargs"><strong>xargs</strong></a> I was able to put together a string of commands that found all of my images and converted them to the size I wanted:

``` 
find . -type f | xargs -i convert -size 480x480 {} -resize 480x480 {}
```

This command finds all regular files under the current working directory and calls <strong>convert</strong> on each file, resizing the photo, and replacing the original file.  Be sure to have a backup of your photos in case you mistype any part of the command.  Since convert is replacing your files you won't be able to undo any files that are processed before you stop the command from running.

<strong>convert</strong> outputs an error when it encountered video or <a href="http://en.wikipedia.org/wiki/Portable_Network_Graphics">PNG</a> files but kept processing the <a href="http://en.wikipedia.org/wiki/JPEG">JPEGs</a> normally.  I found that when I ran this on images that had already been resized, <strong>convert</strong> wouldn't resize them again or if it did the new file wasn't affected as the file sizes before and after were the same.

I freed up over 9 GB on my host by running this.  Going forward I'll just run this on every new album I upload.
