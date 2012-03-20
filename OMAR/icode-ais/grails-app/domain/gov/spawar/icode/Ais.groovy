package gov.spawar.icode


class Ais {
    
    static hasMany = [ locations : Location ]
    
    Integer messageType;
    Integer mmsi;
    Integer navStatus; 
    Float rateOfTurn;  
    Float speedOverGround;
    Double courseOverGround;  
    Double trueHeading; 
    Integer IMO;  
    String vesselName; 
    Integer vesselType; 
    Double length;  
    Double width;  
    Double antennaLocationBow;  
    Double antennaLocationStern;
    Double antennaLocationPort;
    Double antennaLocationStarboard; 
    Double draught;
    String destination;
    String callsign;  
    Double posAccuracy;  
    Date eta;  
    Integer positionFixType;
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

