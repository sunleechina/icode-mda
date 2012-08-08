package gov.spawar.icode

public enum ListType {

    WHITE('White'),
    GREY('Grey'),
    BLACK('Black')

    String name

    ListType(String name){
        this.name = name
    }

    static constraints = {
    }
}
