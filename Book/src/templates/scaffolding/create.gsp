<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
  </head>
  <body>

    <content tag="nav1">
      <div class="row nav" role="navigation">
	<div class="col-xs-2">
	  <a class="home" href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
	</div>
	<div class="col-xs-2">
	  <g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link>
	</div>
      </div>
    </content>

    <hr/>

    <content tag="self-header1">
      <g:message code="default.create.label" args="[entityName]" />
    </content>

    <hr/>

    <g:if test="\${flash.message}">
      <content tag="self-header2">
	<div class="row margin-bottom-10">
	  <div class="col-xs-12 bg-info">
	    <div class="message" role="status">\${flash.message}</div>
	  </div>
	</div>
      </content>
    </g:if>

    <hr/>

    <g:hasErrors bean="\${${propertyName}}">
      <content tag="self-header3">
	<g:eachError bean="\${${propertyName}}" var="error">
	  <div class="row margin-bottom-10">
	    <div class="col-xs-12 bg-danger" <g:if test="\${error in org.springframework.validation.FieldError}">data-field-id="\${error.field}"</g:if>>
	      <g:message error="\${error}"/>
	    </div>
	  </div>
	</g:eachError>
      </content>
    </g:hasErrors>

    <hr/>

    <content tag="self-body">
      <g:form url="[resource:${propertyName}, action:'save']" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
	<fieldset class="form">
	  <g:render template="form"/>
	  <g:render template="form2"/>
	</fieldset>

	<fieldset class="buttons">
	  <g:submitButton name="create" class="btn btn-primary save" value="\${message(code: 'default.button.create.label', default: 'Create')}" />
	</fieldset>
      </g:form>
    </content>

  </body>
</html>
