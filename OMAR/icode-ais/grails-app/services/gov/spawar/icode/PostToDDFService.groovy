package gov.spawar.icode

import groovy.time.TimeCategory
import org.springframework.http.HttpStatus

class PostToDDFService {

    def getNewAis(newerThan) {
        def date = new Date()
        use(TimeCategory){
            date = (new Date()) - newerThan
        }
        def aises = Ais.findAllByLastUpdatedGreaterThan(date)

        return aises
    }

    def generateMetaCardData(List<Ais> aises) {
        //TODO: get correct metacard format
        def metacards = []
        aises.each{ ais ->
            def metacard = [:]
            metacard.put("CONTENT_TYPE", "some-content-type")
            metacard.put("CREATED", ais.dateCreated)
            metacard.put("EFFECTIVE", ais.lastUpdated)
            metacard.put("EXPIRATION", "expiry date")
            metacard.put("GEOGRAPHY", ais.locations?.last())
            metacard.put("ID", "some-id")
            metacard.put("MODIFIED", ais.lastUpdated)
            metacard.put("RESOURCE_SIZE", "some-size")
            metacard.put("RESOURCE_URI", "some-resource-uri")
            metacard.put("TARGET_NAMESPACE", "some-target-namespace")
            metacard.put("THUMBNAIL", "some-image")
            metacard.put("TITLE", ais.vesselName)
            metacards << metacard
        }
        return metacards
    }

    def simplePost(url, data){
        return new grails.plugins.rest.client.RestBuilder().post(url){
            contentType "application/json"
            json data
        }
    }

    def postMetaCardsToDDF(metacards, url) {
        def error = null
        def message


        def response = simplePost(url, metacards)

        if(response.getStatusCode() != HttpStatus.OK)
        {
            error =  response.getStatusText()
            message = error
        }
        else{
            message = response.getBody()
        }
        return [message, error]
    }
}