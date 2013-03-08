package gov.spawar.icode

import com.vividsolutions.jts.geom.Coordinate
import com.vividsolutions.jts.geom.GeometryFactory
import com.vividsolutions.jts.geom.PrecisionModel
import org.codice.common.ais.Decoder
import org.codice.common.ais.message.Message

import java.text.SimpleDateFormat
import grails.converters.JSON


class AisIngestController {
    
    def list = {
        render Ais.list() as JSON
    }

    def create = { 

        def body = request.reader.text
        Decoder decoder = new Decoder()
        List messages = decoder.parseString(body)

        def geometryFactory = new GeometryFactory( new PrecisionModel(), 4326 )

        def count = 0


        messages.each { message ->

            def mmsi = message.getMmsi().toInteger()
            def ais = Ais.findByMmsi( mmsi );
            def vesselName = message.metaClass.respondsTo(message, "getVesselName") ? message.getVesselName() : mmsi
            def iMO = mmsi
            def callsign = message.metaClass.respondsTo(message, "getCallSign") ? message.getCallSign() : mmsi
            def length = message.metaClass.respondsTo(message, "getLength") ? message.getLength() : 0
            def width = message.metaClass.respondsTo(message, "getWidth") ? message.getWidth() : 0
            def rateOfTurn = message.metaClass.respondsTo(message, "getRot") ? message.getRot() : 0
            def speedOverGround = message.metaClass.respondsTo(message, "getSog") ? message.getSog() : 0
            def posAccuracy = message.metaClass.respondsTo(message, "getPositionAccuracy") ? message.getPositionAccuracy() : false
            def courseOverGround = message.metaClass.respondsTo(message, "getCog") ? message.getCog() : 0
            def trueHeading = message.metaClass.respondsTo(message, "getTrueHeading") ? message.getTrueHeading() : 0
            def destination = message.metaClass.respondsTo(message, "getDestination") ? message.getDestination() : "Not Known"

            if ( !ais )
            {
                ais = new Ais(
                    mmsi: mmsi as Integer,
                    //navStatus: tokens[1] as Integer,
                    rateOfTurn: rateOfTurn as Float,
                    speedOverGround: speedOverGround as Float,
                    posAccuracy: (posAccuracy ? 1.0: 0.0) as Double,
                    courseOverGround: courseOverGround as Double,
                    trueHeading: trueHeading as Double,
                    IMO: iMO as Integer,
                    callsign: callsign,
                    vesselName: vesselName,
                    //vesselType: tokens[11] as Integer,            //XXX Need to replace this with type logic
                    length: length as Double,
                    width: width as Double,
                    eta: ( new Date() + 30 ),
                    dateCreated: new Date(),
                    lastUpdated: new Date()
                )


                //Find NavStatus
                if (message.metaClass.respondsTo(message, "getNavStatus")){
                    int navCode = message.getNavStatus() as Integer
                    def nav = NavigationStatus.findByCode(navCode) ;
                    if(nav)  ais.navStatus = nav;
                }


                //Save new AIS




                //  if ( !ais.save( flush: true ) )
                //  {
                //    println( "Error: Save AIS errors: ${ais.errors}" );
                //  }
            }

            ais.lastUpdated = new Date()
            if (ais.vesselName == ais.mmsi && vesselName != ais.mmsi) {
                ais.vesselName = message.getVesselName()
                ais.callsign = message.getCallSign()
            }
            ais.save()

            if (message.metaClass.respondsTo(message, "getLon")) {
                def longitude = message.getLon() as Double
                def latitude = message.getLat() as Double
                def point = geometryFactory.createPoint( new Coordinate( longitude, latitude ))
                def location = new Location(
                        ais: ais,
                        longitude: longitude,
                        latitude: latitude,
                        date: new Date(),
                        geometryObject: point
                )

                ais.addToLocations( location )
            }


            log.info "Saved AIS record for ${message.getMmsi()}"
            render "AIS data for ${ais.vesselName} added.\n"
        }
    }
}
