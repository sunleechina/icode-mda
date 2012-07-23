package gov.spawar.icode

import com.spawar.icode.radar.STTrackAirT;
import com.spawar.icode.radar.STTrackSurfT;

class RadarSurfTrack {

    static hasMany = [locations: Location]
    
    String uID=0; //Place holder for our (ICODE) unique ID.
    int messageID=0;
    String portalName="";
    double messageTime=0;

    //Header

    ////SdsTrackID
    int sdsTrackID_kluster=0; // (0 - 255)
    int sdsTrackID_port=0; //  (0-15)
    int sdsTrackID_platform=0; //  (0-15)
    int sdsTrackID_category=0; //(0-255)
    int sdsTrackID_amplification=0; //(0-255)
    int sdsTrackID_site=0; // (0-255)
    int sdsTrackID_radar=0; // (0-15)
    int sdsTrackID_trackID=0; //(0-4095)

    ////System Track ID
    int systemTrackID_kluster=0; // (0 - 255)
    int systemTrackID_port=0; //  (0-15)
    int systemTrackID_platform=0; //  (0-15)
    int systemTrackID_category=0; // (0-255)
    int systemTrackID_amplification=0;// (0-255)
    int systemTrackID_site=0; // (0-255)
    int systemTrackID_radar=0; // (0-15)
    int systemTrackID_trackID=0; //(0-4095)


    //Vect
    double heading=0; // (-360 to 360)
    float speed=0; //
    float climb=0; //

    boolean bVecValid
    //int trackStatus {0=TRK_TRACKING, 1=TRK_COASTING, 2=TRK_NEW, 3=TRK_STALE, 4=TRK_DELETE, 5=TRK_TRAIN_SIDING, 6=TRK_TRAIN_BLOCKED, 63= TRK_UNKNOWN}
    enum TrackStatus {TRK_TRACKING(0), TRK_COASTING(1), TRK_NEW(2), TRK_STALE(3), TRK_DELETE(4), TRK_TRAIN_SIDING(5),TRK_TRAIN_BLOCKED(6), TRK_UNKNOWN(63)};
    TrackStatus trackStatus;
    
    double quality=0;
    int sdsIndex=0;
    boolean bIgnoreAlarms=false;
    double time=0;
    long playerListId=0;
    boolean bPlayerListIdValid=false;
    String remote_name="";

    ////////////////////////////
    //Surf
    ////////////////////////////
    String Name="";
    /***************************************************************************
    int type

    {
        <xs:enumeration value="0" /> <!-- "TKR_P" -->
        <xs:enumeration value="1" /> <!-- "TKR_H" -->
        <xs:enumeration value="2" /> <!-- "TKR_G" -->
        <xs:enumeration value="3" /> <!-- "TOW_P" -->
        <xs:enumeration value="4" /> <!-- "TOW_H" -->
        <xs:enumeration value="5" /> <!-- "TOW_G" -->
        <xs:enumeration value="6" /> <!-- "FER" -->
        <xs:enumeration value="7" /> <!-- "GOVT" -->
        <xs:enumeration value="8" /> <!-- "UNK" -->
        <xs:enumeration value="9" /> <!-- "FREIGHT" -->
        <xs:enumeration value="10" /> <!-- "PASS" -->
        <xs:enumeration value="11" /> <!-- "UTIL" -->
        <xs:enumeration value="12" /> <!-- "VTS_MAX_VESSEL_TYPES" -->

    }
    ******************************************************************************/
    enum VesselType {TKR_P(0), TKR_H(1), TKR_G(2), TOW_P(3), TOW_H(4), TOW_G(5),FER(6), GOVT(7),UNK(8),FREIGHT(9),PASS(10),UTIL(11),VTS_MAX_VESSEL_TYPES(12)};
    VesselType type;
    String vin;

    double reportTime=0;
    float plotSize=0;
    float range=0;
    
    /******************************************************
    {   <xs:enumeration value="0" /> <!-- "TRK_MANUAL" -->
        <xs:enumeration value="1" /> <!-- "TRK_AUTO" -->
        <xs:enumeration value="2" /> <!-- "TRK_GLOBAL" -->
    }
    ********************************************************/
    int acquired=0;

    //AIS Sup
    int userId=0;//  (0 -999999999 )
    double  rot=0;// (-721 to 721)
    int bLessThan10MetersError=0;// (0 to 1 ) 
    int typeOfPositionDevice=0;// (0 to 15 )
    double reportLat=0;
    double reportLon=0;
    int bCenterPositionValid=0; // (0 to 1) 
    double centerLat=0;
    double centerLon=0;
    double corner1Lat=0;
    double corner1Lon=0;
    double corner2Lat=0;
    double corner2Lon=0;
    double corner3Lat=0;
    double corner3Lon=0;
    double corner4Lat=0;
    double corner4Lon=0;
    int typeOfShip1=0;// (0 to 19)
    int typeOfShip2=-1;// (-1 to 19)
    float trueHeading=0; 
    String callSign="";
    int dimensionLength=0;// (0-1022)
    int dimensionWidth=0; //  (0-126)
    int etaMonth=-1; //  (-1 to 12)
    int etaDay=-1; // (-1 to 31)
    int etaHour=-1;// (-1 to 23)
    int etaMinute=0;// (0-59)
    int maxDraught=0; // (0 to 255)
    String destination="";
    float altitudeGNSS=0; // (0 to 13435)
    boolean bSurfaceTrack=false;
    boolean bMobileTrack=false;
    boolean bSensorSite=false;
    boolean bClassA=false;

    static constraints = {
        sdsTrackID_kluster min:0, max:255
        sdsTrackID_port   min:0, max:15
        sdsTrackID_platform  min:0, max:15
        sdsTrackID_category   min:0, max:255
        sdsTrackID_amplification  min:0, max:255
        sdsTrackID_site min:0, max:255
        acquired min:0, max:2
        bCenterPositionValid min:0, max:1
        typeOfShip1 min:0, max:19
        typeOfShip2 min:-1, max:19
        dimensionLength min:0, max:1022
        dimensionWidth min:0, max:126
        etaMonth min:-1, max:12
        etaDay min:-1, max:31
        etaHour min:-1, max:23
        etaMinute min:0, max:59
        maxDraught min:0, max:255
        altitudeGNSS min:0.0f, max:13435.0f
    }
}
