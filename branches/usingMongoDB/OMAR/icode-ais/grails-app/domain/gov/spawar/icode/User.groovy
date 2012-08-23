package gov.spawar.icode


import org.ossim.omar.security.SecUser

class User extends SecUser {

    static hasMany = [ countryOfInterest: Country, destinationOfInterest: Country, vesselTypeOfInterest: VesselType ]


    static constraints = {
    }

  static mapping = {
    table 'spawar_user'
  }
}
