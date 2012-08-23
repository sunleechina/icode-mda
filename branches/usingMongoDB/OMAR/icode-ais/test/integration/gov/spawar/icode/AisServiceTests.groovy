package gov.spawar.icode

import grails.test.*

class AisServiceTests extends GroovyTestCase {
    
    def aisService
    
    protected void setUp() {
        super.setUp()
        
        aisService = new AisService()

        //Load Sample data for testing
        // AisData.load();
    }

    protected void tearDown() {
        super.tearDown()
    }

    


    void testValidCountryCodeInt(){
        mockDomain(Country)
        mockDomain(CallSignPrefix)
        mockDomain(MaritimeIdDigit)



        aisService = new AisService();

        //Save a couple Countries for testing
        Country country1 = new Country()
        country1.countryCode = "SP"
        country1.name = "Spain"
        CallSignPrefix prefix1 = new CallSignPrefix();


        prefix1.with{
            prefix1.prefix = "EA"
        }

        country1.addToCallSignPrefixes(prefix1)
        MaritimeIdDigit mid1 = new MaritimeIdDigit();
        mid1.mid = "224"
        country1.addToMaritimeIdDigits(mid1)
        country1.save()

        //Save a couple Countries for testing
        Country country2 = new Country()
        country2.countryCode = "PM"
        country2.name = "Panama"
        CallSignPrefix prefix2 = new CallSignPrefix();
        prefix2.prefix = "H9"
        country2.addToCallSignPrefixes(prefix1)
        MaritimeIdDigit mid2 = new MaritimeIdDigit();
        mid2.mid = "351"
        country2.addToMaritimeIdDigits(mid2)
        country2.save()


        Boolean valid=true;


        valid = aisService.isValidCountryCode(224549000, "EAJW");
	assertEquals true, valid;

        valid = aisService.isValidCountryCode(354943000, "H9XN");
        assertEquals true, valid;

        valid = aisService.isValidCountryCode(354943000, "CNA3723");
        assertEquals false, valid;


    }//testValidCountryCode

}
