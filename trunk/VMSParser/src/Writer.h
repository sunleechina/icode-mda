#ifndef Writer_h
#define Writer_h

#include <VMSData.h>
#include <Debug.h>

class Writer{
public:
	virtual bool isReady() = 0;
	virtual bool writeEntry(const VMSData& data) = 0;
	virtual ~Writer() = 0;
};
Writer::~Writer(){}

#endif
