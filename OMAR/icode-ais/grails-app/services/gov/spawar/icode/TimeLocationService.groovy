package gov.spawar.icode

import geoscript.workspace.PostGIS
import geoscript.layer.Layer
import geoscript.render.Draw
import geoscript.geom.Bounds
import geoscript.feature.Field
import geoscript.proj.Projection
import org.apache.commons.collections.map.CaseInsensitiveMap

/**
 * TimeLocationService used to display Track and Position information Overlays
 */
class TimeLocationService
{

  static transactional = false

  def aisMapService

    /**
     * CurrentLocation Service to help display AIS Positions
     *
      * @param params
     * @param response
     * @return
     */
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

    //Joining AIS and Location for querying a layer
    def sql = """
SELECT  distinct
  a.id as id, a.vessel_name as name, d.date as last_known_time, d.geometry_object as last_know_position
  FROM ais a
  JOIN
     (
      SELECT   a.ais_locations_id, MAX(b.Date) AS maxdate
      FROM     ais_location a
      JOIN     location b ON a.Location_id = b.ID
      GROUP BY a.ais_locations_id
     ) b

     ON a.ID = b.ais_locations_id
  JOIN
     ais_location c ON b.ais_locations_id = c.ais_locations_id
  JOIN
     location d ON c.Location_id = d.ID AND b.maxdate = d.Date
  WHERE st_within(geometry_object, st_makeenvelope( ${coords[0]}, ${coords[1]}, ${coords[2]}, ${coords[3]}, 4326 ))

    """

    //Add SQL query as a Layer
    def layer = postgis.addSqlQuery(
            Layer.newname(),
            sql,
            new Field( 'last_known_position', 'POINT', 'EPSG:4326' ), //geometryFld
            ['id']  //primaryKey
    )
    def proj = new Projection( wmsParams.srs )
    def bounds = new Bounds( coords[0], coords[1], coords[2], coords[3], proj )
    def size = [wmsParams.width.toInteger(), wmsParams.height.toInteger()]
    def output = response.outputStream

    response.contentType = wmsParams.format
    layer.style = aisMapService.createStyle( wmsParams.styles )
    Draw.draw( [bounds: bounds, site: size, out: output, format: wmsParams.format - 'image/'], layer )
    postgis?.close()
  }

    /**
     * Radar Current Location used to display position Overlay
     *
     * @param params
     * @param response
     * @return
     */
    /*********************************************************************************
    def radarCurrentLocation( def params, def response )
    {
        def wmsParams = new CaseInsensitiveMap( params )
        def postgis = aisMapService.createWorkspace()
        def coords = wmsParams.bbox.split( ',' ).collect { it.toDouble() }



        //Joining Radar and Location for querying a layer
        def sql = """

 SELECT DISTINCT a.id, vessel_name as name, last_known_date, last_known_position
 from ais a
 join
    (
      select a.id, MAX(l.date) as last_known_date
      from ais a
      JOIN ais_location al on al.ais_locations_id = a.id
      JOIN Location l on l.id = al.location_id
      GROUP BY a.id
    ) ALMax
 on ALMax.id = a.id
 join ais_location al on al.ais_locations_id=a.id
 join Location l on al.location_id = l.id and l.date = ALMax.last_known_date
 where st_within(geometry_object, st_makeenvelope( \${coords[0]}, \${coords[1]}, \${coords[2]}, \${coords[3]}, 4326 ))

    """

        //Add SQL query as a Layer
        def layer = postgis.addSqlQuery(
                Layer.newname(),
                sql,
                new Field( 'last_known_position', 'POINT', 'EPSG:4326' ), //geometryFld
                ['id']  //primaryKey
        )
        def proj = new Projection( wmsParams.srs )
        def bounds = new Bounds( coords[0], coords[1], coords[2], coords[3], proj )
        def size = [wmsParams.width.toInteger(), wmsParams.height.toInteger()]
        def output = response.outputStream

        response.contentType = wmsParams.format
        layer.style = aisMapService.createStyle( wmsParams.styles )
        Draw.draw( [bounds: bounds, site: size, out: output, format: wmsParams.format - 'image/'], layer )
        postgis?.close()
    }
      ************************************************************************************************************/

    /**
     * Service used to display AIS Track info
     *
     * @param params
     * @param response
     * @return
     */
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
      select ais_id as id, st_makeline(geometry_object) as track
      from (
        select ais_id, geometry_object, date
        from location
        where st_within(geometry_object, st_makeenvelope( ${coords[0]}, ${coords[1]}, ${coords[2]}, ${coords[3]}, 4326 ))
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
    layer.style = aisMapService.createStyle( wmsParams.styles )
    Draw.draw( [bounds: bounds, size: size, out: output, format: wmsParams.format - 'image/'], layer )
    postgis?.close()
  }

}


