#include <iostream>
#include <cassert>
#include <string>
#include <vector>
#include <deque>
#include <ctime>
		
#include "ogrsf_frmts.h"
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
#include <shapefil.h>

#include <boost/geometry.hpp>
#include <boost/geometry/geometries/linestring.hpp>
#include <boost/geometry/geometries/point_xy.hpp>

using namespace std;

#define PI 3.142
	static const int AUTO_BASELINE = 1;
	static const int SINGLE_BASELINE = 2;
	static const int MULTI_BASELINE = 3;

double m,c,d,slp,trns_int;
int n;
//double x1;		
//double x2;
//double y1;	
//double y2;
vector < double > X;
vector < double > Y;
typedef boost::geometry::model::d2::point_xy<double> point;
typedef boost::geometry::model::linestring<point> linestring;

class coordinate
{
public:
	//constructor
	coordinate(double x, double y)
	{
		this->X=x;
		this->Y=y;
	}
	double X,Y;
};

vector < coordinate > transectPoint;
vector < coordinate > transectLineEnd;

//////////////////////
// Baseline class	//
//////////////////////
class BaseLine
{
private:

	double m,c,d,slp,trns_int;
	int n;
	double x1, x2, y1,y2;
public:
	//these dont seem, to be working too well
	


	void setBaseLine(double Offset)
	
	{
		double o=Offset;
//		shoreline.getBaseLine(o);
	}

//	void setBaseLine()
//	{}
//	void setBaseLine(int baselineType=2,double Offset=0)
//	{}
	
	//void baselineShp(string outputFile)
	//{
	//	string File=outputFile;
	////	mCoastA.writeBaselineShp(File);
	//}
	
	void writeBaselineShp(string outputFile){
		ossimFilename shapefilename(outputFile+="_Shp");
		SHPHandle hSHP = SHPCreate(outputFile.c_str(), SHPT_MULTIPOINT);

		SHPObject *psObject;
		if(hSHP == NULL)
		{
			cout << "Shapefile could not be created" << endl;
		}

		DBFHandle hDBF;
		hDBF = DBFCreate(outputFile.c_str());

		int nVertices = transectPoint.size();
		vector <int> panParts;
		vector <double> padfX;
		vector <double> padfY;

		for(unsigned int i = 0; i<transectPoint.size(); i++)
		{
			padfX.push_back(transectPoint[i].X);
			padfY.push_back(transectPoint[i].Y);
		}	

		//cout<<"\nWriting shapefile\n";
		psObject = SHPCreateObject(SHPT_MULTIPOINT, -1, 1, panParts.data(), NULL, nVertices , padfX.data(), padfY.data(), NULL, NULL); 

		SHPWriteObject(hSHP, -1, psObject );

		SHPDestroyObject(psObject );

		SHPClose(hSHP );
	}
	void setTransectLines()
	{
		// calculate the maximum point on the shoreline
		// offset the maximum by a default value
		// set transect endpoint to offset value [adjusted via e]

		float extremeX;
		if (m<0)
		{
			extremeX=-9999999;
			//determine maxX
			for(unsigned int i=0;i<X.size();i++)
			{
				if(X.at(i)> extremeX)
				{
					extremeX=X[i];
				}
			}
			extremeX+=10;

		}
		else
		{
			extremeX=9999999;
			//determine minX
			for(unsigned int i=0;i<X.size();i++)
			{
				if(X.at(i)<extremeX)
				{
					extremeX=X[i];
				}
			}
			extremeX-=10;

		}

		//evaluate equations of transect lines at extremeX to get the y value

		for (unsigned int i=0; i<transectPoint.size();i++)
		{
			float y=-1/m*extremeX+c+(m+1/m)*transectPoint[i].X;  
			transectLineEnd.push_back(coordinate(extremeX,y));
		}
		// determine maxX and minX
		// if baseline slope <0, use maxX as the x coord needed to calculate the (x,y) to make a transect line
		// if baseline slope >0, use minX
		// y=-1/m*x+(b+m+1/m)xi     where x = minX- or maxX+, where applicable
	}
	// look for first shoreline		//shoreLine.[1];
	// determine whether to create 1 baseline/create multiple baselines
	// create transects
	// 
	
