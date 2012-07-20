/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package gov.spawar.icode

import com.vividsolutions.jts.geom.Coordinate
import com.vividsolutions.jts.geom.GeometryFactory
import com.vividsolutions.jts.geom.PrecisionModel
import java.text.SimpleDateFormat

import org.codehaus.groovy.grails.plugins.DomainClassGrailsPlugin

//RADAR Parser
import com.spawar.icode.radar.STTrackAirT;
import com.spawar.icode.radar.STTrackSurfT;
import com.spawar.icode.radar.TrackAirT;
import com.spawar.icode.radar.TrackSurfT;
import com.spawar.icode.radar.dataParser.RadarXMLParser;
import java.io.*;
import javax.xml.bind.*;
import java.io.InputStream;
import org.xml.sax.InputSource;

/**
 *
 * @author sparta
 */
class DataLoader
{
    def sessionFactory
    def propertyInstanceMap = DomainClassGrailsPlugin.PROPERTY_INSTANCE_MAP
  
    def loadAllData(){
    
        if (Ais.count() == 0)
        {
            loadAisCSV('SanDiego.csv')
            loadAisCSV('Chile2.csv')
            loadCountryData()
            //loadRadarXML('ST_Track.xml')
        }
    }
  
    def loadRadarXML( def filename )
    {
        def geometryFactory = new GeometryFactory( new PrecisionModel(), 4326 )
        def istream = DataLoader.class.getResourceAsStream( filename )
        
        //Use RadarXMLParser calls
        Vector<Object> vector = RadarXMLParser.read(istream);
        System.out.println("Done Parsing Complete Radar doc: " + vector.size());
        
        //Determine what type of Object we have and add it to the DB
        ListIterator itr = vector.listIterator();
        while (itr.hasNext()) {
            Object obj = itr.next();
            if (obj instanceof STTrackAirT) {
                STTrackAirT air = (STTrackAirT) obj;
                //int UID = air.getMsgID(); //using this as the UID until we figure out what the right thing to use is
                
                //See if it already exists
                /*****************************************************
                def airTrack = RadarAirTrack.findByUID( UID );
                
                if ( !airTrack )
                {
              
                    //airTrack = convertToRadarAirTrack(air);
                }
                ********************************************************/
                

            } 
            else if (obj instanceof STTrackSurfT) {
                STTrackSurfT surf = (STTrackSurfT) obj;
                
              

            } 
            else {
                System.out.println("Don't know what type of Object this element is");
            }
        }//while
        
        
        cleanUpGorm()
        istream?.close()
    }//load Radar Data
    


    def loadAisCSV( def filename )
    {
        
        def geometryFactory = new GeometryFactory( new PrecisionModel(), 4326 )

        def istream = DataLoader.class.getResourceAsStream( filename )
        def count = 0

        istream?.toCsvReader( [skipLines: 1] ).eachLine {  tokens ->

            SimpleDateFormat formatter;  //07-MAY-07 11.41.56 AM
            formatter = new SimpleDateFormat( "yy-MMM-dd hh.mm.ss a" );

            //Search for AIS based on MMSI
            def mmsiID = tokens[0]?.toInteger()
            def ais = Ais.findByMmsi( mmsiID );

            if ( !ais )
            {

                ais = new Ais(
                    mmsi: tokens[0] as Integer,
                    navStatus: tokens[1] as Integer,
                    rateOfTurn: tokens[2] as Float,
                    speedOverGround: tokens[3] as Float,
                    posAccuracy: tokens[21] as Double,
                    courseOverGround: tokens[6] as Double,
                    trueHeading: tokens[7] as Double,
                    IMO: tokens[9] as Integer,
                    callsign: tokens[20],
                    vesselName: tokens[10],
                    vesselType: tokens[11] as Integer,
                    length: tokens[12] as Double,
                    width: tokens[13] as Double,
                    eta: ( new Date() + 30 ),
                    destination: tokens[19]
                )

                //Save new AIS
                ais.save()

                // if ( !ais.save( flush: true ) )
                // {
                //   println( "Error: Save AIS errors: ${ais.errors}" );
                // }
            }

            long timeStamp = tokens[8] as Long
            timeStamp = timeStamp * 1000

            def longitude = tokens[5] as Double
            def latitude = tokens[4] as Double
            def location = new Location(
                longitude: longitude,
                latitude: latitude,
                date: new Date( timeStamp ),
                geometryObject: geometryFactory.createPoint( new Coordinate( longitude, latitude ) )
            )

            if ( ++count % 1000 == 0 )
            {
                cleanUpGorm()
            }
        }

        cleanUpGorm()
        istream?.close()
    }//loadAISCsv


