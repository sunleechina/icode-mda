package gov.spawar.icode

class Country {

    static hasMany = [ callSignPrefixes : CallSignPrefix ]

    String name;
    String countryCode;

    String toString() { name }

    static constraints = {
        name(unique:true)
        countryCode(unique:true)
    }
}