	void getBaseLine(string Filename,int baseLineType ,double offset=0.00)
	{
		
		if(baseLineType==1)
		{
			if(X.size() == 0 || Y.size()==0)
			{
				cerr << "no data" << endl;
				return;
			}
			else if (baseLineType==2)
			{
				cout<<"x1\n";
				cin>>x1;
				cout<<"y1\n";
				cin>>y1;
				cout<<"x2\n";
				cin>>x2;
				cout<<"y1\n";
				cin>>y2;
			}
			else if (baseLineType==3)
			{
			}

		}


		x1=X.front()+ (-m*offset)/sqrt(pow(m,2)+1);
		x2=X.back()+ (-m*offset)/sqrt(pow(m,2)+1);
		y1=Y.front()+offset*(1/sqrt(pow(m,2)+1));
		y2=Y.back()+offset*(1/sqrt(pow(m,2)+1));

		m=(y2-y1)/(x2-x1);	
		c=y1-m*x1;
		slp=atan(m)*(180/PI);
		d=sqrt(pow((x2-x1),2)+pow((y2-y1),2));

		cout<<"Please enter transect interval: ....";
		cin>>trns_int;
		printf("\ngradient: \t%f\n",m);

		n=ceil(d/trns_int);


		// Must determine intersection points here
		cout<<"slope:\t"<<slp
			<<"\nnumber of transects:\t"<<n
			<<"\ndistance: \t"<<d
			<<"\nintercept: \t"<<c;
	}
	void getTransectPoints()
	{
		double a=d*cos(atan(m));

		for (int i=0;i<n;i++)
		{
			double xx=x1+i*a;
			transectPoint.push_back(coordinate(xx,m*(xx)+c));
		}
	}
	
};


/////////////////////////////////////
// when loading the other shapefiles, 
// check to ensure both use the same coordinate system
// after loading everything, store everything into one folder [directory]
//////////////////////////////////////////////////////////////////////////


class ShoreLine
{
	// store intersections in the shoreline class
	private:
		
//	double x1;		
//	double x2;
//	double y1;	
//	double y2;
public:

	/*ShoreLine()
	{
		//m,c,d,slp, trns_int,x1,x2,y1,y2=0;
		//n=0;
	}
	*/
	
//	void loadShoreLine(string file1)
//	{
//	}

//	void loadShoreLine(string file1,bool printFiles = false)
//	{
//	}

	//can make this for an OSSIM test applications file
	void loadShoreLine(string file1, string file2, bool printFiles = false)
	{
		//load shapefiles into member variables mCoastA and mCoastB
		//		mCoastA.getShapePoints(file1);
		//		mCoastB.getShapePoints(file2);

		if(printFiles)
		{
			//print them to make sure they're okay
			//			mCoastA.print();
			//			mCoastB.print();
		}
	}

