package gov.spawar.icode

import grails.test.GrailsUnitTestCase
import grails.test.mixin.*
import groovy.mock.interceptor.*
import groovy.time.TimeCategory
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import grails.plugins.rest.client.*


/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(PostToDDFService)
class PostToDDFServiceTests extends GrailsUnitTestCase{

    void setUp(){
        super.setUp()
        use(TimeCategory){
            Ais ais1 = new Ais(mmsi: 1 as Integer,
                //navStatus: tokens[1] as Integer,
                rateOfTurn: 1.0 as Float,
                speedOverGround: 1.2 as Float,
                posAccuracy: 1.2 as Double,
                courseOverGround: 1.2 as Double,
                trueHeading: 1.2 as Double,
                IMO: 1 as Integer,
                callsign: "Maverick",
                vesselName: "Costa",
                //vesselType: tokens[11] as Integer,            //XXX Need to replace this with type logic
                length: 2.0 as Double,
                width: 2.0 as Double,
                eta: ( new Date() + 30 ),
                dateCreated: new Date(),
                lastUpdated: new Date())
            Ais ais2 = new Ais(mmsi: 1 as Integer,
                //navStatus: tokens[1] as Integer,
                rateOfTurn: 1.0 as Float,
                speedOverGround: 1.2 as Float,
                posAccuracy: 1.2 as Double,
                courseOverGround: 1.2 as Double,
                trueHeading: 1.2 as Double,
                IMO: 1 as Integer,
                callsign: "Maverick",
                vesselName: "Costa",
                //vesselType: tokens[11] as Integer,            //XXX Need to replace this with type logic
                length: 2.0 as Double,
                width: 2.0 as Double,
                eta: ( new Date() + 30 ),
                dateCreated: new Date() - 1.hour,
                lastUpdated: new Date() - 1.hour)
            mockDomain(Ais, [ais1,ais2])
        }

    }

    void testGetNewAis() {
        use(TimeCategory){
            def payload = service.getNewAis(1.minute);
            assert payload.size() == 1
            payload = service.getNewAis(2.hours);
            assert payload.size() == 2
        }
    }

    void testGenerateMetaCardData() {
        use(TimeCategory){
            def payload = service.getNewAis(1.minute);
            assert payload.size() == 1

            def metacards = service.generateMetaCardData(payload)
            assert metacards.size() == 1
        }
    }

    void testPostMetaCardsToDDF() {
        use(TimeCategory){
            def payload = service.getNewAis(1.minute);
            assert payload.size() == 1

            def metacards = service.generateMetaCardData(payload)
            assert metacards.size() == 1

            service.metaClass.simplePost{ url, data ->
                return new ResponseEntity<String>("Thank you sending some info", HttpStatus.OK)
            }
            def responseAndError = service.postMetaCardsToDDF(metacards, grailsApplication.config.ddf.url)

            assert responseAndError.first() == "Thank you sending some info"
            assert responseAndError.last() == null
        }
    }
}
