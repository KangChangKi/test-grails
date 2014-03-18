<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>
  <body>

    <div class="container">
      <!--
      <div class="row">
      <div class="col-xs-12">
      <a href="#show-${domainClass.propertyName}" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
      </div>
      </div>
      -->

      <div class="row nav" role="navigation">
	<div class="col-xs-2">
	  <a class="home" href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
	</div>
	<div class="col-xs-2">
	  <g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link>
	</div>
      </div>
    </div> <!-- end of container -->

    <div id="show-${domainClass.propertyName}" class="container" role="main">
      <div class="row">
	<div class="col-xs-12">
	  <h1><g:message code="default.show.label" args="[entityName]" /></h1>
	</div>
      </div>

      <g:if test="\${flash.message}">
	<div class="row margin-bottom-10">
	  <div class="col-xs-12 bg-info">
	    <div class="message" role="status">\${flash.message}</div>
	  </div>
	</div>
      </g:if>

      <form class="form-horizontal property-list ${domainClass.propertyName}">
	<%
	excludedProps = Event.allEvents.toList() << 'id' << 'version'
	allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
	props = domainClass.properties.findAll {
	// allowedNames.contains(it.name) &&
	!excludedProps.contains(it.name) &&
	(domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true)
	}

	// Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))

	def map = [:]
	domainClass.getClazz().getDeclaredFields().collect {
	it.name
	}.eachWithIndex { e, i ->
	map.put(e, i)
	}
	props.sort { map[it.name] }

	props.each { p -> %>
	<g:if test="\${${propertyName}?.${p.name}}">
	  
	  <%  if (p.isEnum()) { %>
	  <div class="form-group fieldcontain">
	    <div id="${p.name}-label" class="col-sm-2 control-label property-label">
	      <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />
	    </div>
	    <div class="col-sm-10">
	      <p class="form-control-static property-value" aria-labelledby="${p.name}-label">
		<g:fieldValue bean="\${${propertyName}}" field="${p.name}"/>
	      </p>
	    </div>
	  </div>
	  <%  } else if (p.oneToMany || p.manyToMany) { %>

	  <%  } else if (p.manyToOne || p.oneToOne) { %>

	  <%  } else if (p.type == Boolean || p.type == boolean) { %>
	  <div class="form-group fieldcontain">
	    <label id="${p.name}-label" class="col-sm-2 control-label property-label">
	      <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />
	    </label>

	    <div class="col-sm-10">
	      <p class="col-sm-10 form-control-static property-value" aria-labelledby="${p.name}-label">
		<g:formatBoolean boolean="\${${propertyName}?.${p.name}}" />
	      </p>
	    </div>
	  </div>
	  <%  } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
	  <div class="form-group fieldcontain">
	    <label id="${p.name}-label" class="col-sm-2 control-label property-label">
	      <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />
	    </label>

	    <div class="col-sm-10">
	      <p class="col-sm-10 form-control-static property-value" aria-labelledby="${p.name}-label">
		<g:formatDate date="\${${propertyName}?.${p.name}}" />
	      </p>
	    </div>
	  </div>
	  <%  } else if (!p.type.isArray()) { %>
	  <div class="form-group fieldcontain">
	    <label id="${p.name}-label" class="col-sm-2 control-label property-label">
	      <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />
	    </label>

	    <div class="col-sm-10">
	      <p class="col-sm-10 form-control-static property-value" aria-labelledby="${p.name}-label">
		<g:fieldValue bean="\${${propertyName}}" field="${p.name}"/>
	      </p>
	    </div>
	  </div>
	  <%  } %>
		</g:if>
		<%  } %>
      </form>
    </div> <!-- end of container -->

    <div class="container">
      <% props.each { p -> %>
      <g:if test="\${${propertyName}?.${p.name}}">
	<%  if (p.oneToMany || p.manyToMany) { %>
	<div class="row fieldcontain">
	  <div id="${p.name}-label" class="col-sm-12 control-label property-label">
	    <h2><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></h2>
	  </div>
	</div>

	<table class="table table-hover table-condensed">
	  <g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
	    <tr class="fieldcontain">
	      <td class="property-value" aria-labelledby="${p.name}-label">
		<g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link>
	      </td>
	    </tr>
	  </g:each>
	</table>

	<%  } else if (p.manyToOne || p.oneToOne) { %>
	<div class="row fieldcontain">
	  <div id="${p.name}-label" class="col-sm-12 property-label">
	    <h2><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></h2>
	  </div>
	</div>

	<table class="table table-hover table-condensed">
	  <tr class="fieldcontain">
	    <td class="col-xs-2 property-value" aria-labelledby="${p.name}-label">
	      <g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link>
	    </td>
	  </tr>
	</table>
	<%  } %>
	    </g:if>
	    <%  } %>

    </div> <!-- end of container -->

    <div class="container">

      <g:form url="[resource:${propertyName}, action:'delete']" method="DELETE">
	<fieldset class="buttons">
	  <g:link class="btn btn-default create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>

	  <g:link class="btn btn-default edit" action="edit" resource="\${${propertyName}}">
	    <g:message code="default.button.edit.label" default="Edit" />
	    </g:link>

	    <g:actionSubmit class="btn btn-default delete" action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />

	</fieldset>
	    </g:form>

    </div> <!-- end of container -->

  </body>
</html>
