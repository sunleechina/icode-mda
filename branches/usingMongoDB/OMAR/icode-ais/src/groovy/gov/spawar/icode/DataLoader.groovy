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
import com.spawar.icode.radar.vms.parser.VmsData;
import com.spawar.icode.radar.vms.parser.VmsParser;
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
           loadCountryData()
           loadPortData()
           loadVesselData()
           loadMessageTypeData()
           loadNavigationStatus()
           loadCountryClass()
           loadRadarXML('ST_Track.xml')
           loadVmsData()
           loadAisCSV('SanDiego.csv')
           loadAisCSV('Chile2.csv')
        }
    }

    def loadVmsData()
    {
        String filename = "vmsData.txt";
        def geometryFactory = new GeometryFactory( new PrecisionModel(), 4326 )
        def istream = DataLoader.class.getResourceAsStream( filename )
        def count = 0

        //Use VmsParser Libarary
        VmsParser parser = new VmsParser(istream);
        Vector<VmsData> vector = parser.parseFile();
        //System.out.println("Done Parsing Complete VMS doc: " + vector.size());


        ListIterator itr = vector.listIterator();
        while (itr.hasNext()) {
            Object obj = itr.next();
            VmsData vmsData = (VmsData)obj;
            String name =  vmsData.getVESSELNAME(); //XXX Need a way to uniquely Identify VMS data

            //See if it already exists
            def vms = Vms.findByVesselName( name );

            if ( !vms )
            {
                vms = convertToVms(vmsData);

                //Add to DB
                vms.save();
            }

            /////////////////////////////////
            //Save Location Information
            /////////////////////////////////

            def longitude = vms.getLon();
            def latitude  = vms.getLat();
            def location = new Location(
                    longitude: longitude,
                    latitude: latitude,
                    date: vms.date,
                    //geometryObject: geometryFactory.createPoint( new Coordinate( longitude, latitude ) )
                    geometryObject: [longitude,latitude]
            )

            location['source']='vms'
            location['vms']= vms.id;
            location.save();
            vms.addToLocations( location )

            if ( ++count % 1000 == 0 )
            {
                cleanUpGorm()
            }

        }


        // cleanUpGorm()
        istream?.close()
    }//load VMS Data
  
    def loadRadarXML( def filename )
    {
        def geometryFactory = new GeometryFactory( new PrecisionModel(), 4326 )
        def istream = DataLoader.class.getResourceAsStream( filename )
        def count = 0
        
        //Use RadarXMLParser calls
        Vector<Object> vector = RadarXMLParser.read(istream);
        //System.out.println("Done Parsing Complete Radar doc: " + vector.size());
        
        //Determine what type of Object we have and add it to the DB
        ListIterator itr = vector.listIterator();
        while (itr.hasNext()) {
            Object obj = itr.next();

            //Air Track
            if (obj instanceof STTrackAirT) {
                STTrackAirT air = (STTrackAirT) obj;
                int UID = air.getAir().getAisSup().getUserId() //using this as the UID until we figure out what the right thing to use is
                
                //See if it already exists
                def airTrack = RadarAirTrack.findByUID( UID );
                
                if ( !airTrack )
                {
                    airTrack = convertToRadarAirTrack(air);

                    //Add to DB
                    airTrack.save();
                }

                /////////////////////////////////
                //Save Location Information
                /////////////////////////////////
                long timeStamp = air.getMsgTime() as Long
                timeStamp = timeStamp * 1000

                def longitude = air.getHdr().getLoc().getLon();
                def latitude = air.getHdr().getLoc().getLat()
                def location = new Location(
                        longitude: longitude,
                        latitude: latitude,
                        date: new Date( timeStamp ),
                        //geometryObject: geometryFactory.createPoint( new Coordinate( longitude, latitude ) )
                        geometryObject: [longitude, latitude]
                )

                location['source']= 'radarAirTrack';
                location['radarAirTrack']= airTrack.id;
                location.save();
                airTrack.addToLocations( location )

                if ( ++count % 1000 == 0 )
                {
                    cleanUpGorm()
                }
                

            }
            //Surf Track
            else if (obj instanceof STTrackSurfT) {
                STTrackSurfT surf = (STTrackSurfT) obj;

                int UID = surf.getSurf().getAisSup().getUserId() //using this as the UID until we figure out what the right thing to use is

                //See if it already exists
                def surfTrack = RadarSurfTrack.findByUID( UID );

                if ( !surfTrack )
                {
                    surfTrack = convertToRadarSurfTrack(surf);

                    //Add to DB
                    surfTrack.save();
                }

                /////////////////////////////////
                //Save Location Information
                /////////////////////////////////
                long timeStamp = surf.getMsgTime() as Long
                timeStamp = timeStamp * 1000

                def longitude = surf.getHdr().getLoc().getLon();
                def latitude = surf.getHdr().getLoc().getLat()
                def location = new Location(
                        longitude: longitude,
                        latitude: latitude,
                        date: new Date( timeStamp ),
                        //geometryObject: geometryFactory.createPoint( new Coordinate( longitude, latitude ) )
                        geometryObject: [longitude, latitude]
                )

                location['source']= 'radarSurfTrack';
                location['radarSurfTrack']= surfTrack.id;
                location.save();

                surfTrack.addToLocations( location )

                if ( ++count % 1000 == 0 )
                {
                    cleanUpGorm()
                }


            } 
            else {
                System.out.println("Don't know what type of Object this element is");
            }
        }//while
        
        
       // cleanUpGorm()
        istream?.close()
    }//load Radar Data
    

    ////////////////////////////////
    // Load AIS Data
    ///////////////////////////////
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
                    //destination: tokens[19]
                    //mid //MaritimeIdDigit
                )

                //Find NavStatus
                int navCode = tokens[1] as Integer
                def nav = NavigationStatus.findByCode(navCode);
                if(nav) ais.navStatus = nav;

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
                //geometryObject: geometryFactory.createPoint( new Coordinate( longitude, latitude ) ),
                //geometryObject:[lat: latitude, lon: longitude]
                geometryObject:[longitude, latitude]
            )

            location['source']= 'ais';
            location['ais']= ais.id;
            location.save();

            ais.addToLocations( location )
            ais.save();




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
       // def session = sessionFactory.currentSession
       // session.flush()
       // session.clear()
       // propertyInstanceMap.get().clear()
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

        //cleanUpGorm()
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
        //cleanUpGorm()
        istream.close()
    }//load Country Data




    ////////////////////
    //Load Vessel Type Data
    ////////////////////
    def loadVesselData( )
    {

        def istream = DataLoader.class.getResourceAsStream( 'vesselType.txt' )
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
                def type = new VesselType();


                type.code = words[0].toInteger();
                type.classification = words[1]

                type.save()
                if ( !type.save( flush: true ) )
                {
                    println( "Error: Save Type errors: ${type.errors}" );
                }
            }//else
            if ( count % 1000 == 0 )
            {
                cleanUpGorm()
            }
        }//for each
        cleanUpGorm()
        istream.close()
    }//load Vessel Type Data


    ////////////////////
    //Load Message Types
    ////////////////////
    def loadMessageTypeData( )
    {

        def istream = DataLoader.class.getResourceAsStream( 'messageType.txt' )
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
                def type = new MessageType();


                type.code = words[0].toInteger();
                type.description = words[1]

                type.save()
                if ( !type.save( flush: true ) )
                {
                    println( "Error: Save Message Type errors: ${type.errors}" );
                }
            }//else
            if ( count % 1000 == 0 )
            {
                cleanUpGorm()
            }
        }//for each
        cleanUpGorm()
        istream.close()
    }//load Vessel Type Data



    ////////////////////
    //Load Navigation Status
    ////////////////////
    def loadNavigationStatus( )
    {

        def istream = DataLoader.class.getResourceAsStream( 'navigationStatus.txt' )
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
                def type = new NavigationStatus();


                type.code = words[0].toInteger();
                type.description = words[1]

                type.save()
                if ( !type.save( flush: true ) )
                {
                    println( "Error: Save Nav Status Type errors: ${type.errors}" );
                }
            }//else
            if ( count % 1000 == 0 )
            {
                cleanUpGorm()
            }
        }//for each
        cleanUpGorm()
        istream.close()
    }//load Vessel Type Data




    ////////////////////
    //Load EPFD Types
    ////////////////////
    def loadEPFD( )
    {

        def istream = DataLoader.class.getResourceAsStream( 'epfd.txt' )
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
                def type = new Epfd();


                type.code = words[0].toInteger();
                type.positionFixType = words[1]

                type.save()
                if ( !type.save( flush: true ) )
                {
                    println( "Error: Save EPFD Type errors: ${type.errors}" );
                }
            }//else
            if ( count % 1000 == 0 )
            {
                cleanUpGorm()
            }
        }//for each
        cleanUpGorm()
        istream.close()
    }//load Vessel Type Data




    ////////////////////////////////
    // Load Port Data
    ///////////////////////////////
    def loadPortData()
    {
        def geometryFactory = new GeometryFactory( new PrecisionModel(), 4326 )
        def istream = DataLoader.class.getResourceAsStream( 'ports.txt' )
        def words;
        int count = 0;

        istream.eachLine { line ->
            count++;
            if ( line.trim().size() == 0 || count == 1 || line.startsWith('#') )
            {
                return;
            }
            else
            {

                words = line.split( "[\t]" )

                String countryCode = words[0]
                def country = Country.findByCountryCode( countryCode );
                if ( country )
                {

                    def longitude = words[3] as Double
                    def latitude = words[2] as Double
                    String strName = words[1]
                    def port = new Port(
                            name: strName,
                            //geometryObject: geometryFactory.createPoint( new Coordinate( longitude, latitude ) )
                            geometryObject: [longitude, latitude]
                    )

                    country.addToPorts( port)

                }
            }//not null line
            if ( count % 1000 == 0 )
            {
                cleanUpGorm()
            }
        }//for each
        cleanUpGorm()
        istream.close()


        }//load Ports





    ////////////////////////////////
    // Load Country Classification
    ///////////////////////////////
    def loadCountryClass()
    {
        def istream = DataLoader.class.getResourceAsStream( 'countryClassification.txt' )
        def words;
        int count = 0;

        istream.eachLine { line ->
            count++;
            if ( line.trim().size() == 0 || count == 1 || line.startsWith('#') )
            {
                return;
            }
            else
            {

                words = line.split( "[\t]" )

                String countryCode = words[0]
                def country = Country.findByCountryCode( countryCode );
                if ( country )
                {

                    def excess = words[2] as Double
                    String newRisk = words[3]
                    String newType = words[4]

                    FlagStatus status = new FlagStatus();
                    status.excessFactor = excess;

                    //Risk
                    if(newRisk.equalsIgnoreCase("Low")){
                        status.risk= Risk.LOW;
                    }
                    else if(newRisk.equalsIgnoreCase("Low to Medium")){
                        status.risk = Risk.LOW_TO_MEDIUM;
                    }
                    else if(newRisk.equalsIgnoreCase("Medium")){
                        status.risk = Risk.MEDIUM;
                    }
                    else if(newRisk.equalsIgnoreCase("Medium to High")){
                        status.risk = Risk.MEDIUM_TO_HIGH;
                    }
                    else if(newRisk.equalsIgnoreCase("High")){
                        status.risk = Risk.HIGH;
                    }
                    else if(newRisk.equalsIgnoreCase("very high")){
                        status.risk = Risk.VERY_HIGH;
                    }

                    //List Type
                    if(newType.equalsIgnoreCase("white")){
                        status.listType = ListType.WHITE
                    }
                    else if(newType.equalsIgnoreCase("grey")){
                        status.listType = ListType.GREY;
                    }
                    else if(newType.equalsIgnoreCase("black")){
                        status.listType = ListType.GREY;
                    }
                    //status.setCountry(country)
                    //country.flagStatus = status;
                    //country.add
                    //country.save()
                   country.setFlagStatus(status);
                   country.save();
                }
            }//not null line
            if ( count % 1000 == 0 )
            {
                cleanUpGorm()
            }
        }//for each
        cleanUpGorm()
        istream.close()


    }//load Class




    /**
     * Convert from Java Object VmsData to Grails Object VMS
     * @param data
     * @return
     */
    public Vms convertToVms(VmsData data){
        Vms vms = new Vms();

        vms.callSign = data.getCALLSIGN();
        vms.country = data.getCOUNTRY();
        vms.course = data.getCOURSE();
        vms.date  = data.getDATE();
        vms.destination = data.getDESTINATION();
        vms.flag  = data.getFLAG();
        vms.lat  = data.getLAT();
        vms.lon = data.getLON();
        vms.messageType = data.getMESSAGETYPE();
        vms.registration = data.getREGISTRATION();
        vms.speed = data.getSPEED();
        vms.vesselName = data.getVESSELNAME();

        return vms;
    }




    //Converter from  JAXB Radar Objects to Grails RadarAirTrack Object
    public RadarAirTrack convertToRadarAirTrack(STTrackAirT rTrack){
        
        RadarAirTrack track = new RadarAirTrack();
        
        track.uID  = rTrack.getAir().getAisSup().getUserId()
        track.messageID=rTrack.getMsgID();
        track.portalName=rTrack.getPortalName();
        track.messageTime=rTrack.getMsgTime();

        //Header

        ////SdsTrackID
        track.sdsTrackID_kluster=rTrack.getHdr().getSdsTrackID().getKluster() // (0 - 255)
        track.sdsTrackID_port=rTrack.getHdr().getSdsTrackID().getPort() //  (0-15)
        track.sdsTrackID_platform=rTrack.getHdr().getSdsTrackID().getPlatform() //  (0-15)
        track.sdsTrackID_category=rTrack.getHdr().getSdsTrackID().getCategory() //(0-255)
        track.sdsTrackID_amplification=rTrack.getHdr().getSdsTrackID().getAmplification() //(0-255)
        track.sdsTrackID_site=rTrack.getHdr().getSdsTrackID().getSite()// (0-255)
        track.sdsTrackID_radar=rTrack.getHdr().getSdsTrackID().getRadar() // (0-15)
        track.sdsTrackID_trackID=rTrack.getHdr().getSdsTrackID().getTrackID() //(0-4095)

        ////System Track ID
        track.systemTrackID_kluster=rTrack.getHdr().getSystemTrackID().getKluster() // (0 - 255)
        track.systemTrackID_port=rTrack.getHdr().getSystemTrackID().getPort() //  (0-15)
        track.systemTrackID_platform=rTrack.getHdr().getSystemTrackID().getPlatform() //  (0-15)
        track.systemTrackID_category=rTrack.getHdr().getSystemTrackID().getCategory() // (0-255)
        track.systemTrackID_amplification=rTrack.getHdr().getSystemTrackID().getAmplification()// (0-255)
        track.systemTrackID_site=rTrack.getHdr().getSystemTrackID().getSite() // (0-255)
        track.systemTrackID_radar=rTrack.getHdr().getSystemTrackID().getSite() // (0-15)
        track.systemTrackID_trackID=rTrack.getHdr().getSystemTrackID().getTrackID() //(0-4095)


        //Vect
        track.heading=rTrack.getHdr().getVec().getHeading() // (-360 to 360)
        track.speed=rTrack.getHdr().getVec().getSpeed()//
        track.climb=rTrack.getHdr().getVec().getClimb() //

        track.bVecValid=false;
        // trackStatus {0=TRK_TRACKING, 1=TRK_COASTING, 2=TRK_NEW, 3=TRK_STALE, 4=TRK_DELETE, 5=TRK_TRAIN_SIDING, 6=TRK_TRAIN_BLOCKED, 63= TRK_UNKNOWN}
        //enum TrackStatus {TRK_TRACKING(0), TRK_COASTING(1), TRK_NEW(2), TRK_STALE(3), TRK_DELETE(4), TRK_TRAIN_SIDING(5),TRK_TRAIN_BLOCKED(6), TRK_UNKNOWN(63)};
        //TrackStatus trackStatus;
    
        track.quality=rTrack.getHdr().getQuality()
        track.sdsIndex=rTrack.getHdr().getSdsIndex()
        track.bIgnoreAlarms=rTrack.getHdr().BIgnoreAlarms
        track.time=rTrack.getHdr().getTime()
        track.playerListId=rTrack.getHdr().getPlayerListId()
        track.bPlayerListIdValid=rTrack.getHdr().BPlayerListIdValid
        track.remote_name=rTrack.getHdr().getRemoteName()

        ////////////////////////////
        //Air
        ////////////////////////////
        track.condition=rTrack.getAir().getCondition() //(0-63)
        track.md_3a_validity=rTrack.getAir().isMd3AValidity()
        track.md_c_validity=rTrack.getAir().isMdCValidity()
        track.Mode3A=rTrack.getAir().getMode3A()
        track.bMode2Valid=rTrack.getAir().isBMode2Valid()
        track.mode2=rTrack.getAir().getMode2()
        track.radar_num=rTrack.getAir().getRadarNum()
        track.extAAHorzSep=rTrack.getAir().getExtAAHorzSep()
        track.extAAVertSep=rTrack.getAir().getExtAAVertSep()
        track.extAALookAhead=rTrack.getAir().getExtAALookAhead()
        track.extAAHorizBuf=rTrack.getAir().getExtAAHorizBuf()
        track.extAAVertExten=rTrack.getAir().getExtAAVertExten()
        track.extAADebugFlag=rTrack.getAir().extAADebugFlag
        track.extAAVertVel=rTrack.getAir().getExtAAVertVel()
        track.precisionAltDiff=rTrack.getAir().getPrecisionAltDiff()
        track.bPrecisionAltDiffSet=rTrack.getAir().isBPrecisionAltDiffSet()
        track.bHDVertVel=rTrack.getAir().isBHDVertVel()
        track.bHDHorizVel=rTrack.getAir().isBHDHorizVel()
        track.bHDDirChange=rTrack.getAir().isBHDDirChange()
        track.bHighDynamic=rTrack.getAir().isBHighDynamic()
        track.sensorMode3=rTrack.getAir().getSensorMode3()
        track.bSensorMode3Valid=rTrack.getAir().isBSensorMode3Valid()
        track.sensorMode2=rTrack.getAir().getSensorMode2()
        track.bSensorMode2Valid=rTrack.getAir().isBMode2Valid()
        track.sensorCondition=rTrack.getAir().getSensorCondition()

        //AIS Sup
        track.userId=rTrack.getAir().getAisSup().getUserId()//  (0 -999999999 )
        track.ROT=rTrack.getAir().getAisSup().getROT()// (-721 to 721)
        track.bLessThan10MetersError=rTrack.getAir().getAisSup().getBLessThan10MetersError(); //(0 to 1 )
        track.TypeOfPositionDevice=rTrack.getAir().getAisSup().getTypeOfPositionDevice(); //(0 to 15 )
        track.ReportLat=rTrack.getAir().getAisSup().getReportLat()
        track.ReportLon=rTrack.getAir().getAisSup().getReportLon()
        track.bCenterPositionValid=rTrack.getAir().getAisSup().getBCenterPositionValid()// (0 to 1)
        track.CenterLat=rTrack.getAir().getAisSup().getCenterLat()
        track.CenterLon=rTrack.getAir().getAisSup().getCenterLon()
        track.corner1Lat=rTrack.getAir().getAisSup().getCorner1Lat()
        track.corner1Lon=rTrack.getAir().getAisSup().getCorner1Lon()
        track.corner2Lat=rTrack.getAir().getAisSup().getCorner2Lat()
        track.corner2Lon=rTrack.getAir().getAisSup().getCorner2Lon()
        track.corner3Lat=rTrack.getAir().getAisSup().getCorner3Lat()
        track.corner3Lon=rTrack.getAir().getAisSup().getCorner3Lon()
        track.corner4Lat=rTrack.getAir().getAisSup().getCorner4Lat()
        track.corner4Lon=rTrack.getAir().getAisSup().getCorner4Lon()
        track.typeOfShip1=rTrack.getAir().getAisSup().getTypeOfShip1()// (0 to 19)
        track.typeOfShip2=rTrack.getAir().getAisSup().getTypeOfShip2()// (-1 to 19)
        track.trueHeading=rTrack.getAir().getAisSup().getTrueHeading()
        track.callSign=rTrack.getAir().getAisSup().getCallSign()
        track.name=rTrack.getAir().getAisSup().getName()
        track.dimensionLength=rTrack.getAir().getAisSup().getDimensionLength()// (0-1022)
        track.dimensionWidth=rTrack.getAir().getAisSup().getDimensionWidth(); //  (0-126)
        track.ETAmonth=rTrack.getAir().getAisSup().getETAmonth()//  (-1 to 12)
        track.ETAday=rTrack.getAir().getAisSup().getETAday()//(-1 to 31)
        track.ETAhour=rTrack.getAir().getAisSup().getETAhour()// (-1 to 23)
        track.ETAminute=rTrack.getAir().getAisSup().getETAminute()// (0-59)
        track.maxDraught=rTrack.getAir().getAisSup().getMaxDraught()//(0 to 255)
        track.destination=rTrack.getAir().getAisSup().getDestination()
        track.altitudeGNSS=rTrack.getAir().getAisSup().getAltitudeGNSS()// (0 to 13435)
        track.bSurfaceTrack=rTrack.getAir().getAisSup().isBSurfaceTrack()
        track.bMobileTrack=rTrack.getAir().getAisSup().isBMobileTrack()
        track.bSensorSite=rTrack.getAir().getAisSup().isBSensorSite()
        track.bClassA=rTrack.getAir().getAisSup().isBClassA()

        return track;
        
    }//Converter


    //Converter from  JAXB Radar Objects to Grails RadarAirTrack Object
    public RadarSurfTrack convertToRadarSurfTrack(STTrackSurfT rTrack){

        RadarSurfTrack track = new RadarSurfTrack();

        track.uID  = rTrack.getSurf().getAisSup().getUserId();
        track.messageID=rTrack.getMsgID();
        track.portalName=rTrack.getPortalName();
        track.messageTime=rTrack.getMsgTime();

        //Header

        ////SdsTrackID
        track.sdsTrackID_kluster=rTrack.getHdr().getSdsTrackID().getKluster() // (0 - 255)
        track.sdsTrackID_port=rTrack.getHdr().getSdsTrackID().getPort() //  (0-15)
        track.sdsTrackID_platform=rTrack.getHdr().getSdsTrackID().getPlatform() //  (0-15)
        track.sdsTrackID_category=rTrack.getHdr().getSdsTrackID().getCategory() //(0-255)
        track.sdsTrackID_amplification=rTrack.getHdr().getSdsTrackID().getAmplification() //(0-255)
        track.sdsTrackID_site=rTrack.getHdr().getSdsTrackID().getSite()// (0-255)
        track.sdsTrackID_radar=rTrack.getHdr().getSdsTrackID().getRadar() // (0-15)
        track.sdsTrackID_trackID=rTrack.getHdr().getSdsTrackID().getTrackID() //(0-4095)

        ////System Track ID
        track.systemTrackID_kluster=rTrack.getHdr().getSystemTrackID().getKluster() // (0 - 255)
        track.systemTrackID_port=rTrack.getHdr().getSystemTrackID().getPort() //  (0-15)
        track.systemTrackID_platform=rTrack.getHdr().getSystemTrackID().getPlatform() //  (0-15)
        track.systemTrackID_category=rTrack.getHdr().getSystemTrackID().getCategory() // (0-255)
        track.systemTrackID_amplification=rTrack.getHdr().getSystemTrackID().getAmplification()// (0-255)
        track.systemTrackID_site=rTrack.getHdr().getSystemTrackID().getSite() // (0-255)
        track.systemTrackID_radar=rTrack.getHdr().getSystemTrackID().getSite() // (0-15)
        track.systemTrackID_trackID=rTrack.getHdr().getSystemTrackID().getTrackID() //(0-4095)


        //Vect
        track.heading=rTrack.getHdr().getVec().getHeading() // (-360 to 360)
        track.speed=rTrack.getHdr().getVec().getSpeed()//
        track.climb=rTrack.getHdr().getVec().getClimb() //

        track.bVecValid=false;
        // trackStatus {0=TRK_TRACKING, 1=TRK_COASTING, 2=TRK_NEW, 3=TRK_STALE, 4=TRK_DELETE, 5=TRK_TRAIN_SIDING, 6=TRK_TRAIN_BLOCKED, 63= TRK_UNKNOWN}
        //enum TrackStatus {TRK_TRACKING(0), TRK_COASTING(1), TRK_NEW(2), TRK_STALE(3), TRK_DELETE(4), TRK_TRAIN_SIDING(5),TRK_TRAIN_BLOCKED(6), TRK_UNKNOWN(63)};
        //TrackStatus trackStatus;

        track.quality=rTrack.getHdr().getQuality()
        track.sdsIndex=rTrack.getHdr().getSdsIndex()
        track.bIgnoreAlarms=rTrack.getHdr().BIgnoreAlarms
        track.time=rTrack.getHdr().getTime()
        track.playerListId=rTrack.getHdr().getPlayerListId()
        track.bPlayerListIdValid=rTrack.getHdr().BPlayerListIdValid
        track.remote_name=rTrack.getHdr().getRemoteName()

        ////////////////////////////
        //Surf
        ////////////////////////////
        track.Name=rTrack.getSurf().getAisSup().getName()
        // enum VesselType {TKR_P(0), TKR_H(1), TKR_G(2), TOW_P(3), TOW_H(4), TOW_G(5),FER(6), GOVT(7),UNK(8),FREIGHT(9),PASS(10),UTIL(11),VTS_MAX_VESSEL_TYPES(12)};
        //VesselType type;
        track.vin = rTrack.getSurf().getVi().getVin()

        track.reportTime=rTrack.getSurf().getReportTime()
        track.plotSize=rTrack.getSurf().getPlotSize()
        track.range=rTrack.getSurf().getRange()

        /******************************************************
         {   <xs:enumeration value="0" /> <!-- "TRK_MANUAL" -->
         <xs:enumeration value="1" /> <!-- "TRK_AUTO" -->
         <xs:enumeration value="2" /> <!-- "TRK_GLOBAL" -->
         }
         ********************************************************/
        track.acquired=rTrack.getSurf().getAcquired()

        //AIS Sup
        track.userId=rTrack.getSurf().getAisSup().getUserId();//  (0 -999999999 )
        track.rot=rTrack.getSurf().getAisSup().getROT()// (-721 to 721)
        track.bLessThan10MetersError=rTrack.getSurf().getAisSup().getBLessThan10MetersError();// (0 to 1 )
        track.typeOfPositionDevice=rTrack.getSurf().getAisSup().getTypeOfPositionDevice()// (0 to 15 )
        track.reportLat=rTrack.getSurf().getAisSup().getReportLat()
        track.reportLon=rTrack.getSurf().getAisSup().getReportLon()
        track.bCenterPositionValid=rTrack.getSurf().getAisSup().getBCenterPositionValid()// (0 to 1)
        track.centerLat=rTrack.getSurf().getAisSup().getCenterLat()
        track.centerLon=rTrack.getSurf().getAisSup().getCenterLon()
        track.corner1Lat=rTrack.getSurf().getAisSup().getCorner1Lat()
        track.corner1Lon=rTrack.getSurf().getAisSup().getCorner1Lon()
        track.corner2Lat=rTrack.getSurf().getAisSup().getCorner2Lat()
        track.corner2Lon=rTrack.getSurf().getAisSup().getCorner2Lon()
        track.corner3Lat=rTrack.getSurf().getAisSup().getCorner3Lat()
        track.corner3Lon=rTrack.getSurf().getAisSup().getCorner4Lon()
        track.corner4Lat=rTrack.getSurf().getAisSup().getCorner4Lat()
        track.corner4Lon=rTrack.getSurf().getAisSup().getCorner4Lon()
        track.typeOfShip1=rTrack.getSurf().getAisSup().getTypeOfShip1()// (0 to 19)
        track.typeOfShip2=rTrack.getSurf().getAisSup().getTypeOfShip2()// (-1 to 19)
        track.trueHeading=rTrack.getSurf().getAisSup().getTrueHeading()
        track.callSign=rTrack.getSurf().getAisSup().getCallSign()
        track.dimensionLength=rTrack.getSurf().getAisSup().getDimensionLength()// (0-1022)
        track.dimensionWidth=rTrack.getSurf().getAisSup().getDimensionWidth() //  (0-126)
        track.etaMonth=rTrack.getSurf().getAisSup().getETAmonth() //  (-1 to 12)
        track.etaDay=rTrack.getSurf().getAisSup().getETAday() // (-1 to 31)
        track.etaHour=rTrack.getSurf().getAisSup().getETAhour()// (-1 to 23)
        track.etaMinute=rTrack.getSurf().getAisSup().getETAminute()// (0-59)
        track.maxDraught=rTrack.getSurf().getAisSup().getMaxDraught(); // (0 to 255)
        track.destination=rTrack.getSurf().getAisSup().getDestination();
        track.altitudeGNSS=rTrack.getSurf().getAisSup().getAltitudeGNSS(); // (0 to 13435)
        track.bSurfaceTrack=rTrack.getSurf().getAisSup().isBSurfaceTrack()
        track.bMobileTrack=rTrack.getSurf().getAisSup().isBMobileTrack()
        track.bSensorSite=rTrack.getSurf().getAisSup().isBSensorSite()
        track.bClassA=rTrack.getSurf().getAisSup().BClassA

        return track;

    }//Converter
    
    
}//class