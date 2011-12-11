--- 
layout: post
title: New Pandora Bookmarklet
comments: true
categories: Tech
---
<a href="http://blog.pandora.com/pandora/archives/2011/09/new-pandora-for.html">New Pandora</a> has launched, so it's time for a #NewPandora bookmarklet. Here you go...

If you're using Firefox, <a href="javascript:function%20pandora(){window.open('http://pandora.com/','_blank','width=850,height=120,scrollbars=1,location=0,menubar=0,titlebar=0,toolbar=0');}pandora();">bookmark this link</a>.

If you're using Chrome, click the <em>view source</em> icon in the prettified code below, then copy and paste it into a new bookmark:
``` javascript 
javascript: function pandora() {
    window.open( 'http://pandora.com/',
                 '_blank',
                 'width=850,height=120,' +
                 'scrollbars=0,location=0,menubar=0,titlebar=0,toolbar=0'
    );
}
pandora();
```

Enjoy.
