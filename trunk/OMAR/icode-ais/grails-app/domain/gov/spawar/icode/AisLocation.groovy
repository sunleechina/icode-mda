package gov.spawar.icode

class AisLocation {

    Integer aisLocationsId;
    Integer locationId;
    String sourceId;
    Integer messageType;
    //int version;

    static constraints = {
        //message_type( nullable:  true)
        sourceId( nullable: true )
        messageType( nullable: true)
    }

    static mapping = {
      version false

    }

}
