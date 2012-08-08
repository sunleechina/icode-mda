package gov.spawar.icode

/*
*  MID (Maritime ID Digit): consists of 3 digits, always starting with a digit from 2 to 7 (assigned regionally).
*
    Three of the nine digits of an MMSI identify country of origin.  In the case of a coast station these digits
    indicate the country of location, and in the case of a ship station, the country of registration.
    The remaining six digits uniquely identify the station itself.  The three digits identifying the country are
    known as the Maritime Identification Digits or MID.  Australia's MID is 503.

    An Australian vessel MMSI takes the form 503xxxxxx where x is any figure from 0 to 9.
*
 */

class MaritimeIdDigit {

    static belongsTo = [country:Country]

    String mid;


    String toString() { mid }

    static constraints = {
    }
}
