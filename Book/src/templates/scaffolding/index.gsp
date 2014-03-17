<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>

    <div class="container">

      <!--
      <div class="row">
      <div class="col-xs-12">
      <a href="#list-${domainClass.propertyName}" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
      </div>
      </div>
      -->

      <div class="row nav" role="navigation">
	<div class="col-xs-2">
	  <a class="home" href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
	</div>
      </div>
    </div>

    <div id="list-${domainClass.propertyName}" class="container" role="main">
      <div class="row">
	<div class="col-xs-12">
	  <h1><g:message code="default.list.label" args="[entityName]" /></h1>
	</div>
      </div>

      <g:if test="\${flash.message}">
	<div class="row margin-bottom-10">
	  <div class="col-xs-12 bg-info">
	    <div class="message" role="status">\${flash.message}</div>
	  </div>
	</div>
      </g:if>

      <div class="row">
	<%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
	allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
	props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) && (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true) }
	Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
	props.eachWithIndex { p, i ->
	if (i < 6) {
	if (p.isAssociation()) { %>
	<div class="col-xs-2">
	  <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />
	</div>
	<%      } else { %>
	<div class="col-xs-2">
	  <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />
	</div>
	<%  }   }   } %>
      </div>
      
      <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
	<div class="row \${(i % 2) == 0 ? 'even' : 'odd'}">

	  <%  props.eachWithIndex { p, i ->
	  if (i == 0) { %>
	  <div class="col-xs-2">
	    <g:link action="show" id="\${${propertyName}.id}">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</g:link>
	  </div>
	  <%      } else if (i < 6) {
	  if (p.type == Boolean || p.type == boolean) { %>
	  <div class="col-xs-2">
	    <g:formatBoolean boolean="\${${propertyName}.${p.name}}" />
	  </div>
	  <%          } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
	  <div class="col-xs-2">
	    <g:formatDate date="\${${propertyName}.${p.name}}" />
	  </div>
	  <%          } else { %>
	  <div class="col-xs-2">
	    \${fieldValue(bean: ${propertyName}, field: "${p.name}")}
	  </div>
	  <%  }   }   } %>

	</div>
	    </g:each>

	    <div class="row margin-top-20">
	      <div class="col-xs-12">
		<g:link class="btn btn-default create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
	      </div>
	    </div>
    </div>


    </div>

    <div class="container">
      <div class="row">
	<div class="col-xs-12 pagination">
	  <g:paginate total="\${${propertyName}Count ?: 0}" />
	</div>
      </div>
    </div>

  </body>
</html>
