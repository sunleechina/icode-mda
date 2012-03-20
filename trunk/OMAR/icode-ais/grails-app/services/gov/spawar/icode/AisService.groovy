package gov.spawar.icode

class AisService {

    static transactional = true

    /**
    * Chek for Valid MMSI
    **/
    def static boolean isValidMMSI(def mmsi) {
        
        int MID = (int)mmsi/1000000;
        
	//store a 1 if MMSI is invalid
	if(mmsi.toString().length() != 9 || MID <201 || MID > 775){
            return false; 
	}
	else{
            return true; 
	}
        
    }//isValidMMSI
    
    
    
}//AisService
