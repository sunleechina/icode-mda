package gov.spawar.icode

class AisLocation {

    Integer aisLocationsId;
    Integer locationId;
    String messageSourceId="";
    MessageType messageType;

    static constraints = {
        messageSourceId( nullable: true )
        messageType( nullable: true)
    }

    static mapping = {
      version false

    }

}
