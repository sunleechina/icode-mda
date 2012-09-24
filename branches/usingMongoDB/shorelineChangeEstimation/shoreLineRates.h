/****************************************************************************************
 *				*** shoreLineRates.cpp ***												*
 *					Project:	icode-mda												*
 *																						*
 *					Purpose:	Implementation for shoreline rate change calculations	*
 *																						*
 *					Author:		Tsatsu Amable											*
 *																						*
 ****************************************************************************************/
//last edited: 29/08/2012


#ifndef shoreLineRates_H_
#define shoreLineRates_H_


//ossim includes
#include <ossim/base/ossimFilename.h>
#include <ossim/base/ossimRefPtr.h>
#include <ossim/base/ossimStdOutProgress.h>
#include <ossim/base/ossimStringProperty.h>
#include <ossim/base/ossimTimer.h>
#include <ossim/base/ossimViewInterface.h>
#include <ossim/imaging/ossimImageFileWriter.h>
#include <ossim/imaging/ossimImageWriterFactoryRegistry.h>
#include <ossim/imaging/ossimImageHandler.h>
#include <ossim/imaging/ossimImageHandlerRegistry.h>
#include <ossim/imaging/ossimMaskFilter.h>
#include <ossim/imaging/ossimSingleImageChain.h>
#include <ossim/imaging/ossimTiffWriter.h>
#include <ossim/imaging/ossimRLevelFilter.h>
#include <ossim/projection/ossimBilinearProjection.h>
#include <ossim/projection/ossimTransMercatorProjection.h>
#include <ossim/imaging/ossimImageGeometry.h>
#include <ossim/init/ossimInit.h>
#include <ossim/imaging/ossimImageMosaic.h>
#include <ossim/imaging/ossimRLevelFilter.h>
#include <ossim/imaging/ossimOverviewBuilderBase.h>
#include <ossim/imaging/ossimOverviewBuilderFactoryRegistry.h>

#include <gdal/ogrsf_frmts.h>
#include <gdal/ogr_feature.h>

//shapefil library for esri shapefiles
#include <shapefil.h>

//boost library includes
#include <boost/geometry.hpp>
#include <boost/geometry/geometries/linestring.hpp>
#include <boost/geometry/geometries/point_xy.hpp>

using namespace std;

#define PI 3.142
	
typedef boost::geometry::model::d2::point_xy <double> point;
typedef boost::geometry::model::linestring <point> linestring;


//forward declaration
/*class TransectLine;
class BaseLine;
class ShoreLine;
*/

class coordinate{
public:
	coordinate(double x, double y);
	
	double X,Y;
};


vector <coordinate> transectPoint;
vector <coordinate> transectLineEnd;
vector <coordinate> shoreLinePoints;

class ShoreLine{
	private:
			vector<point> intersectingPoints;
			linestring shoreline;//You could just initialise shoreline to the shapefile
public:
	void getShapePoints(string filename);
	void loadShoreLine(string fileName,bool printFiles = false);
	void getIntersectionPoints();
	void printShoreLine();
	void printIntersectionPoints();

	vector < vector < point > > intersectingPointsOfTransect;
};

class BaseLine{
private:
	double d
		  ,slp
		  ,trns_int
		  ,baseLineX1
		  ,baseLineX2
		  ,baseLineY1
		  ,baseLineY2
		  ,m
		  ,c;
	int n;
public:
	
	void writeBaselineShp(string outputFile);
	void getBaseLine(ShoreLine BaseShoreLine, double offset=0.00,bool detail=false);
	void getBaseLine(string Filename,int baseLineType, double offset=0.00);
	void getTransectPoints();
	void setTransectLines();
};

class ShoreLineComparer{
		
private:
	double d
		   ,y1
		   ,y2
		   ,x1
		   ,x2;
	
unsigned int yrs;	
 	
BaseLine Base;
ShoreLine ShoreA;
ShoreLine ShoreB;

public:
	void averageRate(string file1,string file2,unsigned int noOfYears);

};
#endif