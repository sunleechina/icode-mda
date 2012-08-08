package gov.spawar.icode

/**
 * FlagStatus:  White-Grey-Black list and risk associated with each country
 *
 */

class FlagStatus {

    Double excessFactor=0;
    ListType listType = ListType.WHITE;
    Risk risk = Risk.LOW
    Country country;

    static constraints = {
    }
}
