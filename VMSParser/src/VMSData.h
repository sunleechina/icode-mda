/*
Sample data to decode:

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
ER:  End of record

*/

#ifndef VMSDATA_H
#define VMSDATA_H
#include <string>

using namespace std;

class VMSData {

public:

	VMSData()
	{
		DESTINATION = "";
		COUNTRY = "";
		MESSAGETYPE = "";
		VESSELNAME = "";
		REGISTRATION = "";
		CALLSIGN = "";
		DATE = -1;
		TIME = -1;
		LAT = -1.0;
		LON = -1.0;
		SPEED = -1.0;
		COURSE = -1;
		FLAG = "";	
	}
	
	bool operator != (const VMSData& lhs) const
	{
		return !(operator==(lhs));
	}

	bool operator == (const VMSData& lhs) const
	{
		if(
			equalWithExceptionOfTime(lhs) &&
			this->DATE == lhs.getDATE() &&
			this->TIME == lhs.getTIME()
			)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	bool equalWithExceptionOfTime (const VMSData& lhs) const
	{
		if(
			this->DESTINATION == lhs.getDESTINATION() &&
			this->COUNTRY == lhs.getCOUNTRY() &&
			this->MESSAGETYPE == lhs.getMESSAGETYPE() &&
			this->VESSELNAME == lhs.getVESSELNAME() &&
			this->REGISTRATION == lhs.getREGISTRATION() &&
			this->CALLSIGN == lhs.getCALLSIGN() &&
			this->LAT == lhs.getLAT() &&
			this->LON == lhs.getLON() &&
			this->SPEED == lhs.getSPEED() &&
			this->COURSE == lhs.getCOURSE() &&
			this->FLAG == lhs.getFLAG()
			)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	string getDESTINATION() const
	{
		return DESTINATION;
	}
	void setDESTINATION(string destination)
	{
		this->DESTINATION = destination;
	}
	string getCOUNTRY() const
	{
		return COUNTRY;
	}
	void setCOUNTRY(string country)
	{
		this->COUNTRY = country;
	}
	string getMESSAGETYPE() const
	{
		return MESSAGETYPE;
	}
	void setMESSAGETYPE(string messagetype)
	{
		this->MESSAGETYPE = messagetype;
	}
	string getVESSELNAME() const
	{
		return VESSELNAME;
	}
	void setVESSELNAME(string vesselname)
	{
		this->VESSELNAME = vesselname;
	}
	string getREGISTRATION() const
	{
		return REGISTRATION;
	}
	void setREGISTRATION(string registration)
	{
		this->REGISTRATION = registration;
	}
	string getCALLSIGN() const
	{
		return CALLSIGN;
	}
	void setCALLSIGN(string callsign)
	{
		this->CALLSIGN = callsign;
	}
	int getDATE() const
	{
		return DATE;
	}
	void setDATE(int date)
	{
		this->DATE = date;
	}
	int getTIME() const
	{
		return TIME;
	}
	void setTIME(int time)
	{
		this->TIME = time;
	}
	double getLAT() const
	{
		return LAT;
	}
	void setLAT(double lat)
	{
		this->LAT = lat;
	}
	double getLON() const
	{
		return LON;
	}
	void setLON(double lon)
	{
		this->LON = lon;
	}
	double getSPEED() const
	{
		return SPEED;
	}
	void setSPEED(double speed)
	{
		this->SPEED = speed;
	}
	int getCOURSE() const
	{
		return COURSE;
	}
	void setCOURSE(int course)
	{
		this->COURSE = course;
	}
	string getFLAG() const
	{
		return FLAG;
	}
	void setFLAG(string flag)
	{
		this->FLAG = flag;
	}


private:

	string DESTINATION;		//AD:  Destination party country code         - e.g BEL        = Belgium
	string COUNTRY;			//FR:  Transmitting Country code              - e.g SEY        = Seychelles
	string MESSAGETYPE;		//TM:  Message type                           - e.g POS        = Position
	string VESSELNAME;		//NA:  Vessel name                            - e.g PENSE A MOI
	string REGISTRATION;	//IR:  Registration                           - e.g SZ 442
	string CALLSIGN;		//RC:  Radio Call sign                        - e.g SZ 442
	int DATE;				//DA:  Date of VMS data                       - e.g 090311     = 11th March 2009
	int TIME;				//TI:  Time message was sent                  - e.g 1052       = 14:52 hrs Lt
	double LAT;				//LA:  Latitude                               - e.g S0437      = 04º 37' South
	double LON;				//LO:  Longitude                              - e.g E05527     = 055º 27' East
	double SPEED;			//SP:  Speed                                  - e.g 0          = Vessel not moving
	int COURSE;				//CO:  Course                                 - e.g 356
	string FLAG;			//FS:  Flag State                             - e.g SEY        = Seychelles
};

#endif
