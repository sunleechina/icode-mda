package gov.spawar.icode

import com.vividsolutions.jts.geom.Coordinate
import com.vividsolutions.jts.geom.GeometryFactory
import com.vividsolutions.jts.geom.PrecisionModel
import java.text.SimpleDateFormat
import grails.converters.JSON

class AisIngestController {
    
    def list = {
        render Ais.list() as JSON
    }

    def create = { 
        
        def body = request.reader.text

        def geometryFactory = new GeometryFactory( new PrecisionModel(), 4326 )

        def count = 0

        body.toCsvReader().eachLine {  tokens ->

            SimpleDateFormat formatter;  //07-MAY-07 11.41.56 AM
            formatter = new SimpleDateFormat( "yy-MMM-dd hh.mm.ss a" );

            //Search for AIS based on MMSI
            def mmsiID = tokens[0]?.toInteger()
            def ais = Ais.findByMmsi( mmsiID );

            long timeStamp = tokens[8] as Long
            timeStamp = timeStamp * 1000
            
            if ( !ais )
            {

                ais = new Ais(
                    mmsi: tokens[0] as Integer,
                    //navStatus: tokens[1] as Integer,
                    rateOfTurn: tokens[2] as Float,
                    speedOverGround: tokens[3] as Float,
                    posAccuracy: tokens[21] as Double,
                    courseOverGround: tokens[6] as Double,
                    trueHeading: tokens[7] as Double,
                    IMO: tokens[9] as Integer,
                    callsign: tokens[20],
                    vesselName: tokens[10],
                    //vesselType: tokens[11] as Integer,            //XXX Need to replace this with type logic
                    length: tokens[12] as Double,
                    width: tokens[13] as Double,
                    eta: ( new Date() + 30 ),
                    dateCreated: new Date(timeStamp),
                    lastUpdated: new Date(timeStamp)
                    //destination: tokens[19]
                    //mid //MaritimeIdDigit
                )
				
                //Find NavStatus
                int navCode = tokens[1] as Integer
                def nav = NavigationStatus.findByCode(navCode) ;
                if(nav)  ais.navStatus = nav;


                //Save new AIS
                ais.save()

                //  if ( !ais.save( flush: true ) )
                //  {
                //    println( "Error: Save AIS errors: ${ais.errors}" );
                //  }
            }

            

            def longitude = tokens[5] as Double
            def latitude = tokens[4] as Double
            def point = geometryFactory.createPoint( new Coordinate( longitude, latitude ))
            def location = new Location(
                longitude: longitude,
                latitude: latitude,
                date: new Date( timeStamp ),
                geometryObject: point
            )
            
            ais.addToLocations( location )

            render "AIS data for ${ais.vesselName} - ${point.toText()} added.\n"
            //ais.save()
        }
    }
}
