package gov.spawar.icode

import com.vividsolutions.jts.geom.Point

class Location  {

    static belongsTo = [ais:Ais] 
    
    
    Point aisGeom;
    BigDecimal latitude;
    BigDecimal longitude;
    Date   date;
    String name;

    static mapping = {
        columns {
            aisGeom type: org.hibernatespatial.GeometryUserType  //
        }
      
    }
    
    static constraints = {
          //latitude(blank:false, maxSize:40)
        //state(blank:true, maxSize:2)
        //city(blank:true, maxSize:40)
        //ticker(blank:true, maxSize:8)
        
    }
}

