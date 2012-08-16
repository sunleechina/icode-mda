package gov.spawar.icode

/*
*
* Sample data to decode:

   //SR//AD/BEL//FR/SEY//TM/POS//NA/PENSE A MOI//IR/SZ 442//RC/SZ 442//DA/090311//TI/1052//LA/S0437//LO/E05527//SP/0//CO/356//FS/SEY//ER

   //SR//AD/SEY//FR/SYC//TM/POS//NA/FAITH SZ 1146//DA/111108//TI/2144//LA/S0428//LO/E05501//SP/2//CO/351//FS/SEY//ER


   SR:  Command line to start the report
   AD:  Destination party country code         - e.g BEL        = Belgium
   FR:  Transmitting Country code              - e.g SEY        = Seychelles
   TM:  Message type                           - e.g POS        = Position
   NA:  Vessel name                            - e.g PENSE A MOI
   IR:  Registration                           - e.g SZ 442
   RC:  Radio Call sign                        - e.g SZ 442
   DA:  Date of VMS data                       - e.g 090311     = 11th March 2009
   TI:  Time message was sent                  - e.g 1052       = 14:52 hrs Lt
   LA:  Latitude                               - e.g S0437      = 04º 37' South
   LO:  Longitude                              - e.g E05527     = 055º 27' East
   SP:  Speed                                  - e.g 0          = Vessel not moving
   CO:  Course                                 - e.g 356
   FS:  Flag State                             - e.g SEY        = Seychelles

*
*/

class Vms {

    static hasMany = [locations: Location]

    String destination;		//AD:  Destination party country code         - e.g BEL        = Belgium
    String country;	        //XXX How do we link this to country table?		//FR:  Transmitting Country code              - e.g SEY        = Seychelles
    String messageType;		//TM:  Message type                           - e.g POS        = Position
    String vesselName;		//NA:  Vessel name                            - e.g PENSE A MOI
    String registration;	//IR:  Registration                           - e.g SZ 442
    String callSign;		//RC:  Radio Call sign                        - e.g SZ 442
    Date date;			    //DA:  Date of VMS data                       - e.g 090311     = 11th March 2009
    //Integer time;			//TI:  Time message was sent                  - e.g 1452       = 14:52 hrs Lt
    Double lat;				//LA:  Latitude                               - e.g S0437      = 04º 37' South
    Double lon;				//LO:  Longitude                              - e.g E05527     = 055º 27' East
    Double speed;			//SP:  Speed                                  - e.g 0          = Vessel not moving
    Integer course;			//CO:  Course                                 - e.g 356
    String flag;			//FS:  Flag State                             - e.g SEY        = Seychelles


    static constraints = {
        vesselName()
        callSign()
        country()
        messageType()
        date()

    }
}
