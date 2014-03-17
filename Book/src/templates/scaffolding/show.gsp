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
    </div>

    <div id="show-${domainClass.propertyName}" class="container" role="main">
      <div class="row">
	<div class="col-xs-12">
	  <h1><g:message code="default.show.label" args="[entityName]" /></h1>
	</div>
      </div>

      <g:if test="\${flash.message}">
	<div class="row">
	  <div class="col-xs-12">
	    <div class="message" role="status">\${flash.message}</div>
	  </div>
	</div>
      </g:if>

      <div class="property-list ${domainClass.propertyName}">
	<%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
	allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
	props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true) }
	Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
	props.each { p -> %>
	<g:if test="\${${propertyName}?.${p.name}}">
	  <div class="row fieldcontain">
	    <%  if (p.isEnum()) { %>
	    <div id="${p.name}-label" class="col-xs-2 property-label">
	      <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />
	    </div>

	    <div class="col-xs-2 property-value" aria-labelledby="${p.name}-label">
	      <g:fieldValue bean="\${${propertyName}}" field="${p.name}"/>
	    </div>
	    <%  } else if (p.oneToMany || p.manyToMany) { %>

	    <%  } else if (p.manyToOne || p.oneToOne) { %>

	    <%  } else if (p.type == Boolean || p.type == boolean) { %>
	    <div id="${p.name}-label" class="col-xs-2 property-label">
	      <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />
	    </div>

	    <div class="col-xs-2 property-value" aria-labelledby="${p.name}-label">
	      <g:formatBoolean boolean="\${${propertyName}?.${p.name}}" />
	    </div>
	    <%  } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
	    <div id="${p.name}-label" class="col-xs-2 property-label">
	      <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />
	    </div>

	    <div class="col-xs-2 property-value" aria-labelledby="${p.name}-label">
	      <g:formatDate date="\${${propertyName}?.${p.name}}" />
	    </div>
	    <%  } else if (!p.type.isArray()) { %>
	    <div id="${p.name}-label" class="col-xs-2 property-label">
	      <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />
	    </div>

	    <div class="col-xs-2 property-value" aria-labelledby="${p.name}-label">
	      <g:fieldValue bean="\${${propertyName}}" field="${p.name}"/>
	    </div>
	    <%  } %>
	  </div>
	      </g:if>
	      <%  } %>

	      <% props.each { p -> %>
	      <g:if test="\${${propertyName}?.${p.name}}">
		<%  if (p.oneToMany || p.manyToMany) { %>
		<div class="row fieldcontain">
		  <div id="${p.name}-label" class="col-xs-2 property-label">
		    <h2><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />:</h2>
		  </div>
		</div>

		<g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
		  <div class="row fieldcontain">
		    <div class="col-xs-2 property-value" aria-labelledby="${p.name}-label">
		      <g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link>
		    </div>
		  </div>
		</g:each>
		<%  } else if (p.manyToOne || p.oneToOne) { %>
		<div class="row fieldcontain">
		  <div id="${p.name}-label" class="col-xs-2 property-label">
		    <h2><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />:</h2>
		  </div>
		</div>

		<div class="row fieldcontain">
		  <div class="col-xs-2 property-value" aria-labelledby="${p.name}-label">
		    <g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link>
		  </div>
		</div>
		<%  } %>
      </div>
		    </g:if>
		    <%  } %>

		    <div class="container margin-top-20">
		      <div class="row">
			<div class="col-xs-12">

			  <g:form url="[resource:${propertyName}, action:'delete']" method="DELETE">
			    <fieldset class="buttons">

			      <g:link class="btn btn-default create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>

			      <g:link class="btn btn-default edit" action="edit" resource="\${${propertyName}}">
				<g:message code="default.button.edit.label" default="Edit" />
				</g:link>

				<g:actionSubmit class="btn btn-primary delete" action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
			    </fieldset>
				</g:form>
			</div>
		      </div>
		    </div>

    </div>
  </body>
</html>
