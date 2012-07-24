/**
 * VMSParser
 *
 * Author:	Bryan Bagnall, Sparta Cheung
 * Date:	07/11/2012
 * Description:
 *			Parser for files containing VMS vessel tracking messages.  A typical VMS message looks like:
 *
 *	//SR//AD/SEY//FR/SYC//TM/POS//NA/FAITH SZ 1146//DA/111108//TI/2144//LA/S0428//LO/E05501//SP/2//CO/351//FS/SEY//ER
 *
 **/

#include <iostream>
#include <stdexcept>
#include <string>

#include <boost/timer/timer.hpp>
#include <boost/lexical_cast.hpp>
#include <boost/algorithm/string.hpp>

//Input sources
#include <FlatFileInputSource.h>

//Output sources
#include <TSVWriter.h>			//Outputs tab delimited files
#include <KMLPlacemarkWriter.h>
#include <CSVWriter.h>

//Parsers
#include <VMSSentenceParser.h>	//Parses VSM sentences

#include <VMSData.h>			//VMS message data class
#include <Debug.h>			//for output debug messages

using namespace std;

void usage()
{
	cerr << "\n  Usage: VMSParser.exe <input-filename> <number-of-entries-per-tsv>\n\n";
	cerr << "Will create a file named <input-filename>.p<partition-number>.tsv with the parsed VMS.\n";
	cerr << "<number-of-entries-per-tsv> is the number of entries per file.\nIt will create mutliple files named <input-filename><file-number>.tsv.\nIf set to 0, it will push all to a single file." << endl;
}

//========================================================================================
//========================================================================================
//========================================================================================
//========================================================================================

int main(int argc, char** argv)
{

	//parse args
	if(argc!=3)
	{
		usage();
		return -1;
	}

	boost::timer::auto_cpu_timer timer;

	string filename = argv[1];
	unsigned int messagesPerFile = 0;
	try
	{
		messagesPerFile = boost::lexical_cast<unsigned int>(argv[2]);
	}
	catch(exception& e)
	{
		cerr << e.what() << endl;
		cerr << "Setting messages per file to 0" << endl;
		messagesPerFile = 0;
	}
	
	//Define input class (an AisInputSource)
	//STEPX: choose the correct type of input source
	FlatFileInputSource InputSource(filename);
	
	unsigned int partition = 0;

	while(InputSource.isReady())
	{
		//Define output class (a Writer)
		//STEPX: choose the correct type of output source
		TSVWriter vmsTSVWriter(filename + ".p" + boost::lexical_cast<string>(partition));
		KMLPlacemarkWriter vmsKMLWriter(filename + ".p" + boost::lexical_cast<string>(partition));
		CSVWriter vmsCSVWriter(filename + ".p" + boost::lexical_cast<string>(partition));
		partition++;

		if(!vmsTSVWriter.isReady())
		{
			debug("vmsTSVWriter is not ready");
			return -1;
		}

		if(!vmsKMLWriter.isReady())
		{
			debug("vmsKMLWriter is not ready");
			return -1;
		}

		if(!vmsCSVWriter.isReady())
		{
			debug("vmsCSVWriter is not ready");
			return -1;
		}

		for(unsigned int messageCount = 0; ((messagesPerFile == 0) || (messageCount < messagesPerFile)) && (InputSource.isReady()); messageCount++)
		{
			//load the next sentence from the AIS input to the parser
			//STEPX: choose the correct type of sentence parser
			string nextSen = InputSource.getNextSentence();
			if (nextSen == "-1")	//check for reading EOF
				break;				//break loop if encounter EOF

			VMSSentenceParser sentenceParser(nextSen);

			if(sentenceParser.isMessageValid())
			{
				try
				{
					//parse message here
					VMSData data;
					data = sentenceParser.parseSentence();

					//print the data to screen
					sentenceParser.printData();

					//output the data to Writer
					vmsTSVWriter.writeEntry(data);
					vmsKMLWriter.writeEntry(data);
					vmsCSVWriter.writeEntry(data);
				}
				catch (exception &e)
				{
					cerr << e.what() << endl;
				}
			}
			else
			{
				//debug("Invalid message:\n" + aisSentenceParser.getCurrentSentence());
			}
		}
	}

	debug("End of VMS sentence parser");

	return 0;
}

