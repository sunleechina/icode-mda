#ifndef TSVWriter_h
#define TSVWriter_h

#include <string>
#include <sstream>
#include <fstream>
#include <iomanip>

#include <Writer.h>
#include <VMSData.h>

class TSVWriter : public Writer{
public:
	TSVWriter(std::string filename){
		of.open(filename + ".tsv", std::ios::out);
	}

	TSVWriter(int year, int month, int day, int partition){
		stringstream filename;
		filename << setfill('0');
		filename << year;
		filename << setw(2) << month;
		filename << setw(2) << day;
		filename << ".p" << partition << ".tsv";
		of.open(filename.str(), std::ios::out);
	}

	~TSVWriter(){
		if(of.is_open()){
			of.close();
		}
	}

	bool writeEntry(const VMSData& data){
		of << setprecision(10) << 
			data.getDESTINATION() << "	" <<
			data.getCOUNTRY() << "	" <<
			data.getMESSAGETYPE() << "	" <<
			data.getVESSELNAME() << "	" <<
			data.getREGISTRATION() << "	" <<
			data.getCALLSIGN() << "	" <<
			data.getDATE() << "	" <<
			data.getTIME() << "	" <<
			data.getLAT() << "	" <<
			data.getLON() << "	" <<
			data.getSPEED() << "	" <<
			data.getCOURSE() << "	" <<
			data.getFLAG() << "	" << endl;
		return true;
	}

	bool isReady(){
		return of.is_open();
	}

private:
	std::ofstream of;
};
#endif
