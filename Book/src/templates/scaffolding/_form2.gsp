<%=packageName%>
<% import grails.persistence.Event %>

<%
excludedProps = Event.allEvents.toList() << 'version' << 'dateCreated' << 'lastUpdated'
persistentPropNames = domainClass.persistentProperties*.name
boolean hasHibernate = pluginManager?.hasGrailsPlugin('hibernate') || pluginManager?.hasGrailsPlugin('hibernate4')
if (hasHibernate) {
  def GrailsDomainBinder = getClass().classLoader.loadClass('org.codehaus.groovy.grails.orm.hibernate.cfg.GrailsDomainBinder')
  if (GrailsDomainBinder.newInstance().getMapping(domainClass)?.identity?.generator == 'assigned') {
    persistentPropNames << domainClass.identifier.name
  }
}

props = domainClass.properties.findAll {
  persistentPropNames.contains(it.name) &&
  !excludedProps.contains(it.name) &&
  (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true) &&
  // !(it.oneToMany || it.manyToMany || it.manyToOne || it.oneToOne)
  (it.oneToMany || it.manyToMany || it.manyToOne || it.oneToOne)
}

// Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))

def map = [:]
domainClass.getClazz().getDeclaredFields().collect {
  it.name
}.eachWithIndex { e, i ->
  map.put(e, i)
}
props.sort { map[it.name] }

int otherIndex = 1
for (p in props) {
  if (p.embedded) {
    def embeddedPropNames = p.component.persistentProperties*.name
    def embeddedProps = p.component.properties.findAll {
      embeddedPropNames.contains(it.name) &&
      !excludedProps.contains(it.name)
    }

    Collections.sort(embeddedProps, comparator.constructors[0].newInstance([p.component] as Object[]))
%>
<fieldset class="embedded">
  <legend>
    <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />
  </legend>
<%
    for (ep in p.component.properties) {
      renderFieldForProperty(ep, p.component, otherIndex++, "${p.name}.")
    }
%>
</fieldset>
<%
  } else {
    renderFieldForProperty(p, domainClass, otherIndex++)
  }
} // end of method

private renderFieldForProperty(p, owningClass, otherIndex, prefix = "") {
  boolean hasHibernate = pluginManager?.hasGrailsPlugin('hibernate') || pluginManager?.hasGrailsPlugin('hibernate4')
  boolean display = true
  boolean required = false
  if (hasHibernate) {
    cp = owningClass.constrainedProperties[p.name]
    display = (cp ? cp.display : true)
    required = (cp ? !(cp.propertyType in [boolean, Boolean]) && !cp.nullable && (cp.propertyType != String || !cp.blank) : false)
  }
  if (display) {
%>

<content tag="other${otherIndex}-header">
<span class="\${hasErrors(bean: ${propertyName}, field: '${prefix}${p.name}', 'error')} ${required ? 'required' : ''}">
<%  if (required) { %>
      <span class="required-indicator">*</span>
<%  } %>
  <g:message code="${domainClass.propertyName}.${prefix}${p.name}.label" default="${p.naturalName}" />
</content>

<content tag="other${otherIndex}-body">
  ${renderEditor(p)}
</content>
<%
  } // end of if
} // end of method
%>
