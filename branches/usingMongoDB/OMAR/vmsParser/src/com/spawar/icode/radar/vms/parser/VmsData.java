package com.spawar.icode.radar.vms.parser;

import java.util.Date;


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
public class VmsData {
	String DESTINATION;		//AD:  Destination party country code         - e.g BEL        = Belgium
	String COUNTRY;			//FR:  Transmitting Country code              - e.g SEY        = Seychelles
	String MESSAGETYPE;		//TM:  Message type                           - e.g POS        = Position
	String VESSELNAME;		//NA:  Vessel name                            - e.g PENSE A MOI
	String REGISTRATION;	//IR:  Registration                           - e.g SZ 442
	String CALLSIGN;		//RC:  Radio Call sign                        - e.g SZ 442
	Date DATE;			    //DA:  Date of VMS data                       - e.g 090311     = 11th March 2009
	Integer TIME;			//TI:  Time message was sent                  - e.g 1452       = 14:52 hrs Lt
	Double LAT;				//LA:  Latitude                               - e.g S0437      = 04º 37' South
	Double LON;				//LO:  Longitude                              - e.g E05527     = 055º 27' East
	Double SPEED;			//SP:  Speed                                  - e.g 0          = Vessel not moving
	Integer COURSE;			//CO:  Course                                 - e.g 356
	String FLAG;			//FS:  Flag State                             - e.g SEY        = Seychelles
	
	/**
	 * ructor
	 */
	public VmsData()
	{
		DESTINATION = "";
		COUNTRY = "";
		MESSAGETYPE = "";
		VESSELNAME = "";
		REGISTRATION = "";
		CALLSIGN = "";
		DATE = null;
		TIME = -1;
		LAT = -1.0;
		LON = -1.0;
		SPEED = -1.0;
		COURSE = -1;
		FLAG = "";	
	}//Constructor
	
	public boolean equalWithExceptionOfTime (final VmsData lhs) 
	{
		
		if(
			DESTINATION == lhs.getDESTINATION() &&
			COUNTRY == lhs.getCOUNTRY() &&
			MESSAGETYPE == lhs.getMESSAGETYPE() &&
			VESSELNAME == lhs.getVESSELNAME() &&
			REGISTRATION == lhs.getREGISTRATION() &&
			CALLSIGN == lhs.getCALLSIGN() &&
			LAT == lhs.getLAT() &&
			LON == lhs.getLON() &&
			SPEED == lhs.getSPEED() &&
			COURSE == lhs.getCOURSE() &&
			FLAG == lhs.getFLAG()
			)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	public String getDESTINATION() 
	{
		return DESTINATION;
	}
	public void setDESTINATION(String destination)
	{
		DESTINATION = destination;
	}
	public String getCOUNTRY()
	{
		return COUNTRY;
	}
	public void setCOUNTRY(String country)
	{
		COUNTRY = country;
	}
	public String getMESSAGETYPE()
	{
		return MESSAGETYPE;
	}
	public void setMESSAGETYPE(String messagetype)
	{
		MESSAGETYPE = messagetype;
	}
	public String getVESSELNAME()
	{
		return VESSELNAME;
	}
	public void setVESSELNAME(String vesselname)
	{
		VESSELNAME = vesselname;
	}
	public String getREGISTRATION()
	{
		return REGISTRATION;
	}
	public void setREGISTRATION(String registration)
	{
		REGISTRATION = registration;
	}
	public String getCALLSIGN()
	{
		return CALLSIGN;
	}
	public void setCALLSIGN(String callsign)
	{
		CALLSIGN = callsign;
	}
	public Date getDATE() 
	{
		return DATE;
	}
	public void setDATE(Date date)
	{
		DATE = date;
	}
	public int getTIME() 
	{
		return TIME;
	}
	public void setTIME(int time)
	{
		TIME = time;
	}
	public double getLAT() 
	{
		return LAT;
	}
	public void setLAT(double lat)
	{
		LAT = lat;
	}
	public double getLON() 
	{
		return LON;
	}
	public void setLON(double lon)
	{
		LON = lon;
	}
	public double getSPEED() 
	{
		return SPEED;
	}
	public void setSPEED(double speed)
	{
		SPEED = speed;
	}
	public int getCOURSE() 
	{
		return COURSE;
	}
	public void setCOURSE(int course)
	{
		COURSE = course;
	}
	public String getFLAG() 
	{
		return FLAG;
	}
	public void setFLAG(String flag)
	{
		FLAG = flag;
	}

}//class
