package gov.spawar.icode

public enum FlagStatus {

    WHITE('Country is in good standing'),
    GREY('Whatever'),
    BLACK('Country is not in good standing')

    String name

    FlagStatus(String name){
        this.name = name
    }

    static constraints = {
    }
}