    def cleanUpGorm( )
    {
        def session = sessionFactory.currentSession
        session.flush()
        session.clear()
        propertyInstanceMap.get().clear()
    }

    ////////////////////
    //Load Country Data
    ////////////////////

    def loadCountryData( )
    {
        def istream = DataLoader.class.getResourceAsStream( 'itu_ircs.txt' )
        def words
        int count = 0;

        istream.eachLine { line ->
            count++;
            if ( line.trim().size() == 0 || count == 1 )
            {
                return;
            }
            else
            {

                words = line.split( "[\t]" )
                //def country = new Country();
                def prefix = new CallSignPrefix();

                String countryName = words[2]
                def country = Country.findByName( countryName );
                if ( !country )
                {
                    country = new Country()
                    country.countryCode = words[1]
                    country.name = words[2]

                    country.save()

                    if ( !country.save( flush: true ) )
                    {
                        println( "Error: Save Country errors: ${country.errors}" );
                    }

                }

                prefix.with {
                    prefix.prefix = words[0]
                }

                country.addToCallSignPrefixes( prefix )

            }//not null line
            if ( count % 1000 == 0 )
            {
                cleanUpGorm()
            }
        }//for each

        cleanUpGorm()
        istream.close()

        //////////////////////////////////////
        //Load Maritime Identification digits
        //////////////////////////////////////
        istream = DataLoader.class.getResourceAsStream( 'countrycodes.txt' )

        count = 0;

        istream.eachLine { line ->
            count++;
            if ( line.trim().size() == 0 || count == 1 )
            {
                return;
            }
            else
            {

                words = line.split( "[\t]" )
                def mid = new MaritimeIdDigit();

                String countryCode = words[1]
                def country = Country.findByCountryCode( countryCode );
                if ( !country )
                {
                    country = new Country()
                    country.countryCode = words[1]
                    country.name = words[3]

                    country.save()
                    if ( !country.save( flush: true ) )
                    {
                        println( "Error: Save Country errors: ${country.errors}" );
                    }

                }

                mid.with {
                    mid.mid = words[0]
                }

                country.addToMaritimeIdDigits( mid )

            }//not null line
            if ( count % 1000 == 0 )
            {
                cleanUpGorm()
            }
        }//for each
        cleanUpGorm()
        istream.close()
    }//load Country Data
    
    
    
