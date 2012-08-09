package gov.spawar.icode


class Ais
{

  static hasMany = [locations: Location, changes: Change]

  //Integer messageType;
  String uId;
  Integer mmsi;
  NavigationStatus navStatus;
  Float rateOfTurn;
  Float speedOverGround;
  Double courseOverGround;
  Double trueHeading;
  Integer IMO;
  String vesselName;
  VesselType vesselType;
  Double length;
  Double width;
  Double antennaLocationBow;
  Double antennaLocationStern;
  Double antennaLocationPort;
  Double antennaLocationStarboard;
  Double draught;
  Country destination;
  String callsign;
  Double posAccuracy;
  Date eta;
  Integer positionFixType;
  MaritimeIdDigit mid;
  Epfd  electronicPositionFixingDevice;

  //Note: This is a special name
  Date dateCreated
  Date lastUpdated

  static constraints = {
    vesselName( nullable: false, blank: false, maxSize: 50 )
    vesselType( nullable: true )
    mmsi( nullable: false, unique: true )
    IMO( nullable: false )
    navStatus( nullable: true )
    callsign( nullable: false )
    length( nullable: false )
    width( nullable: false )
    //messageType( nullable: true )
    navStatus( nullable: true )
    rateOfTurn( nullable: true )
    speedOverGround( nullable: true )
    courseOverGround( nullable: true )
    trueHeading( nullable: true )
    antennaLocationBow( nullable: true )
    antennaLocationStern( nullable: true )
    antennaLocationPort( nullable: true )
    antennaLocationStarboard( nullable: true )
    draught( nullable: true )
    destination( nullable: true )
    posAccuracy( nullable: true )
    eta( nullable: true )
    positionFixType( nullable: true )
    mid(nullable: true)
    electronicPositionFixingDevice(nullable: true)
  }

  String toString( )
  {
    return "${vesselName}}"
  }

  static mapping = {
    sort "mmsi"
    mmsi index: 'ais_mmsi_idx'
    vesselName index: 'ais_vessel_name_idx'
    locations  joinTable: [name:"ais_location",key:'ais_locations_id']
  }
}

