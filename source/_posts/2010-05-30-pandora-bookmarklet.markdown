--- 
layout: post
title: Pandora Bookmarklet
comments: true
categories: Tech
---
Every time I listen to <a href="http://www.pandora.com/">Pandora</a> I open the site in a new window and scroll and resize the window to fit the player just right and hide the noise (ads) on the page.  I finally sat down and put together a <a href="http://en.wikipedia.org/wiki/Bookmarklet">bookmarklet</a> to do this for me.  It's not perfect, but is good enough.  Right-click the link below and click Bookmark This Link (in Firefox) and you can use the same script to load Pandora and only see what you really care about, the music.

<a href="javascript:function%20pandora(){window.open('http://pandora.com/#radio','_blank','width=725,height=340,scrollbars=1,location=0,menubar=0,titlebar=0,toolbar=0');}pandora();">Bookmark This Link.</a>

Here's the code (prettified):
``` javascript 
javascript: function pandora() {
    window.open( 'http://pandora.com/#radio',
                 '_blank',
                 'width=725,height=340,' +
                 'scrollbars=1,location=0,menubar=0,titlebar=0,toolbar=0'
    );
}
pandora();
```

Enjoy.
