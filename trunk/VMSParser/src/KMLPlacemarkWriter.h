#ifndef KmlPlacemarkWriter_h
#define KmlPlacemarkWriter_h

#include <string>
#include <sstream>
#include <fstream>
#include <iomanip>

#include <Writer.h>
#include <VMSData.h>


//<?xml version="1.0" encoding="UTF-8"?>
//<kml xmlns="http://www.opengis.net/kml/2.2">
//  <Document>
//    <Placemark>
//      <name>CDATA example</name>
//      <description>
//        <![CDATA[
//          <h1>CDATA Tags are useful!</h1>
//          <p><font color="red">Text is <i>more readable</i> and 
//          <b>easier to write</b> when you can avoid using entity 
//          references.</font></p>
//        ]]>
//      </description>
//      <Point>
//        <coordinates>102.595626,14.996729</coordinates>
//      </Point>
//    </Placemark>
//  </Document>
//</kml>

class KMLPlacemarkWriter : public Writer{
public:
	KMLPlacemarkWriter(std::string filename){
		of.open(filename + ".kml", std::ios::out);
		writeHeader();
	}

	KMLPlacemarkWriter(int year, int month, int day, int partition){
		stringstream filename;
		filename << setfill('0');
		filename << year;
		filename << setw(2) << month;
		filename << setw(2) << day;
		filename << ".p" << partition << ".kml";
		of.open(filename.str(), std::ios::out);
		writeHeader();
	}

	~KMLPlacemarkWriter(){
		if(of.is_open()){
			of << "</Document>" << endl;
			of << "</kml>" << endl;
			of.close();
		}
	}

	void writeHeader()
	{
		if(of.is_open())
		{
			of << "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" << endl;
			of << "<kml xmlns=\"http://www.opengis.net/kml/2.2\">" << endl;
			of << "<Document>" << endl;
		}
	}

	bool writeEntry(const VMSData& data){

		of.precision(10);
		of << "	<Placemark>" << endl;
		of << "		<name>" << data.getVESSELNAME() << "</name>" << endl;
		of << "		<description>" << endl;
        of << "		<![CDATA[" << endl;
        of << "			Destination:" << data.getDESTINATION() << "<br>" << endl;
		of << "			Country:" << data.getCOUNTRY() << "<br>" << endl;
		of << "			Message Type:" << data.getMESSAGETYPE() << "<br>" << endl;
		of << "			Vessel name:" << data.getVESSELNAME() << "<br>" << endl;
		of << "			Registration:" << data.getREGISTRATION() << "<br>" << endl;
		of << "			Callsign:" << data.getCALLSIGN() << "<br>" << endl;
		of << "			Date:" << data.getDATE() << "<br>" << endl;
		of << "			Time:" << data.getTIME() << "<br>" << endl;
		of << "			Latitude:" << data.getLAT() << "<br>" << endl;
		of << "			Longitude:" << data.getLON() << "<br>" << endl;
		of << "			Speed:" << data.getSPEED() << "<br>" << endl;
		of << "			Course:" << data.getCOURSE() << "<br>" << endl;
		of << "			Flag State:" << data.getFLAG() << "<br>" << endl;
		of << "		]]>" << endl;
		of << "		</description>" << endl;
		of << "		<Point>" << endl;
		of << "		<coordinates>" << data.getLON() << "," << data.getLAT() << "</coordinates>" << endl;
		of << "		</Point>" << endl;
		of << "	</Placemark>" << endl;
		return true;
	}

	bool isReady(){
		return of.is_open();
	}

private:
	std::ofstream of;
};
#endif
