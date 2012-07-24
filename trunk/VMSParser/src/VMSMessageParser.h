/*
Sample data to decode:

//SR//AD/BEL//FR/SEY//TM/POS//NA/PENSE A MOI//IR/SZ 442//RC/SZ 442//DA/090311//TI/1052//LA/S0437//LO/E05527//SP/0//CO/356//FS/SEY//ER

//SR//AD/SEY//FR/SYC//TM/POS//NA/FAITH SZ 1146//DA/111108//TI/2144//LA/S0428//LO/E05501//SP/2//CO/351//FS/SEY//ER


SR:  Command line to start the report 
AD:  Destination party country code         - e.g BEL        = Belgium
FR:  Transmitting Country code				  - e.g SEY        = Seychelles
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

#ifndef VMSMessageParser_h
#define VMSMessageParser_h

#include <string>
#include <vector>

#include <boost/algorithm/string.hpp>

#include <VMSData.h>
#include <Debug.h>

/**
Class that parses single VMS sentences into an VMSMessage object
*/
class VMSMessageParser
{
public:

	VMSMessageParser()
	{
		m_data.clear();
	}

	void addData(std::string data)
	{
		m_data.append(data);
	}

	VMSMessage parseMessage()
	{
		// Convert AIS Message from 6-bit Hex to Binary
		vector<bool> aisBin;
		VMSMessage VMSMessage;

		DecodeVMSMessage(aisBin, VMSMessage);

		return VMSMessage;
	}


private:

	int DecodeVMSMessage(vector<bool> & VMSBool, VMSMessage &VMSPosit)
	{
		debug("IN DECODEVMSMESSAGE FUNCTION\n");

		return 0;
	}

   std::string m_data;
};

#endif
