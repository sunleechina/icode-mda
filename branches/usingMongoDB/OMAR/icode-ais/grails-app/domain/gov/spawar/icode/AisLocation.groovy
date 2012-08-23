package gov.spawar.icode

class AisLocation {

    Integer aisLocationsId;
    Integer locationId;
    String messageSourceId="";
    MessageType messageType;
    //int version;

    static constraints = {
        //message_type( nullable:  true)
        messageSourceId( nullable: true )
        messageType( nullable: true)
    }

    static mapping = {
      version false

    }

}
