
<%@ page import="org.kang.Book" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'book.label', default: 'Book')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>

    <div class="container">
      <div class="row">
	<div class="col-xs-12">
	  <a href="#list-book" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
	</div>
      </div>

      <div class="row nav" role="navigation">
	<div class="col-xs-2"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></div>
	<div class="col-xs-2"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></div>
      </div>
    </div>

    <div id="list-book" class="container" role="main">
      <div class="row">
	<div class="col-xs-12">
	  <h1><g:message code="default.list.label" args="[entityName]" /></h1>
	</div>
      </div>

      <g:if test="${flash.message}">
	<div class="row">
	  <div class="col-xs-12">
	    <div class="message" role="status">${flash.message}</div>
	  </div>
	</div>
      </g:if>

      <div class="row">
	
	<div class="col-xs-2">
	  <g:message code="book.title.label" default="Title" />
	</div>
	
	<div class="col-xs-2">
	  <g:message code="book.author.label" default="Author" />
	</div>
	
      </div>
      
      <g:each in="${bookInstanceList}" status="i" var="bookInstance">
	<div class="row ${(i % 2) == 0 ? 'even' : 'odd'}">

	  
	  <div class="col-xs-2">
	    <g:link action="show" id="${bookInstance.id}">${fieldValue(bean: bookInstance, field: "title")}</g:link>
	  </div>
	  
	  <div class="col-xs-2">
	    ${fieldValue(bean: bookInstance, field: "author")}
	  </div>
	  

	</div>
	    </g:each>
    </div>

    <div class="container">
      <div class="row">
	<div class="col-xs-12 pagination">
	  <g:paginate total="${bookInstanceCount ?: 0}" />
	</div>
      </div>
    </div>

  </body>
</html>
