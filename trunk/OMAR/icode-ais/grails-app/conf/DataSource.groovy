dataSource {
  pooled = true
  driverClassName = "org.postgis.DriverWrapper"
  username = "postgres"
  password = "postgres"
  dialect = org.hibernatespatial.postgis.PostgisDialect
}
hibernate {
  cache.use_second_level_cache = true
  cache.use_query_cache = true
  cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
  development {
    dataSource {
      dbCreate = "create-drop" // one of 'create', 'create-drop','update'
      url = "jdbc:postgresql_postGIS:omardb-1.8.16-dev"
    }
  }
  test {
    dataSource {
      dbCreate = "update"
      url = "jdbc:postgresql_postGIS:omardb-1.8.16-dev"
    }
  }
  production {
    dataSource {
      dbCreate = "update"
      url = "jdbc:postgresql_postGIS:omardb-1.8.16-dev"
    }
  }
}
