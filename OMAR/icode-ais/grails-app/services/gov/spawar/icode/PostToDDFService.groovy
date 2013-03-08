package gov.spawar.icode

import grails.converters.JSON
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

//
//    {
//        "properties": {
//            "title": "Kit Airport",
//            "metadata-content-type-version": "myVersion",
//            "metadata-content-type": "myType",
//            "metadata": "Kit Airport"
//        },
//        "type": "Feature",
//        "geometry": {
//            "type": "Point",
//            "coordinates": [
//                    -110.996915,
//                    32.442337
//            ]
//        }
//    }
    def generateMetaCardData(List<Ais> aises) {
        def metacards = []
        aises.each{ ais ->
            def metacard = [:]
            def properties = [:]
            def geometry = [:]

//            properties.put("created", ais.dateCreated)
//            properties.put("effective", ais.lastUpdated)
            properties.put("id", ais.mmsi)
//            properties.put("modified", ais.lastUpdated)
            properties.put("title", ais.vesselName)
            properties.put("metadata", "<xml>${ais.mmsi} ${ais.vesselName} ${ais.getCallsign()}</xml>")
            metacard.put("properties", properties)

            metacard.put("type", "Feature")

            geometry.put("type", "Point")
            if(ais.locations && !ais.locations.empty){
                def coordinates = []
                coordinates.add(ais.locations.last().geometryObject.coordinates.first().x)
                coordinates.add(ais.locations.last().geometryObject.coordinates.first().y)
                geometry.put("coordinates", coordinates)
                metacard.put("geometry", geometry)
            }
            metacards << metacard
        }
        return metacards
    }

    def simplePost(url, data){
        return new grails.plugins.rest.client.RestBuilder().post(url){
            contentType "application/json"
            json data as JSON
        }
    }

    def postMetaCardsToDDF(metacard, url) {
        def error = null
        def message

        
        def response = simplePost(url, metacard)

        if(response.getStatusCode() != HttpStatus.CREATED)
        {
            error =  response.getText()
            message = error
        }
        else{
            message = response.getBody()
        }
        return [message, error]
    }
}