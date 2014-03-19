<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main"/>
    <title>Your title</title>
  </head>
  <body>

    <content tag="nav1">
      <h1>Available Controllers</h1>
      <ul>
	<g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
	  <li ><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
	</g:each>
      </ul>
    </content>

    <content tag="self-body">
      <h1>Application Status</h1>
      <ul>
	<li>App version: <g:meta name="app.version"/></li>
	<li>Grails version: <g:meta name="app.grails.version"/></li>
	<li>Groovy version: ${GroovySystem.getVersion()}</li>
	<li>JVM version: ${System.getProperty('java.version')}</li>
	<li>Reloading active: ${grails.util.Environment.reloadingAgentEnabled}</li>
	<li>Controllers: ${grailsApplication.controllerClasses.size()}</li>
	<li>Domains: ${grailsApplication.domainClasses.size()}</li>
	<li>Services: ${grailsApplication.serviceClasses.size()}</li>
	<li>Tag Libraries: ${grailsApplication.tagLibClasses.size()}</li>
      </ul>
      <h1>Installed Plugins</h1>
      <ul>
	<g:each var="plugin" in="${applicationContext.getBean('pluginManager').allPlugins}">
	  <li>${plugin.name} - ${plugin.version}</li>
	</g:each>
      </ul>
    </content>

  </body>
</html>
