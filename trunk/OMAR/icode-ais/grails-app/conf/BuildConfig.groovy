grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
//grails.project.war.file = "target/${appName}-${appVersion}.war"
grails.project.dependency.resolution = {
  // inherit Grails' default dependencies
  inherits( "global" ) {
    // uncomment to disable ehcache
    // excludes 'ehcache'
  }
  log "debug" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
  repositories {
    grailsPlugins()
    grailsHome()
    grailsCentral()

    // uncomment the below to enable remote dependency resolution
    // from public Maven repositories
    mavenLocal()
    mavenCentral()
    mavenRepo "http://snapshots.repository.codehaus.org"
    mavenRepo "http://repository.codehaus.org"
    mavenRepo "http://download.java.net/maven/2/"
    mavenRepo "http://repository.jboss.com/maven2/"

  }
  dependencies {
    // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.
    runtime 'com.vividsolutions:jts:1.11'
	provided 'xalan:xalan:2.7.0'
    // runtime 'mysql:mysql-connector-java:5.1.13'
  }
  plugins { 
    runtime ":resources:1.1.6"
    compile ":hibernate:2.2.0"
    compile ":quartz:1.0-RC5"
    compile ":rest-client-builder:1.0.3"
  }
}

grails.plugin.location.postgis = "${System.env['OMAR_DEV_HOME']}/plugins/postgis"
grails.plugin.location.openlayers = "${System.env['OMAR_DEV_HOME']}/plugins/openlayers"
grails.plugin.location.geoscript = "${System.env['OMAR_DEV_HOME']}/plugins/geoscript"
grails.plugin.location.omarSecuritySpring = "${System.env['OMAR_DEV_HOME']}/plugins/omar-security-spring"
