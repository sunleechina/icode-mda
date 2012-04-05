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
        vesselName(nullable:false,blank:false, maxSize:50)
        vesselType(nullable:true)
        mmsi(nullable:false,unique:true)
        IMO(nullable:false)
        navStatus(nullable:true)
        callsign(nullable:false)
        length(nullable:false)
        width(nullable:false)
        messageType(nullable:true)
        navStatus(nullable:true)
        rateOfTurn(nullable:true)
        speedOverGround(nullable:true)
        courseOverGround(nullable:true)
        trueHeading(nullable:true)
        antennaLocationBow(nullable:true)
        antennaLocationStern(nullable:true)
        antennaLocationPort(nullable:true)
        antennaLocationStarboard(nullable:true)
        draught(nullable:true)
        destination(nullable:true)
        posAccuracy(nullable:true)
        eta(nullable:true)
        positionFixType(nullable:true)
    }
    
    String toString(){
        return "${vesselName}}"
    }
    
    static mapping = {
        sort "mmsi"
    }
}

