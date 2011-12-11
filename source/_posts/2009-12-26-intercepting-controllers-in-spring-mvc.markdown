--- 
layout: post
title: Intercepting controllers in Spring MVC
comments: true
categories: Tech
---
Working on <a href="/2009/10/12/new-project/">my latest project</a> the past couple days I was trying to figure out a way to enforce authentication for some requests but not others.  I first wrote a <a href="http://java.sun.com/products/servlet/Filters.html">Filter</a> but when I started mapping the filter to my specific URLs I realized how tedious this could become.  I then remembered that <a href="http://www.springsource.org/about">Spring</a> allowed for interceptors in its web framework and after a quick glance through their documentation I found <a href="http://static.springsource.org/spring/docs/2.5.x/reference/mvc.html#mvc-handlermapping-interceptor">the section I was looking for</a>.  Unfortunately this still wasn't exactly what I needed as Spring applies your interceptors to all requests configured in your handler mapping.  Looking at the <a href="http://static.springsource.org/spring/docs/2.5.x/api/index.html">HandlerInterceptor API</a> I found I had access to the handler that was being processed and I just needed to decorate my handlers that needed authentication and adjust my interceptor to first check the handler.  I decided to create an empty Interface named <em>AuthenticatedController</em> which my controllers could implement to indicate they needed to be protected from unauthenticated access.  You could also do this using annotations, but here's my code:

<em>AuthenticatedController.java</em>
``` java 
public interface AuthenticatedController {
    // This is empty on purpose.
} 
```
<em>SimpleController.java</em>
``` java 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public class StateController implements AuthenticatedController {

    public ModelAndView handleRequest( final HttpServletRequest httpServletRequest,
            final HttpServletResponse httpServletResponse ) throws Exception {
        ...
    }

} 
```
<em>AuthenticationInterceptor.java</em>
``` java 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter {

    public boolean preHandle( HttpServletRequest request, HttpServletResponse response,
            Object handler ) throws Exception {

        if ( !( handler instanceof AuthenticatedController ) ) {
            // Authentication not needed, allow request to continue.
            return true;
        }

        boolean isAuthenticated = checkAuthentication(...);

        if ( !isAuthenticated ) {
            // User is not authenticated, handle response as needed, and halt processing.
            response.setStatus( HttpServletResponse.SC_FORBIDDEN );
            return false;
        }

        // User is authenticated, allow request to continue.
        return true;
    }
} 
```
<em>spring-beans.xml</em>
``` xml 
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans-2.5.xsd">

<bean name="authenticationInterceptor" class="custom.AuthenticationInterceptor" />

<bean name="urlMapping"
    class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
    <property name="interceptors">
         <list>
	     <ref bean="authenticationInterceptor" />
	</list>
    </property>
    <property name="mappings">
	<props>
            <prop key="/controller1.json">controller1</prop>
            <prop key="/controller2.json">controller2</prop>
            <prop key="/controller3.json">controller3</prop>
        </props>
    </property>
</bean>

</beans> 
```
