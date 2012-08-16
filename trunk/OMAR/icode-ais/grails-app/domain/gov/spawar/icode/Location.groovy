package gov.spawar.icode

import com.vividsolutions.jts.geom.Point

class Location
{

  static belongsTo = [Ais, RadarSurfTrack, RadarAirTrack, Vms]
  //static belongsTo = [ais:Ais]


  Point geometryObject;
  //Double latitude=0;
  //Double longitude=0;
  Double altitude=0;
  Date date;

  static mapping = {
    geometryObject type: org.hibernatespatial.GeometryUserType
    date index: 'location_date_idx'
    ais  joinTable: [name:"ais_location",key:'location_id']
  }

  static constraints = {
    geometryObject( nullable: false )
    //latitude( nullable: false )
    //longitude( nullable: false )
    date( nullable: false )
  }
}
