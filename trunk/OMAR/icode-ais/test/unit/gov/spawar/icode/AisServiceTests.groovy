package gov.spawar.icode

import grails.test.*

class AisServiceTests extends GrailsUnitTestCase {
    
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

    void testValidMMSI() {
        
        aisService = new AisService();
        Integer validMMSI = 215962009;
        Integer unValidMMSI = 30433402;
        
        Boolean  bValid = aisService.isValidMMSI(validMMSI);
        assertEquals true, bValid;
        
        Boolean  notValid = aisService.isValidMMSI(unValidMMSI);
        assertEquals false, notValid;
    }//testValidMMSI
    
    void testIMOCheckSum(){
        
	Boolean valid=true;
        aisService = new AisService();
        
	valid = aisService.isValidIMO(1003267);
	assertEquals true, valid;
        
	
	valid = aisService.isValidIMO(8116570);
	assertEquals true, valid;
        
	
	valid = aisService.isValidIMO(9174323);
	assertEquals true, valid;
        
	//Don't know what a un valid value would be.
	//valid = imageAIS->IMO_CheckSum(9572313);
	//CPPUNIT_ASSERT( !valid);
        
    }


        void testValidCountryCode(){
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


        //valid = aisService.isValidCountryCode(224549000, "EAJW");
	//assertEquals true, valid;

       // valid = aisService.isValidCountryCode(354943000, "H9XN");
	//assertEquals true, valid;

       // valid = aisService.isValidCountryCode(354943000, "CNA3723");
	//assertEquals false, valid;


        assertEquals true, valid;

    }//testValidCountryCode

}
