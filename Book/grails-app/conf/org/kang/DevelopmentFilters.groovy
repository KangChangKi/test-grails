package org.kang

import grails.util.Environment
import org.codehaus.groovy.grails.plugins.GrailsPlugin

class DevelopmentFilters {

  def pluginManager
  def grailsApplication

  def filters = {
    all(controller:'*', action:'*') {
      before = {
	assert pluginManager
	assert grailsApplication

	if (Environment.current == Environment.PRODUCTION) {
	  
	} else if (Environment.current == Environment.TEST) {
	  
	} else if (Environment.current == Environment.DEVELOPMENT) {
	  pluginManager.allPlugins.each {
	    it.notifyOfEvent(GrailsPlugin.EVENT_ON_CONFIG_CHANGE, grailsApplication.config)
	  }
	}
      }
      after = { Map model ->
	
      }
      afterView = { Exception e ->
	
      }
    }
  }
}
