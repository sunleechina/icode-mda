#ifndef AisMsisSentenceParser_h
#define AisMsisSentenceParser_h

#include <vector>
#include <string>
#include <sstream>
#include <algorithm>

#include <boost/lexical_cast.hpp>
#include <boost/algorithm/string.hpp>

#include <AisSentenceParser.h>

/**
This class parses AIS sentences into a vector
of strings that can be used in other classes.
The class has the ability to validate the
checksum of the AIS message
*/
class AisMsisSentenceParser : public AisSentenceParser{
public:
	/**
	@param sentence is the sentence to parse
	@param numFields is the number of fields in the sentence (e.g. sentence == a,b,c,d,e would mean that numFields == 5)
	*/
	AisMsisSentenceParser(std::string sentence):AisSentenceParser(sentence)
	{
	}

	bool isMessageValid(){
		if(m_parsedSentence.size() == 8 || m_parsedSentence.size() == 9 )
		{
			if(m_parsedSentence[0].size() == 6)
			{
				if(m_parsedSentence[0].substr(3,3).compare("VDM") == 0)
				{
					return isChecksumValid();
				}
				else
				{
					aisDebug("Message does not have !**VDM begining\n" + m_fullSentence);
					return false;
				}
			}
			else
			{
				aisDebug("Message does not have acceptable first entry\n" + m_fullSentence);
				return false;
			}
		}
		else
		{
			aisDebug("Message does not have 8 || 9 columns\n" + m_fullSentence);
			return false;
		}
	}

	bool isChecksumValid(){
		// Verify that the checksum matches the message
		std::vector<std::string> checksumParsedSentence;
		boost::split(checksumParsedSentence, m_fullSentence, boost::is_any_of("*"));
		if(checksumParsedSentence.size()>1 && m_parsedSentence[6].size() == 4)
		{
			//take the message, excluding the initial '!', to the end but not including the '*'
			string message = checksumParsedSentence[0].substr(1);
			int CS = 0x00;
			for (unsigned int i=0; i < message.length(); i++)
			{
				CS = CS ^ message[i];
			}
			
			std::string strCS;
			std::stringstream stringStream;
			stringStream.width(2);
			stringStream.fill('0');
			stringStream << std::hex << CS;
			stringStream >> strCS;
			boost::to_upper(strCS);

			if(m_parsedSentence[6].substr(2) == strCS)
			{
				//aisDebug("Checksum is correct");
				return true;
			}
			else
			{
				aisDebug("Checksum does not match!\nChecksum" + m_parsedSentence[6].substr(2) + " != " + strCS);
				return false;
			}
		}
		else
		{
			aisDebug("Checksum * not found in message");
			return false;
		}
	}

	/**	
	Call isMessageValid() before using this function
	*/
	int getTimestamp(){
		int timestamp=0;
		try{
			boost::algorithm::trim(m_parsedSentence[7]);
			timestamp = boost::lexical_cast<int>(m_parsedSentence[7]);
		}catch(boost::bad_lexical_cast &e){
			aisDebug("Timestamp cannot be converted to a number:" << e.what());
		}
		return timestamp;
	}

	/**	
	Call isMessageValid() before using this function
	*/
	std::string getStreamId(){
		return "MSSIS";
	}

	/**
	Call isChecksumValid() before using this function
	*/
	int getNumberOfSentences(){
		return boost::lexical_cast<int>(m_parsedSentence[1]);
	}

	/**
	Call isChecksumValid() before using this function
	*/
	int getSentenceNumber(){
		return boost::lexical_cast<int>(m_parsedSentence[2]);
	}

	/**
	Returns the current sentence
	*/
	std::string getCurrentSentence()
	{
		return m_fullSentence;
	}

	/**
	Call isChecksumValid() before using this function
	*/
	std::string getData(){
		return m_parsedSentence[5];
	}

private:

};

#endif