    //Converter from  JAXB Radar Objects to Grails RadarAirTrack Object
    public RadarAirTrack convertToRadarAirTrack(STTrackAirT rTrack){
        
        RadarAirTrack track = new RadarAirTrack();
        
        track.UID  = rTrack.getMsgID();
        track.messageID=rTrack.getMsgID();
        track.portalName=rTrack.getPortalName();
        track.messageTime=rTrack.getPortalName();

        //Header

        ////SdsTrackID
        track.sdsTrackID_kluster=0; // (0 - 255)
        track.sdsTrackID_port=0; //  (0-15)
        track.sdsTrackID_platform=0; //  (0-15)
        track.sdsTrackID_category=0; //(0-255)
        track.sdsTrackID_amplification=0; //(0-255)
        track.sdsTrackID_site=0; // (0-255)
        track.sdsTrackID_radar=0; // (0-15)
        track.sdsTrackID_trackID=0; //(0-4095)

        ////System Track ID
        track.systemTrackID_kluster=0; // (0 - 255)
        track.systemTrackID_port=0; //  (0-15)
        track.systemTrackID_platform=0; //  (0-15)
        track.systemTrackID_category=0; // (0-255)
        track.systemTrackID_amplification=0;// (0-255)
        track.systemTrackID_site=0; // (0-255)
        track.ystemTrackID_radar=0; // (0-15)
        track.systemTrackID_trackID=0; //(0-4095)


        //Vect
        track.eading=0; // (-360 to 360)
        track.speed=0; //
        track.climb=0; //

        track.bVecValid=false;
        // trackStatus {0=TRK_TRACKING, 1=TRK_COASTING, 2=TRK_NEW, 3=TRK_STALE, 4=TRK_DELETE, 5=TRK_TRAIN_SIDING, 6=TRK_TRAIN_BLOCKED, 63= TRK_UNKNOWN}
        //enum TrackStatus {TRK_TRACKING(0), TRK_COASTING(1), TRK_NEW(2), TRK_STALE(3), TRK_DELETE(4), TRK_TRAIN_SIDING(5),TRK_TRAIN_BLOCKED(6), TRK_UNKNOWN(63)};
        //TrackStatus trackStatus;
    
        track.quality=0;
        track.sdsIndex=0;
        track.bIgnoreAlarms=false;
        track.time=0;
        track.playerListId=0;
        track.bPlayerListIdValid=false;
        track.remote_name="";

        ////////////////////////////
        //Air
        ////////////////////////////
        track.condition=0; //(0-63)
        track.d_3a_validity=false;
        track.md_c_validity=false;
        track.Mode3A=0;
        track.bMode2Valid=false;
        track.mode2=0;
        track.radar_num=0;
        track.extAAHorzSep=0.0;
        track.extAAVertSep=0;
        track.extAALookAhead=0;
        track.extAAHorizBuf=0;
        track.extAAVertExten=0;
        track.extAADebugFlag=0;
        track.extAAVertVel=0;
        track.precisionAltDiff=0;
        track.bPrecisionAltDiffSet=false;
        track.bHDVertVel=false;
        track.bHDHorizVel=false;
        track.bHDDirChange=false;
        track.bHighDynamic=false;
        track.sensorMode3=0;
        track.bSensorMode3Valid=false;
        track.sensorMode2=0
        track.bSensorMode2Valid=false;
        track.sensorCondition=0;

        //AIS Sup
        track.userId=0;//  (0 -999999999 )
        track.ROT=0;// (-721 to 721)
        track.bLessThan10MetersError=0; //(0 to 1 ) 
        track.TypeOfPositionDevice=0; //(0 to 15 )
        track.ReportLat=0;
        track.ReportLon=0;
        track.bCenterPositionValid=0;// (0 to 1) 
        track.CenterLat=0;
        track.CenterLon=0;
        track.corner1Lat=0;
        track.corner1Lon=0;
        track.corner2Lat=0;
        track.corner2Lon=0;
        track.corner3Lat=0;
        track.corner3Lon=0;
        track.corner4Lat=0;
        track.corner4Lon=0;
        track.typeOfShip1=0;// (0 to 19)
        track.typeOfShip2=0;// (-1 to 19)
        track.trueHeading=0; 
        track.callSign="";
        track.name="";
        track.dimensionLength=0; // (0-1022)
        track.dimensionWidth=0; //  (0-126)
        track.ETAmonth=0;//  (-1 to 12)
        track.ETAday=0;//(-1 to 31)
        track.ETAhour=0;// (-1 to 23)
        track.ETAminute=0;// (0-59)
        track.maxDraught=0;//(0 to 255)
        track.destination="";
        track.altitudeGNSS=0;// (0 to 13435)
        track.bSurfaceTrack=false;
        track.bMobileTrack=false;
        track.bSensorSite=false;
        track.bClassA=false;
        
        
    }//Converter
    
    
}//class