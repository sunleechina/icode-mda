#ifndef CSVWriter_h
#define CSVWriter_h

#include <string>
#include <fstream>
#include <iomanip>

#include <Writer.h>
#include <VMSData.h>

class CSVWriter : public Writer{
public:
	CSVWriter(std::string filename){
		of.open(filename + ".csv", std::ios::out);
	}

	~CSVWriter(){
		if(of.is_open()){
			of.close();
		}
	}

	bool writeEntry(const VMSData& data){
		of << setprecision(10) << 
			data.getDESTINATION() << "," <<
			data.getCOUNTRY() << "," <<
			data.getMESSAGETYPE() << "," <<
			data.getVESSELNAME() << "," <<
			data.getREGISTRATION() << "," <<
			data.getCALLSIGN() << "," <<
			data.getDATE() << "," <<
			data.getTIME() << "," <<
			data.getLAT() << "," <<
			data.getLON() << "," <<
			data.getSPEED() << "," <<
			data.getCOURSE() << "," <<
			data.getFLAG() << "," << endl;
		return true;
	}

	bool isReady(){
		return of.is_open();
	}

private:
	std::ofstream of;
};
#endif
