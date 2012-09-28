package gov.spawar.icode

import geoscript.workspace.PostGIS
import geoscript.layer.Layer
import geoscript.render.Draw
import geoscript.geom.Bounds
import geoscript.geom.Point
import geoscript.feature.Field
import geoscript.proj.Projection
import org.apache.commons.collections.map.CaseInsensitiveMap
import com.gmongo.GMongo

/**
 * TimeLocationService used to display Track and Position information Overlays
 */
class TimeLocationService {

    static transactional = false

    def aisMapService

    /**
     * CurrentLocation Service to help display AIS Positions
     *
     * @param params
     * @param response
     * @return
     */
    def currentLocation(def params, def response) {

        def dataSource = "mongo";

        def wmsParams = new CaseInsensitiveMap(params)
        def workSpace = aisMapService.createWorkspace(dataSource)
        def (minLon, minLat, maxLon, maxLat) = wmsParams.bbox.split(',').collect { it.toDouble() }
        def layer = null;


       if(dataSource.equals("postGIS")){

        //Joining AIS and Location for querying a layer
        def sql = """
SELECT DISTINCT ais.id as id, ais.vessel_name as name, location.date as last_known_date, location.geometry_object AS last_known_position
FROM ais, location, ais_location, (
    SELECT ais_locations_id, max(date) AS bar
    FROM location, ais_location
    WHERE location.id=ais_location.location_id
    GROUP BY ais_locations_id) AS foo
WHERE ais.id=ais_location.ais_locations_id
AND location.id=ais_location.location_id
AND foo.ais_locations_id=ais.id
AND foo.bar=location.date
AND ST_Within(location.geometry_object, ST_MakeEnvelope( ${minLon}, ${minLat}, ${maxLon}, ${maxLat}, 4326 ))
    """

        //Add SQL query as a Layer
        layer = workSpace.addSqlQuery(
                Layer.newname(),
                sql,
                new Field('last_known_position', 'POINT', 'EPSG:4326'), //geometryFld
                ['id']  //primaryKey
        )


       }//postGIS
      else if(dataSource.equals("mongo")){

           def mongo = new GMongo();
           def db = mongo.getDB("mongoMan")

           //Get count of AIS
           Integer aisCount = db.ais.count();

           //Get All AIS and last reported position location
           def box = [[minLon, minLat], [maxLon, maxLat]]
           def box2 = [[0,-90], [90,0]]

           //Get all AIS with last reported Loction information
           def ais = db.ais.find([:],[_id:1, IMO:1, callsign:1, locations:[$slice: -1]])
           //def ais = db.ais.find([ "location.geometryobject" : [$within : [ $box: box  ]]],[_id:1, IMO:1, callsign:1, locations:[$slice: -1]]) //.max({location: date});
           db.location.ensureIndex(["geometryobject" : "2d"])
           //def aoi = db.location.find([geometryObject:[$within :[ $box :[ [0, -90], [90,0] ]]]] )

           //Find all locations within AOI
           def myAoi = db.location.find([geometryObject:[$within :[ $box :  box2  ]]] )
           //def aoi = db.ais.find(["location.geometryObject" :[$within :[ $box :  box  ]]] ,[_id:1, IMO:1, callsign:1, locations:[$slice: -1]])
           println "This is my AOI OBJECT: "  + myAoi.toString();

         //def ais2 =  ais.getCollection().findAll([geometryObject:[$within :[ $box :  box  ]]])

          // myAoi.

           Vector<Location> aoiVector = new Vector<Location>();
           println box
           myAoi.each{
               println "------------Adding Stuff---------------------------"
               aoiVector.add(it)
           }


           //Layer that will hold all geo info
           layer =  new Layer(Layer.newname())


           //Go through each AIS
           //println "What is up---------------"
           //println myAoi.class.toString()

           ais.each {
               //println it
               def locationID = it.locations[0].id
               //println "MyLocation ID: " +  locationID
               def lastReported = Location.findById(locationID);
               if(aoiVector.contains(lastReported) ){
                   println "--------------We found something-----------------------"

                   //Add a feature
                   List feature;
                   feature.


                   //Loop for each location
                   layer.addChild([new Point(lastReported.longitude,lastReported.latitude)])


               }


               //println lastReported;
           }



      }
      else{
           layer = null;
       }

        def proj = new Projection(wmsParams.srs)
        def bounds = new Bounds(minLon, minLat, maxLon, maxLat, proj)
        def size = [wmsParams.width.toInteger(), wmsParams.height.toInteger()]
        def output = response.outputStream

        response.contentType = wmsParams.format
        layer.style = aisMapService.createStyle(wmsParams.styles)
        Draw.draw([bounds: bounds, site: size, out: output, format: wmsParams.format - 'image/'], layer)
        workSpace?.close()
    }

