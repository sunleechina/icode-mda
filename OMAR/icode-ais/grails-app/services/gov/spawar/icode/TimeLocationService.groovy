package gov.spawar.icode

import geoscript.workspace.PostGIS
import geoscript.layer.Layer
import geoscript.render.Draw
import geoscript.geom.Bounds
import geoscript.feature.Field
import geoscript.proj.Projection
import org.apache.commons.collections.map.CaseInsensitiveMap

class TimeLocationService
{

  static transactional = false

  def aisMapService

  def currentLocation( def params, def response )
  {
    def wmsParams = new CaseInsensitiveMap( params )
    def postgis = aisMapService.createWorkspace()
    def coords = wmsParams.bbox.split( ',' ).collect { it.toDouble() }

    /*
    def sql = """
    select a.id as id, vessel_name, date as last_known_time, ais_geom as last_known_position
    from ais a, location l
    where a.id=l.ais_id
    and st_within(ais_geom, st_makeenvelope( ${coords[0]}, ${coords[1]}, ${coords[2]}, ${coords[3]}, 4326 ))
   """
   */

    def sql = """
    select x.id as id, vessel_name as name, last_known_time, last_known_position
    from ais x, (
      select distinct a.ais_id, b.date as last_known_time, ais_geom as last_known_position
      from location a
      inner join (
        select ais_id, max(date) as date
        from location
        group by ais_id
      ) b
      on a.ais_id=b.ais_id
      and a.date=b.date
      where st_within(ais_geom, st_makeenvelope( ${coords[0]}, ${coords[1]}, ${coords[2]}, ${coords[3]}, 4326 ))
    ) as y
    where x.id=y.ais_id
    """

    def layer = postgis.addSqlQuery(
            Layer.newname(),
            sql,
            new Field( 'last_known_position', 'POINT', 'EPSG:4326' ),
            ['id']
    )
    def proj = new Projection( wmsParams.srs )
    def bounds = new Bounds( coords[0], coords[1], coords[2], coords[3], proj )
    def size = [wmsParams.width.toInteger(), wmsParams.height.toInteger()]
    def output = response.outputStream

    response.contentType = wmsParams.format
    layer.style = aisMapService.createStyle(wmsParams.styles)
    Draw.draw( layer, bounds, size, output, wmsParams.format - 'image/' )
    postgis?.close()
  }

  def vesselTracks( def params, def response )
  {
    def wmsParams = new CaseInsensitiveMap( params )
    def postgis = aisMapService.createWorkspace()
    def coords = wmsParams.bbox.split( ',' ).collect { it.toDouble() }

    /*
    def sql = """
    select a.id as id, vessel_name, date as last_known_time, ais_geom as last_known_position
    from ais a, location l
    where a.id=l.ais_id
    and st_within(ais_geom, st_makeenvelope( ${coords[0]}, ${coords[1]}, ${coords[2]}, ${coords[3]}, 4326 ))
   """
   */

    def sql = """
    select x.id, vessel_name as name, track
    from ais x, (
      select ais_id as id, st_makeline(ais_geom) as track
      from (
        select ais_id, ais_geom, date
        from location
        where st_within(ais_geom, st_makeenvelope( ${coords[0]}, ${coords[1]}, ${coords[2]}, ${coords[3]}, 4326 ))
        order by date
        ) as t
        group by ais_id
    ) as y
    where x.id=y.id
    """

    def layer = postgis.addSqlQuery(
            Layer.newname(),
            sql,
            new Field( 'track', 'LINESTRING', 'EPSG:4326' ),
            ['id']
    )
    def proj = new Projection( wmsParams.srs )
    def bounds = new Bounds( coords[0], coords[1], coords[2], coords[3], proj )
    def size = [wmsParams.width.toInteger(), wmsParams.height.toInteger()]
    def output = response.outputStream

    response.contentType = wmsParams.format
    layer.style = aisMapService.createStyle(wmsParams.styles)
    Draw.draw( layer, bounds, size, output, wmsParams.format - 'image/' )
    postgis?.close()
  }

}


