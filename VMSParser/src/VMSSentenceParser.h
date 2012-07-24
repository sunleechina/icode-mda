#ifndef VMSMsisSentenceParser_h
#define VMSMsisSentenceParser_h

#include <vector>
#include <string>
#include <sstream>
#include <algorithm>

#include <boost/lexical_cast.hpp>
#include <boost/algorithm/string.hpp>
#include <boost/algorithm/string/iter_find.hpp>

#include <Debug.h>

#define MAX_SEN_LEN 1024
//#define ASCII_CR 13
//#define ASCII_COMMA 44
//#define ASCII_FORWARD_SLASH 47

/**
This class parses AIS sentences into a vector
of strings that can be used in other classes.
The class has the ability to validate the
checksum of the AIS message
*/
class VMSSentenceParser{
public:
	/**
	@param sentence is the sentence to parse
	@param numFields is the number of fields in the sentence (e.g. sentence == a,b,c,d,e would mean that numFields == 5)
	*/
	VMSSentenceParser(std::string sentence)
	{
		//Define delimiters here.  Can define multiple by pushing back multiple ASCII values
		//m_seperators.push_back("\n");				//carriage return delimiter
		//m_seperators.push_back("/");	//forward slash delimiter
		//m_seperators.push_back("//");	//forward slash delimiter

		m_fullSentence = sentence;
		//boost::split(m_parsedSentence, sentence, boost::is_any_of(m_seperators));
		boost::iter_split(m_parsedSentence, sentence, boost::first_finder("//"));
		m_numberOfSentences = 0;
		m_currentSentenceNumber = 0;
	}

	bool isMessageValid()
	{
		if(m_fullSentence.size() > MAX_SEN_LEN)
		{
			debug("Invalid Message. Message longer than " << MAX_SEN_LEN << " characters.");
			return false;
		}

		//debug("VMS Sentence Parser: SENTENCE SIZE: " << m_parsedSentence.size());
		//debug("Message read: " << m_fullSentence << endl);

		m_numberOfSentences = 1;		//set number of sentences to 1 for VMS messages (AIS has more than 1 sometimes)
		m_currentSentenceNumber = 1;

		//do checksums and other validation here, none known for now
		if (m_parsedSentence[1] != "SR")
		{
			debug("Invalid start of sentence (no SR)");
			return false;
		}
		if (m_parsedSentence[m_parsedSentence.size()-1] != "ER")
		{
			debug("Invalid end of sentence (no ER)");
			return false;
		}
		return true;
	}

	void setSentence(std::string sentence){
		m_fullSentence = sentence;
		//boost::split(m_parsedSentence, sentence, boost::is_any_of("\n/"));
		boost::iter_split(m_parsedSentence, sentence, boost::first_finder("//"));
	}

	/**	
	Call isMessageValid() before using this function
	*/
	int getDATE()
	{
		return data.getDATE();
	}

	/**	
	Call isMessageValid() before using this function
	*/
	int getTIME()
	{
		return data.getTIME();
	}

	/**
	Call isMessageValid() before using this function
	*/
	int getNumberOfSentences(){
		return m_numberOfSentences;
	}

	/**
	Call isMessageValid() before using this function
	*/
	int getSentenceNumber(){
		return m_currentSentenceNumber;
	}

	/**
	Returns the current sentence
	*/
	std::string getCurrentSentence()
	{
		return m_fullSentence;
	}

	VMSData parseSentence()
	{
		DecodeVMSSentence();

		return data;
	}

	void printData()
	{
		if (data.getDESTINATION() == "")
		{
			debug("Destination: (not set)");
		}
		else
		{
			debug("Destination: " << data.getDESTINATION());
		}
		if (data.getCOUNTRY() == "")
		{
			debug("Country code: (not set)");
		}
		else
		{
			debug("Country code: " << data.getCOUNTRY());
		}
		if (data.getMESSAGETYPE() == "")
		{
			debug("Message type: (not set)");
		}
		else
		{
			debug("Message type: " << data.getMESSAGETYPE());
		}
		if (data.getVESSELNAME() == "")
		{
			debug("Vessel name: (not set)");
		}
		else
		{
			debug("Vessel name: " << data.getVESSELNAME());
		}
		if (data.getREGISTRATION() == "")
		{
			debug("Registration: (not set)");
		}
		else
		{
			debug("Registration: " << data.getREGISTRATION());
		}
		if (data.getCALLSIGN() == "")
		{
			debug("Call sign: (not set)");
		}
		else
		{
			debug("Call sign: " << data.getCALLSIGN());
		}
		if (data.getDATE() == -1)
		{
			debug("Date: (not set)");
		}
		else
		{
			debug("Date: " << data.getDATE());
		}
		if (data.getTIME() == -1)
		{
			debug("Time: (not set)");
		}
		else
		{
			debug("Time: " << data.getTIME());
		}
		if (data.getLAT() == -1.0)
		{
			debug("Latitude: (not set)");
		}
		else
		{
			debug("Latitude: " << data.getLAT());
		}
		if (data.getLON() == -1.0)
		{
			debug("Longitude: (not set)");
		}
		else
		{
			debug("Longitude: " << data.getLON());
		}
		if (data.getSPEED() == -1.0)
		{
			debug("Speed: (not set)");
		}
		else
		{
			debug("Speed: " << data.getSPEED());
		}
		if (data.getCOURSE() == -1)
		{
			debug("Course: (not set)");
		}
		else
		{
			debug("Course: " << data.getCOURSE());
		}
		if (data.getFLAG() == "")
		{
			debug("Flag state: (not set)");
		}
		else
		{
			debug("Flag state: " << data.getFLAG());
		}
		debug(endl);
	}

private:
	std::string m_fullSentence;
	std::vector<std::string> m_parsedSentence;
	int m_numberOfSentences;
	int m_currentSentenceNumber;
	//vector<std::string> m_seperators;
	VMSData data;

