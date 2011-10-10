--- 
layout: post
title: Cross-Origin Resource Sharing and Apache httpd
categories: Tech
---
After <a href="http://twitter.com/#!/clstokes/status/15980064558555136">asking Amazon</a> to support the <a href="http://www.w3.org/TR/cors/">W3C Cross-Origin Resource Sharing specification</a> for the Route 53 APIs I decided to look into what it would take to implement the necessary headers in the Apache web server.

The specification describes several headers that need to be set, but we'll only focus on the main header, <em>Access-Control-Allow-Origin</em>. Setting the header is easy; determining when to set it and what to set it to is the trickier part. After a bit of digging through the HTTP Server documentation I found the necessary configuration. Using <a href="http://httpd.apache.org/docs/2.2/mod/mod_headers.html"><em>mod_headers</em></a> and <a href="http://httpd.apache.org/docs/2.2/mod/mod_setenvif.html"><em>mod_setenvif</em></a> you can easily support dynamic headers to support cross-origin resource sharing.

Here's the config:
``` xml 
SetEnvIf Origin "http(s)?://(example\.com|example\.org)$" AccessControlAllowOrigin=$0
Header add Access-Control-Allow-Origin %{AccessControlAllowOrigin}e env=AccessControlAllowOrigin
```

Line 1 uses <em>SetEnvIf</em> to set an  environment variable if the request attribute matches the regular expression. In this case we're matching on the <em>Origin</em> header for example.com or example.org and if it matches,  the <em>AccessControlAllowOrigin</em> environment variable is set to the value of the <em>Origin</em> header as specified by the <em>$1</em> backreference.

Line 2 adds the <em>Access-Control-Allow-Origin</em> header to the response. The value is set to the <em>AccessControlAllowOrigin</em> environment variable from <em>line 1</em>. The <em>env=AccessControlAllowOrigin</em> directive means the header will only be added if the <em>AccessControlAllowOrigin</em> environment variable has been set.

The specification states you can support a wildcard value (*) for the <em>Access-Control-Allow-Origin</em> header or a comma-delimited list of domains, but with this configuration you can be specific in permitting access to individual domains without specifying everyone you've given access to. The <a href="https://developer.mozilla.org/en/http_access_control"><em>HTTP access control</em></a> documentation at the Mozilla Developer Network provides a great reference for how to use the cross-origin resource sharing functionality on the server and client-side.
