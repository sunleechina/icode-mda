package gov.spawar.icode

class VesselType {

    static belongsTo = [ User ]
    static hasMany = [ users : User]

    Integer code;
    String classification;

}