	int DecodeVMSSentence()
	{
		for (unsigned int i=0; i < m_parsedSentence.size(); i++)
		{
			//debug(m_parsedSentence[i].substr(0,2));
			//debug(m_parsedSentence[i]);
			if (m_parsedSentence[i] == " ")
				continue;
			if (m_parsedSentence[i] == "SR")
				continue;
			if (m_parsedSentence[i] == "ER")
				continue;
			if (m_parsedSentence[i].substr(0,2) == "AD")	//Destination
			{
				data.setDESTINATION(m_parsedSentence[i].substr(3,(m_parsedSentence[i].size()-3)));
			}
			if (m_parsedSentence[i].substr(0,2) == "FR")	//Country code
			{
				data.setCOUNTRY(m_parsedSentence[i].substr(3,(m_parsedSentence[i].size()-3)));
			}
			if (m_parsedSentence[i].substr(0,2) == "TM")	//Message type
			{
				data.setMESSAGETYPE(m_parsedSentence[i].substr(3,(m_parsedSentence[i].size()-3)));
			}
			if (m_parsedSentence[i].substr(0,2) == "NA")	//Vessel name
			{
				data.setVESSELNAME(m_parsedSentence[i].substr(3,(m_parsedSentence[i].size()-3)));
			}
			if (m_parsedSentence[i].substr(0,2) == "IR")	//Registration
			{
				data.setREGISTRATION(m_parsedSentence[i].substr(3,(m_parsedSentence[i].size()-3)));
			}
			if (m_parsedSentence[i].substr(0,2) == "RC")	//Call sign
			{
				data.setCALLSIGN(m_parsedSentence[i].substr(3,(m_parsedSentence[i].size()-3)));
			}
			if (m_parsedSentence[i].substr(0,2) == "DA")	//Date
			{
				data.setDATE(boost::lexical_cast<int>(m_parsedSentence[i].substr(3,(m_parsedSentence[i].size()-3))));
			}
			if (m_parsedSentence[i].substr(0,2) == "TI")	//Time
			{
				data.setTIME(boost::lexical_cast<int>(m_parsedSentence[i].substr(3,(m_parsedSentence[i].size()-3))));
			}
			if (m_parsedSentence[i].substr(0,2) == "LA")	//Latitude
			{
				double lat, lat_deg, lat_min;
				lat_min = boost::lexical_cast<double>(m_parsedSentence[i].substr((m_parsedSentence[i].size()-2),2));
				lat_deg = boost::lexical_cast<double>(m_parsedSentence[i].substr(4,m_parsedSentence[i].size()-6));

				lat = lat_deg + lat_min/60;

				if (m_parsedSentence[i].substr(3,1) == "S")
					lat = -lat;

				data.setLAT(lat);
			}
			if (m_parsedSentence[i].substr(0,2) == "LO")	//Longitude
			{
				double lon, lon_deg, lon_min;
				lon_min = boost::lexical_cast<double>(m_parsedSentence[i].substr((m_parsedSentence[i].size()-2),2));
				lon_deg = boost::lexical_cast<double>(m_parsedSentence[i].substr(4,m_parsedSentence[i].size()-6));

				lon = lon_deg + lon_min/60;

				if (m_parsedSentence[i].substr(3,1) == "W")
					lon = -lon;

				data.setLON(lon);
			}
			if (m_parsedSentence[i].substr(0,2) == "SP")	//Speed
			{
				data.setSPEED((double)boost::lexical_cast<int>(m_parsedSentence[i].substr(3,(m_parsedSentence[i].size()-3))));
			}
			if (m_parsedSentence[i].substr(0,2) == "CO")	//Course
			{
				data.setCOURSE(boost::lexical_cast<int>(m_parsedSentence[i].substr(3,(m_parsedSentence[i].size()-3))));
			}
			if (m_parsedSentence[i].substr(0,2) == "FS")	//Flag state
			{
				data.setFLAG(m_parsedSentence[i].substr(3,(m_parsedSentence[i].size()-3)));
			}
		}

		return 0;
	}
};

#endif
