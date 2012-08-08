package gov.spawar.icode

/**
 * Created with IntelliJ IDEA.
 * User: omar
 * Date: 8/8/12
 * Time: 1:36 AM
 * To change this template use File | Settings | File Templates.
 */
public enum Risk {

    LOW("Low"),
    LOW_TO_MEDIUM("Low to Medium"),
    MEDIUM("Medium"),
    MEDIUM_TO_HIGH("Medium to High"),
    HIGH("High"),
    VERY_HIGH("Very High")

    String value

    Risk(String value){
        this.value = value
    }

    String toString() { value }
    String getKey() { name() }

    static constraints = {
    }
}