package gov.spawar.icode

class MaritimeIdDigit {

    static belongsTo = [country:Country]

    String mid;


    String toString() { mid }

    static constraints = {
    }
}
