--- 
layout: post
title: Segmenting Traffic to Clusters in Resin
categories: Tech
---
For a multitude of reasons I won't get into here, I recently ran into an issue where I needed to segment traffic to a website by search engine traffic and real customer traffic. Using <a href="http://caucho.com/">Resin</a> as the load balancer and application server I found a very simple way to do this.

First I split apart our current application cluster. Here's a paraphrased configuration:
``` xml 
    <cluster id="app-cluster">
        <server id="app11">
            ...
        </server>
        <server id="app12">
            ...
        </server>
    </cluster>

    <cluster id="bot-cluster">
        <server id="bot21">
            ...
        </server>
        <server id="bot22">
            ...
        </server>
    </cluster>
```
Then I added some <em>rewrite-dispatch</em> actions to the load balancer cluster matching on the <em>User-Agent</em> header at lines 8-11 below:
``` xml 
     <cluster id="web-cluster">
        <server id="webserver">
            ...
        </server>
        <host id="">
            <web-app id="/">
                <rewrite-dispatch>
                    <!-- Send to 'bot cluster'. -->
                    <load-balance regexp="" cluster="bot-cluster">
                        <when header="User-Agent" regexp="Googlebot" />
                    </load-balance>

                    <!-- Send to 'customer cluster'. -->
                    <load-balance regexp="" cluster="app-cluster"/>
                </rewrite-dispatch>
            </web-app>
        </host>
    </cluster>
```
Resin supports many conditions such as <em>header</em>, <em>cookie</em>, <em>query-param</em> and others, as well as chaining conditions with <em>and</em>, <em>or</em> and <em>not</em>. Full configuration for rewrite tags are <a href="http://caucho.com/resin-3.1/doc/rewrite-tags.xtp">here</a>.

All of this allows gives you very powerful capabilities to partition your site into different clusters as needed.

<em>Note: The above configuration is for Resin 3.1. Resin 4.x supports similar functionality but with a different syntax.</em>