	// need to overload this guy to readin the different types of shapefiles
	void getShapePoints(string filename)
	{
		RegisterOGRShape();				/* OGR Drivers for reading shapefiles only*/
		OGRDataSource *poDS;

		poDS = OGRSFDriverRegistrar::Open( filename.c_str(), FALSE );
		cout<<"Reading in file\n";

		if ( poDS == NULL )
		{
			printf("Open fail");
			exit(1);
		}

		OGRLayer  *poLayer;
		poLayer = poDS->GetLayer(0);
		OGRFeature *poFeature;
		poLayer->ResetReading();

		int numpoints=0;

		while( (poFeature = poLayer->GetNextFeature()) != NULL )
		{
			OGRGeometry *poGeometry;
			poGeometry = poFeature->GetGeometryRef();
			numpoints = ((OGRLineString*)poGeometry)->getNumPoints();

			// can rewrite this part into a switch statement to allow for all other 
			// types of shapefiles
			if( poGeometry != NULL && wkbFlatten(poGeometry->getGeometryType()) == wkbLineString )
			{
				OGRLineString *poLine= (OGRLineString*) poGeometry;
				for (int i=0;i<=numpoints;i++)
				{
					//write to vector here
					X.push_back(poLine->getX(i));
					Y.push_back(poLine->getY(i));
				}
			}
			else
			{
				printf( "no readable geometry\n" );
			}
			OGRFeature::DestroyFeature( poFeature );
		}

		OGRDataSource::DestroyDataSource( poDS );
		return;
	}

	
	void getIntersectionPoints()
	{
		// use the transect points to obtain the intersection point

		linestring shoreline;//you could just initialise shoreline to the shapefile

		for(unsigned int i =0; i<X.size(); i++)
		{
			point temp(X[i], Y[i]);
			shoreline.push_back(temp);
		}

		for(unsigned int i=0;i<transectPoint.size();i++)
		{

			linestring transect;
			point transectPointFromBaseline(transectPoint[i].X, transectPoint[i].Y);
			transect.push_back(transectPointFromBaseline);

			point transectPointCalculatedOnOtherSideOfShoreline(transectLineEnd[i].X,transectLineEnd[i].Y);
			transect.push_back(transectPointCalculatedOnOtherSideOfShoreline);

			vector<point> intersectingPoints;

			boost::geometry::intersection(shoreline, transect, intersectingPoints);
			intersectingPointsOfTransect.push_back(intersectingPoints);

			for(unsigned int j=0; j<intersectingPoints.size(); j++)
			{
				cout << "(" << intersectingPoints[j].x() <<", " <<
					intersectingPoints[j].y() << ")" << endl;
			}
		}
		for (unsigned int i=0;i<transectPoint.size();i++)
		{

		}
	}
	
	// OK
	void printShoreLine()
	{
		for (unsigned int j=0; j<X.size();j++)
		{
			printf("(%10.11f , %10.11f)\n",X[j],Y[j]);
		}
	}
	
		vector < vector < point > > intersectingPointsOfTransect;
	
};

class ShoreLineComparer:public ShoreLine,public BaseLine{
	//sum of( difference b/n point a on shorelina A and corresponding point b on shoreline B[ =distance changed/ ])
	// divided by the number of years difference. (year of shapefile)

protected:

	void averageRate()//accept age of shoreline by 
	{
		//loop through the intersection points
		d+=sqrt(pow((x2-x1),2)+pow((y2-y1),2));

		// need a date calculation function/library for this job
	//	nYrs=yr2-yr1;
	//	nMnths=mn2-mn1;

		//d/nYrs;
		//d/nMnths;
	}


public:
	//ShoreLineComparer()
	//{

	//}
	//unsigned int yr1,yr2,nMnths,mn1,mn2;
	
	
	double d;
	unsigned int nYrs;
	double y1,y2,x2,x1;

	
	/*
	void transect()
	{
		mCoastA.getTransectPoints();
	}*/
	void compare(int method)
	{
		//now compare the two coast lines using specified method
		// method A is what we'll build first
		// method A will just build a transect and so on with preset parameters for now
		// different results (METHODS) to compute
		/*  weighted linear regression
		1	linear regression rate
		2	least median of squares
		3	net shoreline movement
		4	shoreline change envelope
		5	endpoint rate
		*/

		/*if(method==NET_SHORELINE_MOVEMENT)
		{
			for (int i=0;i<x1.size();i++)//inputShp1.
			{}
		}
		*/
	}

//	static const int LINEAR_REGRESSION_RATE=1;
//	static const int LEAST_MEDIAN_SQUARE=2;
//	static const int ENDPOINT_RATE=3;
//	static const int SHORELINE_CHANGE_ENVELOPE=4;
//	static const int NET_SHORELINE_MOVEMENT=5;

	/*ShoreLine mCoastA;
	ShoreLine mCoastB;

	BaseLine CoastA;

	friend class ShoreLine;
	friend class Baseline;*/
};