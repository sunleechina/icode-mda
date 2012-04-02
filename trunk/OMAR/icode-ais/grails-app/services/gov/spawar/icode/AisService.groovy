package gov.spawar.icode

class AisService {

    static transactional = true

    /*********************
    * Chek for Valid MMSI
    ***********************/
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
    
    /*********************
    * Chek for Valid IMO
    ***********************/
   def static boolean isValidIMO(def imo) {
        
      	if(imo < 1000000 || imo > 9999999){
            return false;
	}
	else if(!isValidIMOCheckSum(imo)){
            return false;
	}
	else{
            return true;
	}
        
    }//isValidIMO
    
    /*********************
     * Chek for Valid IMO Checksum
     ***********************/
    def static boolean isValidIMOCheckSum(def dImo) {
        
    	Integer imo = dImo;
	String IMOstr;
	Integer total;
	Integer IMOsub;
	String total_check;
	Boolean iValid=false;
        
        total = 0;
        iValid = 0;
	IMOstr = Integer.toString(imo);
        
	for(int i=0; i<6;i++){
            //Take charcter at i and convert it to an int
            IMOsub = Integer.parseInt(IMOstr.substring(i,i+1))
            total = total + IMOsub * (8 - (i+1)); //add to total
	}
        
	//Take total and convert to a string
	total_check = Integer.toString(total);
        
	//If value of position #7 of IMOstr is equal to the last position of  total check, its invalid
	String tmp1 = IMOstr.substring(6,7);
        Integer start = total_check.length()-1;
	String tmp2 = total_check.substring(start,start+1);
        
	Integer valueA = Integer.parseInt(IMOstr.substring(6,7));
        start = total_check.length()-1;
	Integer valueB = Integer.parseInt(total_check.substring(start,start+1));
	if(valueA == valueB){
            iValid = true;
	}
        
        return iValid; 
        
    }//isValidIMOCheckSum

    ///////////////////////////
    //Check Call Sign
    ///////////////////////////
    def static boolean isValidCallSign(String ircs)
    {

	//blank destination
        ircs.trim();
	if( ircs.isEmpty() || ircs.equals("0")==0)
	{
            return false;
	}
	else
            return true;
    }
    
    
    
    
}//AisService
