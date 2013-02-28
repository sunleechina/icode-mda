package gov.spawar.icode

import groovy.time.TimeCategory

class PostToDDFJob {
    def PostToDDFService postToDDFService;
    static grailsApplication

    static triggers = {
      simple repeatInterval:  5000l
    }

    def execute() {
        if (grailsApplication.config.ddf.ais.post.on.asBoolean()){
            use(TimeCategory){
                def payload = postToDDFService.getNewAis(1.minute);
                def metacards = postToDDFService.generateMetaCardData(payload)
                if (!metacards.empty){
                    log.debug("Posting "+ metacards.size()+ " metacard(s) to: " + grailsApplication.config.ddf.ais.post.url)
                    def responseAndError = postToDDFService.postMetaCardsToDDF(metacards, grailsApplication.config.ddf.ais.post.url)
                    if (responseAndError.last() != null){
                        log.error(responseAndError.last().toString())
                    }else{
                        log.debug(responseAndError.first().toString())
                    }
                } else {
                    log.debug("No metacards found skipping post to: " + grailsApplication.config.ddf.ais.post.url)
                }
            }
        }
    }
}
