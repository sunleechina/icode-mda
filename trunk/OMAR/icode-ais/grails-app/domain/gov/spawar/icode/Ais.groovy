package gov.spawar.icode


class Ais {
    
    static hasMany = [ locations : Location ]
    
    int messageType;
    int mmsi;
    int navStatus; 
    float rateOfTurn;  
    float speedOverGround;
    double courseOverGround;  
    double trueHeading; 
    int IMO;  
    String vesselName; 
    int vesselType; 
    double length;  
    double width;  
    double antennaLocationBow;  
    double antennaLocationStern;
    double antennaLocationPort;
    double antennaLocationStarboard; 
    double draught;
    String destination;
    String callsign;  
    double posAccuracy;  
    Date eta;  
    int positionFixType;
    Date dateCreated //Note: This is a special name
    Date lastUpdated

    static constraints = {
        vesselName(blank:false, maxSize:50)
        vesselType()
        mmsi()
        IMO()
        navStatus()
        callsign()
        length()
        width()
    }
    
    String toString(){
        return "${vesselName}}"
    }
    
    static mapping = {
        sort "mmsi"
    }
}

