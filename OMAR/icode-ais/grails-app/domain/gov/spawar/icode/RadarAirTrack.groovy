package gov.spawar.icode

import com.spawar.icode.radar.STTrackAirT;
import com.spawar.icode.radar.STTrackSurfT;

class RadarAirTrack {
    
    static hasMany = [locations: Location]
    
    
    String uID  //Place holder for our (ICODE) unique ID.
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
    //Air
    ////////////////////////////
    int condition=0; //(0-63)
    boolean md_3a_validity=false;
    boolean md_c_validity=false;
    short Mode3A=0;
    boolean bMode2Valid=false;
    short mode2=0;
    short radar_num=0;
    double extAAHorzSep=0.0;
    int extAAVertSep=0;
    double extAALookAhead=0;
    double extAAHorizBuf=0;
    int extAAVertExten=0;
    int extAADebugFlag=0;
    int extAAVertVel=0;
    double precisionAltDiff=0;
    boolean bPrecisionAltDiffSet=false;
    boolean bHDVertVel=false;
    boolean bHDHorizVel=false;
    boolean bHDDirChange=false;
    boolean bHighDynamic=false;
    short sensorMode3=0;
    boolean bSensorMode3Valid=false;
    short sensorMode2=0
    boolean bSensorMode2Valid=false;
    long sensorCondition=0;

    //AIS Sup
    int userId=0;//  (0 -999999999 )
    double  ROT=0;// (-721 to 721)
    int bLessThan10MetersError=0; //(0 to 1 ) 
    int TypeOfPositionDevice=0; //(0 to 15 )
    double ReportLat=0;
    double ReportLon=0;
    int bCenterPositionValid=0;// (0 to 1) 
    double CenterLat=0;
    double CenterLon=0;
    double corner1Lat=0;
    double corner1Lon=0;
    double corner2Lat=0;
    double corner2Lon=0;
    double corner3Lat=0;
    double corner3Lon=0;
    double corner4Lat=0;
    double corner4Lon=0;
    int typeOfShip1=0;// (0 to 19)
    int typeOfShip2=0;// (-1 to 19)
    float trueHeading=0; 
    String callSign="";
    String name="";
    int dimensionLength=0; // (0-1022)
    int dimensionWidth=0; //  (0-126)
    int ETAmonth=0;//  (-1 to 12)
    int ETAday=0;//(-1 to 31)
    int ETAhour=0;// (-1 to 23)
    int ETAminute=0;// (0-59)
    int maxDraught=0;//(0 to 255)
    String destination="";
    float altitudeGNSS=0;// (0 to 13435)
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
        
    }
    
}
