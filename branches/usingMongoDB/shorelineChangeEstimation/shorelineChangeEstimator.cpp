/************************************************************************************************************************
 * Name:	shorelineChangeEstimator.cpp : Defines the entry point for shoreline rate of change calculator application	*
 *																														*
 * Project:	ICODE-MDA																									*
 *																														*
 * Author:	Tsatsu Amable																								*
 *																														*
 * Usage:																												*
 ************************************************************************************************************************/
//last edited: 13/9/2012


#include <iostream>
#include <cassert>

#include "shoreLineRates.h"
#include <ossim/base/ossimArgumentParser.h>
#include <ossim/base/ossimApplicationUsage.h>

using namespace std;

int main(int argc,char* argv[])
{
	ossimArgumentParser argumentParser(&argc, argv);
	int originalArgCount = argc;

	ossimInit::instance()->addOptions(argumentParser);
	ossimTimer::instance()->setStartTick();
	ossimInit::instance()->initialize(argumentParser);

	if (argumentParser.argc()!= 4)
	{

	ossimString appname = argumentParser.getApplicationName();
	ossimApplicationUsage* appuse = argumentParser.getApplicationUsage();
	appuse->setApplicationName(appname);
	appuse->setDescription(appname+" ");
	appuse->setCommandLineUsage(appname+" <shoreline1.shp> <shoreline2.shp> <no of years>"
										"\nDescription"
										"\n Calculate [End Point Rate - EPR] shoreline"
										"\nrate of change using two shoreline imageries"
										"\n and their number of years apart \n");

	appuse->addCommandLineOption("-h or --help","Shows help");

	appuse->write(std::cout);
	exit(0);

	}

//	ShoreLineComparer sComp;
//	sComp.averageRate(argv[1],argv[2],unsigned int (argv[3]));					// This here is what counts
	
	cout<< ossimTimer::instance()->time_s() << " seconds\n";

	return 0;
}