    /**
     * Radar Current Location used to display position Overlay
     *
     * @param params
     * @param response
     * @return
     */
    def radarCurrentLocation(def params, def response) {

        def wmsParams = new CaseInsensitiveMap(params)
        def postgis = aisMapService.createWorkspace()
        def (minLon, minLat, maxLon, maxLat) = wmsParams.bbox.split( ',' ).collect { it.toDouble() }
        def sql = """
SELECT DISTINCT radar.id as id, radar.name as name, location.date as last_known_date, location.geometry_object AS last_known_position
FROM radar_surf_track as radar, location, radar_surf_track_location, (
    SELECT radar_surf_track_locations_id, max(date) AS bar
    FROM location, radar_surf_track_location
    WHERE location.id=radar_surf_track_location.location_id
    GROUP BY radar_surf_track_locations_id) AS foo
WHERE radar.id=radar_surf_track_location.radar_surf_track_locations_id
AND location.id=radar_surf_track_location.location_id
AND foo.radar_surf_track_locations_id=radar.id
AND foo.bar=location.date
AND ST_Within(location.geometry_object, ST_MakeEnvelope( ${minLon}, ${minLat}, ${maxLon}, ${maxLat}, 4326 ))
    """

        //Add SQL query as a Layer
        def layer = postgis.addSqlQuery(
                Layer.newname(),
                sql,
                new Field('last_known_position', 'POINT', 'EPSG:4326'), //geometryFld
                ['id']  //primaryKey
        )
        def proj = new Projection(wmsParams.srs)
        def bounds = new Bounds( minLon, minLat, maxLon, maxLat, proj )
        def size = [wmsParams.width.toInteger(), wmsParams.height.toInteger()]
        def output = response.outputStream

        response.contentType = wmsParams.format
        layer.style = aisMapService.createStyle(wmsParams.styles)
        Draw.draw([bounds: bounds, site: size, out: output, format: wmsParams.format - 'image/'], layer)
        postgis?.close()
    }





    /**
     * VMSCurrent Location used to display position Overlay
     *
     * @param params
     * @param response
     * @return
     */
    def vmsCurrentLocation(def params, def response) {

        def wmsParams = new CaseInsensitiveMap(params)
        def postgis = aisMapService.createWorkspace()
        def (minLon, minLat, maxLon, maxLat) = wmsParams.bbox.split( ',' ).collect { it.toDouble() }
        def sql = """
SELECT DISTINCT vms.id as id, vms.vessel_name as name, location.date as last_known_date, location.geometry_object AS last_known_position
FROM vms , location, vms_location, (
    SELECT vms_locations_id, max(date) AS bar
    FROM location, vms_location
    WHERE location.id=vms_location.location_id
    GROUP BY vms_locations_id) AS foo
WHERE vms.id=vms_location.vms_locations_id
AND location.id=vms_location.location_id
AND foo.vms_locations_id=vms.id
AND foo.bar=location.date
AND ST_Within(location.geometry_object, ST_MakeEnvelope( ${minLon}, ${minLat}, ${maxLon}, ${maxLat}, 4326 ))
    """

        //Add SQL query as a Layer
        def layer = postgis.addSqlQuery(
                Layer.newname(),
                sql,
                new Field('last_known_position', 'POINT', 'EPSG:4326'), //geometryFld
                ['id']  //primaryKey
        )
        def proj = new Projection(wmsParams.srs)
        def bounds = new Bounds( minLon, minLat, maxLon, maxLat, proj )
        def size = [wmsParams.width.toInteger(), wmsParams.height.toInteger()]
        def output = response.outputStream

        response.contentType = wmsParams.format
        layer.style = aisMapService.createStyle(wmsParams.styles)
        Draw.draw([bounds: bounds, site: size, out: output, format: wmsParams.format - 'image/'], layer)
        postgis?.close()
    }

    /**
     * Service used to display AIS Track info
     *
     * @param params
     * @param response
     * @return
     */
    def vesselTracks(def params, def response) {
        def wmsParams = new CaseInsensitiveMap(params)
        def postgis = aisMapService.createWorkspace()
        def (minLon, minLat, maxLon, maxLat) = wmsParams.bbox.split(',').collect { it.toDouble() }

        /*
         def sql = """
         select a.id as id, vessel_name, date as last_known_time, ais_geom as last_known_position
         from ais a, location l
         where a.id=l.ais_id
         and st_within(ais_geom, st_makeenvelope( ${coords[0]}, ${coords[1]}, ${coords[2]}, ${coords[3]}, 4326 ))
        """
        */

        def sql = """
    SELECT ais.id, ais.vessel_name, foo.start, foo.stop, foo.track
    FROM (
            SELECT ais_locations_id as id, min(date) AS start, max(date) AS stop, ST_MakeLine(geometry_object) AS track
            FROM (
                    SELECT ais_locations_id, date, geometry_object
                    FROM ais_location a, location b
                    WHERE a.location_id = b.id
                    ORDER BY date
            ) AS bar
            GROUP BY ais_locations_id
    ) AS foo, ais
    WHERE ais.id=foo.id
    AND ST_Within(track, ST_MakeEnvelope( ${minLon}, ${minLat}, ${maxLon}, ${maxLat}, 4326 ))
    """

        def layer = postgis.addSqlQuery(
                Layer.newname(),
                sql,
                new Field('track', 'LINESTRING', 'EPSG:4326'),
                ['id']
        )
        def proj = new Projection(wmsParams.srs)
        def bounds = new Bounds(minLon, minLat, maxLon, maxLat, proj)
        def size = [wmsParams.width.toInteger(), wmsParams.height.toInteger()]
        def output = response.outputStream

        response.contentType = wmsParams.format
        layer.style = aisMapService.createStyle(wmsParams.styles)
        Draw.draw([bounds: bounds, size: size, out: output, format: wmsParams.format - 'image/'], layer)
        postgis?.close()
    }

}


