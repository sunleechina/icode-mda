package gov.spawar.icode

class Change {

    static hasMany = [ais: Ais]
    static belongsTo = [Ais]

    String key;
    String valueNew;
    String valueOld;

    //Note: This is a special name
    Date dateCreated
    Date lastUpdated

    static constraints = {
    }
}
