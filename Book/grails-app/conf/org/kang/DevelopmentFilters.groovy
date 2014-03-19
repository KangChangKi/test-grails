package org.kang

import grails.util.Environment
import org.codehaus.groovy.grails.plugins.GrailsPlugin
import org.codehaus.groovy.grails.scaffolding.view.ScaffoldingViewResolver
import org.codehaus.groovy.grails.web.pages.GroovyPagesTemplateRenderer

class DevelopmentFilters {

  def pluginManager
  def grailsApplication
  def groovyPagesTemplateRenderer

  def filters = {
    all(controller:'*', action:'*') {
      before = {

      }
      after = { Map model ->
	if (Environment.current == Environment.PRODUCTION) {
	  
	} else if (Environment.current == Environment.TEST) {
	  
	} else if (Environment.current == Environment.DEVELOPMENT) {
	  assert pluginManager
	  assert grailsApplication
	  assert groovyPagesTemplateRenderer

	  groovyPagesTemplateRenderer.clearCache() // for layouts(*.gsp)
	  ScaffoldingViewResolver.clearViewCache() // for views(*.gsp)

	  pluginManager.allPlugins.each { // for *.template
	    it.notifyOfEvent(GrailsPlugin.EVENT_ON_CONFIG_CHANGE, grailsApplication.config)
	  }
	}
      }
      afterView = { Exception e ->
	
      }
    }
  }
}
