<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
  </head>
  <body>

    <div class="container">

      <!--
	  <div class="row">
	    <div class="col-xs-12">
	      <a href="#create-${domainClass.propertyName}" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
	    </div>
	  </div>
	  -->

      <div class="row nav" role="navigation">
	<div class="col-xs-2">
	  <a class="home" href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
	</div>
	<div class="col-xs-2">
	  <g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></div>
      </div>
    </div>

    <div id="create-${domainClass.propertyName}" class="container" role="main">
      <div class="row">
	<div class="col-xs-12">
	  <h1><g:message code="default.create.label" args="[entityName]" /></h1>
	</div>
      </div>

      <g:if test="\${flash.message}">
	<div class="row margin-bottom-10">
	  <div class="col-xs-12 bg-info">
	    <div class="message" role="status">\${flash.message}</div>
	  </div>
	</div>
      </g:if>

      <g:hasErrors bean="\${${propertyName}}">
	<g:eachError bean="\${${propertyName}}" var="error">
	  <div class="row margin-bottom-10">
	    <div class="col-xs-12 bg-danger" <g:if test="\${error in org.springframework.validation.FieldError}">data-field-id="\${error.field}"</g:if>>
	      <g:message error="\${error}"/>
	    </div>
	  </div>
	</g:eachError>
      </g:hasErrors>

      <g:form url="[resource:${propertyName}, action:'save']" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
	<fieldset class="form">
	  <g:render template="form"/>
	</fieldset>
	<fieldset class="buttons">
	  <div class="row">
	    <div class="col-xs-12">
	      <g:submitButton name="create" class="btn btn-primary save" value="\${message(code: 'default.button.create.label', default: 'Create')}" />
	    </div>
	  </div>
	</fieldset>
      </g:form>
    </div>

</div>

</body>
</html>
