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

    <content tag="nav1">
      <div class="row nav" role="navigation">
	<div class="col-xs-2">
	  <a class="home" href="\${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
	</div>
      </div>
    </content>

    <hr/>

    <content tag="self-header1">
      <g:message code="default.list.label" args="[entityName]" />
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

    <hr/>

    <content tag="self-body">
      <table class="table table-hover table-condensed">
	<tr>
	  <%
	  excludedProps = Event.allEvents.toList() << 'id' << 'version'
	  allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
	  props = domainClass.properties.findAll {
	  // allowedNames.contains(it.name) &&
	  !excludedProps.contains(it.name) &&
	  it.type != null &&
	  !Collection.isAssignableFrom(it.type) &&
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

	  props.eachWithIndex { p, i ->
	  if (i < 6) {
	  if (p.isAssociation()) { %>
	  <th>
	    <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />
	  </th>
	  <%      } else { %>
	  <th>
	    <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />
	  </th>
	  <%  }   }   } %>
	</tr>

	<g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
	  <tr>
	    <%  props.eachWithIndex { p, i ->
	    if (i == 0) { %>
	    <td>
	      <g:link action="show" id="\${${propertyName}.id}">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</g:link>
	    </td>
	    <%      } else if (i < 6) {
	    if (p.type == Boolean || p.type == boolean) { %>
	    <td>
	      <g:formatBoolean boolean="\${${propertyName}.${p.name}}" />
	    </td>
	    <%          } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
	    <td>
	      <g:formatDate date="\${${propertyName}.${p.name}}" />
	    </td>
	    <%          } else { %>
	    <td>
	      \${fieldValue(bean: ${propertyName}, field: "${p.name}")}
	    </td>
	    <%  }   }   } %>
	  </tr>
	      </g:each>
      </table>

      <div class="row margin-top-20">
	<div class="col-xs-12">
	  <g:link class="btn btn-default create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
	</div>
      </div>

      <div class="row">
	<div class="col-xs-12 pagination">
	  <g:paginate total="\${${propertyName}Count ?: 0}" />
	</div>
      </div>
    </content> <!-- end of container -->

  </body>
</html>
