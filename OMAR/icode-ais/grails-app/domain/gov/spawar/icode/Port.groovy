package gov.spawar.icode

//import com.vividsolutions.jts.geom.Point

class Port {

    static belongsTo = [country:Country]

    String name="";
    String authority;
    String address;
    String phone;
    String fax;
    String email;
    String webUrl;
    String loCode;
    String type;
    String size;

    //Point geometryObject;
    List geometryObject;



    static constraints = {
        authority( nullable: true )
        address( nullable: true )
        phone(nullable:  true)
        fax(nullable:  true)
        email(nullable:  true)
        webUrl(nullable:  true)
        loCode(nullable:  true)
        type(nullable:  true)
        size(nullable:  true)
    }

    static mapping = {
        //geometryObject type: org.hibernatespatial.GeometryUserType
        geometryObject geoIndex:true
    }
}
