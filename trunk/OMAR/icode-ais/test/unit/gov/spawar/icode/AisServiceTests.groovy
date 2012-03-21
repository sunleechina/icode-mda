package gov.spawar.icode

import grails.test.*

class AisServiceTests extends GrailsUnitTestCase {
    
    def aisService
    
    protected void setUp() {
        super.setUp()
        
        aisService = new AisService()
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

    
    
}
