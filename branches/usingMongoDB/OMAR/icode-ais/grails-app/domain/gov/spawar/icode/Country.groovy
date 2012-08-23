package gov.spawar.icode

class Country {
    static belongsTo = [ User ]
    static hasMany = [ callSignPrefixes : CallSignPrefix, maritimeIdDigits : MaritimeIdDigit, users : User, ports : Port ]
    static hasOne = [flagStatus: FlagStatus]

    String name;
    String countryCode;
    //ListType flagStatus = ListType.WHITE;

    String toString() { name }

    static constraints = {
        name(unique:true)
        countryCode(unique:true)
        callSignPrefixes()
        maritimeIdDigits()
        flagStatus(unique: true, nullable: true)
    }
}
