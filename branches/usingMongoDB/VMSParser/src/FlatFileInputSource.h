#ifndef FlatFileInputSource_h
#define FlatFileInputSource_h

#include <fstream>
#include <string>

#include <InputSource.h>

using namespace std;

/**
This class handles grabbing external AIS/VMS data
The class can grab data from a flatfile containing messages such as log or gnm
*/
class FlatFileInputSource: public InputSource
{
public:
	FlatFileInputSource(std::string filename)
	{
		m_inputFile.open(filename, std::ios::in);
	}
	
	~FlatFileInputSource()
	{
		if(m_inputFile.is_open())
		{
			m_inputFile.close();
		}
	}

	/**
	Returns true if the input source is ready to start providing data, false otherwise
	*/
	bool isReady()
	{
		if (m_inputFile.eof())
			return false;
		return m_inputFile.good();
	}
	
	/**
	Returns the next sentence from the AIS input source as a string.
	*/
	string getNextSentence()
	{
		getline(m_inputFile, m_sentence);
		if (m_inputFile.eof())
			return "-1";		//encountered end-of-file, return as such
		return m_sentence;
	}


private:
	string m_sentence;
	ifstream m_inputFile;
};
#endif
