
<%@ page import="org.kang.Author" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'author.label', default: 'Author')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>

    <div class="container">
      <div class="row">
	<div class="span12">
	  <a href="#list-author" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
	</div>
      </div>

      <div class="row nav" role="navigation">
	<div class="span2"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></div>
	<div class="span2"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></div>
      </div>
    </div>

    <div id="list-author" class="container" role="main">
      <div class="row">
	<div class="span12">
	  <h1><g:message code="default.list.label" args="[entityName]" /></h1>
	</div>
      </div>

      <g:if test="${flash.message}">
	<div class="row">
	  <div class="span12">
	    <div class="message" role="status">${flash.message}</div>
	  </div>
	</div>
      </g:if>

      <div class="row">
	
	<div class="span2">
	  <g:message code="author.name.label" default="Name" />
	</div>
	
      </div>
      
      <g:each in="${authorInstanceList}" status="i" var="authorInstance">
	<div class="row ${(i % 2) == 0 ? 'even' : 'odd'}">

	  
	  <div class="span2">
	    <g:link action="show" id="${authorInstance.id}">${fieldValue(bean: authorInstance, field: "name")}</g:link>
	  </div>
	  

	</div>
	    </g:each>
    </div>

    <div class="container">
      <div class="row">
	<div class="span12 pagination">
	  <g:paginate total="${authorInstanceCount ?: 0}" />
	</div>
      </div>
    </div>

  </body>
</html>
