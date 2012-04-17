package gov.spawar.icode

import com.vividsolutions.jts.geom.Point

class Location
{

  static belongsTo = [ais: Ais]


  Point aisGeom;
  Double latitude;
  Double longitude;
  Date date;

  static mapping = {
    aisGeom type: org.hibernatespatial.GeometryUserType
    date index: 'location_date_idx'
  }

  static constraints = {
    aisGeom( nullable: false )
    latitude( nullable: false )
    longitude( nullable: false )
    date( nullable: false )
  }
}

