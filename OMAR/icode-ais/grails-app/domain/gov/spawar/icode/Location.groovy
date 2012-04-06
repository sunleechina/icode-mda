package gov.spawar.icode

import com.vividsolutions.jts.geom.Point

class Location
{

  static belongsTo = [ais: Ais]


  Point aisGeom;
  Double latitude;
  Double longitude;
  Date date;
  String name;

  static mapping = {
    columns {
      aisGeom type: org.hibernatespatial.GeometryUserType  //
    }

  }

  static constraints = {
    aisGeom(nullable: false)
    latitude(nullable: false)
    longitude(nullable: false)
    date(nullable: false)
    name(nullable: false)

  }
}

