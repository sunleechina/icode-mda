package gov.spawar.icode

class CallSignPrefix {

    static belongsTo = [country:Country]

    String prefix;


    String toString() { prefix }

    static constraints = {
    }
}
