<%=packageName%>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
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
      <g:message code="default.edit.label" args="[entityName]" />
    </content>
    
    <g:if test="\${flash.message}">
      <content tag="self-header2">
	<div class="row margin-bottom-10">
	  <div class="col-xs-12 bg-info">
	    <div class="message" role="status">\${flash.message}</div>
	  </div>
	</div>
      </content>
    </g:if>

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
    </content>

    <content tag="self-body">
      <g:form url="[resource:${propertyName}, action:'update']" method="PUT" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
	<g:hiddenField name="version" value="\${${propertyName}?.version}" />

	<fieldset class="form">
	  <g:set var="primitive" value="${true}" />
	  <g:render template="form" />
	</fieldset>

	<fieldset class="buttons">
	  <g:link class="btn btn-default create" action="create">
	    <g:message code="default.new.label" args="[entityName]" />
	    </g:link>

	    <g:actionSubmit class="btn btn-primary save" action="update" value="\${message(code: 'default.button.update.label', default: 'Update')}" />

	</fieldset>
	    </g:form>
    </content>

    <g:render template="form2" />

  </body>
</html>
