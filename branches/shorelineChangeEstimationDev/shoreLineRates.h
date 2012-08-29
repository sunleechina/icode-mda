//ossim includes
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

//shapefil library for esri shapefiles
#include <shapefil.h>

//boost library includes
#include <boost/geometry.hpp>
#include <boost/geometry/geometries/linestring.hpp>
#include <boost/geometry/geometries/point_xy.hpp>

using namespace std;

#define PI 3.142
	
	 // baseline type parameter. To be developed later
#define AUTO_BASELINE	1
#define MULTI_BASELINE	2
#define SINGLE_BASELINE	3

	//  shoreline change rate change tool [parameter] to use. To be developed later
#define ENDPOINT_RATE					1
#define LEAST_MEDIAN_SQUARE				2
#define NET_SHORELINE_MOVEMENT			3
#define LINEAR_REGRESSION_RATE			4
#define SHORELINE_CHANGE_ENVELOPE		5
#define	WEIGHTED_LINEAR_REGRESSION_RATE	6

typedef boost::geometry::model::d2::point_xy <double> point;
typedef boost::geometry::model::linestring <point> linestring;

//forward declaration
class coordinate;
class TransectLine;
class BaseLine;
class ShoreLine;

vector <coordinate> transectPoint;
vector <coordinate> transectLineEnd;

	
class coordinate
{
public:
	coordinate(double x, double y)
	{
		this->X=x;
		this->Y=y;
	}
	double X,Y;
};

vector <coordinate> shoreLinePoints;
//contains the baseline/collection of baselines for the shoreline
class ShoreLine{
private:
			vector<point> intersectingPoints;
			linestring shoreline;//You could just initialise shoreline to the shapefile
public:
	
void getShapePoints(string filename)
	{
		RegisterOGRShape();				//	OGR Drivers for reading shapefiles only
		OGRDataSource *poDS;

		cout<<"Reading in file "<<filename<<endl;
		poDS = OGRSFDriverRegistrar::Open( filename.c_str(), FALSE );
		
		if ( poDS == NULL )
		{
			printf("Open fail");
			exit(1);
		}

		OGRLayer  *poLayer;
		poLayer = poDS->GetLayer(0);
		OGRFeature *poFeature;
		poLayer->ResetReading();
		
		unsigned int numpoints=0;

		while( (poFeature = poLayer->GetNextFeature()) != NULL )
		{
			OGRGeometry *poGeometry;
			poGeometry = poFeature->GetGeometryRef();
			
			numpoints = ((OGRLineString*)poGeometry)->getNumPoints();

			// can rewrite this part into a switch statement to allow for all other 
			// types of shapefiles
			// look for the dump readable implementation
			if( poGeometry != NULL && wkbFlatten(poGeometry->getGeometryType()) == wkbLineString )
			{
				OGRLineString *poLine= (OGRLineString*) poGeometry;
				for (unsigned int i=0;i<=numpoints;i++)
				{
					//shoreLinePoints actually represents the  
					shoreLinePoints.push_back(coordinate(poLine->getX(i),poLine->getY(i)));
				}
			}
			else
					if( poGeometry != NULL && wkbFlatten(poGeometry->getGeometryType()) == wkbPoint)
			{
				OGRPoint *poPoint= (OGRPoint*) poGeometry;
				for (unsigned int i=0;i<=numpoints;i++)
				{
					//shoreLinePoints actually represents the  
					shoreLinePoints.push_back(coordinate(poPoint->getX(),poPoint->getY()));
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

	void loadShoreLine(string fileName,bool printFiles = false)
	{
	ShoreLine mShoreLineA;
	
		//load shapefiles into member variables mShoreLineA and mShoreLineB
		mShoreLineA.getShapePoints(fileName);

		if(printFiles = true)
		//Will have to print both file's names 
		cout<<endl<<"--------------"<<fileName<<"-------------------"<<endl;

		mShoreLineA.printShoreLine();
	}

	void getIntersectionPoints()// string shorelineName)
	{
		// Uses transect points to obtain the intersection point

try{
		for(unsigned int i = 0; i<shoreLinePoints.size(); i++)
		{
			point temp(shoreLinePoints[i].X,shoreLinePoints[i].Y);	// defines a temp variable consisting of X,Y loaded by the shoreline object
			shoreline.push_back(temp);  // puts the shoreline [X and Y] into a linestring variable 
		}
}
			catch (exception&)
{
	cout<<"shoreline.push_back(temp) at line 165"<<endl;
}

try{
		for(unsigned int i=0;i<transectPoint.size();i++)
		{
			linestring transect;
			point transectPointFromBaseline(transectPoint[i].X, transectPoint[i].Y);
			transect.push_back(transectPointFromBaseline);

			point transectPointCalculatedOnOtherSideOfShoreline(transectLineEnd[i].X,transectLineEnd[i].Y);
			transect.push_back(transectPointCalculatedOnOtherSideOfShoreline);


			boost::geometry::intersection(shoreline, transect, intersectingPoints);
			intersectingPointsOfTransect.push_back(intersectingPoints);

		
		}
	
}
			catch (exception&)
{
	cout<<"transect.push_back or intersectingPointsOfTransect.push_back: 176 -185"<<endl;
}

for (unsigned int i=0;i<transectPoint.size();i++)
		{

		}
	}
	
	void printShoreLine()
	{
		for (unsigned int i=0; i<shoreLinePoints.size();i++)
		{
			printf("(%10.11f , %10.11f)\n",shoreLinePoints[i].X,shoreLinePoints[i].Y);
		}
	}
	void printIntersectionPoints()
	{
			for(unsigned int i=0; i<intersectingPoints.size(); i++)
			{
				cout << "(" << intersectingPoints[i].x() <<", " <<
					intersectingPoints[i].y() << ")" << endl;
			}
	}
	vector < vector < point > > intersectingPointsOfTransect;
};

class BaseLine{
private:
	double d,slp,trns_int,baseLineX1,baseLineX2,baseLineY1,baseLineY2,m,c;
	int n;
public:

//Test this method. How ever, its not nearly the most important thing in question here
	void writeBaselineShp(string outputFile)
	{
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

		void getBaseLine(ShoreLine BaseShoreLine, double offset=0.00,bool detail=false)
	{
		baseLineX1 = shoreLinePoints.front().X;
		baseLineY1 = shoreLinePoints.front().Y;
		baseLineX2 = shoreLinePoints.back().X;
		baseLineY2 = shoreLinePoints.back().Y;

		
		m = (baseLineY2 - baseLineY1) / (baseLineX2 - baseLineX1);	
		c = baseLineY1 - m*baseLineX1;
		slp = atan(m)*(180/PI);
		d = sqrt(pow((baseLineX2-baseLineX1),2)+pow((baseLineY2-baseLineY1),2));

		cout<<"Please enter transect interval: ....";
		cin>>trns_int;
		
		printf("\nGradient: \t\t%f\n",m);
		n=ceil(d/trns_int);

		// Must determine intersection points here
		if(detail=true)
		{
		cout<<"\nSlope:\t\t\t"<<slp
			<<"\nNumber of transects:\t"<<n
			<<"\nDistance: \t\t"<<d
			<<"\nIntercept: \t\t"<<c
			<<"\nx1: \t\t\t"<<baseLineX1
			<<"\ny1: \t\t\t"<<baseLineY1
			<<"\nx2: \t\t\t"<<baseLineX2
			<<"\ny2: \t\t\t"<<baseLineY2;
		}
	}

		void getBaseLine(string Filename,int baseLineType, double offset=0.00)
	{
		
		if(baseLineType==1)
		{
//			mShoreLineA
				baseLineX1 = shoreLinePoints.front().X;
				baseLineY1 = shoreLinePoints.front().Y;
				
				baseLineX2 = shoreLinePoints.back().X;
				baseLineY2 = shoreLinePoints.back().Y;

			if(shoreLinePoints.size() == 0 )  //X & Y need to be coordinates from the shapefile1
			{
				cerr << "no data" << endl;
				
				
				return;
			}
		else if (baseLineType==2)
		{
				cout<<"Enter x1: \n";
				cin>>baseLineX1;
				cout<<"Enter y1: \n";
				cin>>baseLineY1;
				cout<<"Enter x2: \n";
				cin>>baseLineX2;
				cout<<"Enter y1: \n";
				cin>>baseLineY2;
		}
		else if (baseLineType==3)
			{
				//vector of vector coordinates

				vector < vector<coordinate> > BaseLine;
				//now how to read in values. 
				//consult matlab script


			}
		}
		
		baseLineX1 = shoreLinePoints.front().X + (-m*offset) / sqrt(pow(m,2) + 1);
		baseLineY1 = shoreLinePoints.front().Y + offset*( 1 / sqrt(pow(m,2) + 1) );
		
		baseLineX2 = shoreLinePoints.back().X + (-m*offset) / sqrt(pow(m,2) + 1);
		baseLineY2 = shoreLinePoints.back().Y + offset*( 1 / sqrt(pow(m,2) + 1) );

		m = (baseLineY2-baseLineY1) / (baseLineX2-baseLineX1);	
		c = baseLineY1-m*baseLineX1;
		slp = atan(m)*(180/PI);
		d = sqrt(pow((baseLineX2-baseLineX1),2)+pow((baseLineY2-baseLineY1),2));

		cout<<"Please enter transect interval: ....";
		cin>>trns_int;
		printf("\ngradient: \t%f\n",m);

		n=ceil(d/trns_int);


		// Must determine intersection points here
		cout<<"\nslope:\t"<<slp
			<<"\nnumber of transects:\t"<<n
			<<"\ndistance: \t"<<d
			<<"\nintercept: \t"<<c;
	}

//Obtains corresponding points for transectline of shoreline
	void getTransectPoints()
		{
		double a=d*cos(atan(m)); // what is a?

		if (a=NULL)
		{
			cout<<"getTransectPoints() fail"<<endl;
			exit(1);
		}

		try
		{
		for (int i=0;i<n;i++)
		{
			double xx=baseLineX1+i*a;
			transectPoint.push_back(coordinate(xx,m*(xx)+c));
		}
		}
			catch (exception&)
		{
			cout<<"Line 380"<<endl;
		}
	}

	
void setTransectLines()
	{
		float extremex;
		if (m<0)
		{
			extremex=-9999999;
			//determine max X
			for(unsigned int i=0;i<shoreLinePoints.size();i++)
			{
				if(shoreLinePoints[i].X> extremex)
				{
					extremex=shoreLinePoints[i].X;
				}
			}
			extremex+=10;
		}
		else
		{
			extremex=9999999;
			//determine minX
			for(unsigned int i=0;i<shoreLinePoints.size();i++)
			{
				if(shoreLinePoints[i].X<extremex)
				{
					extremex=shoreLinePoints[i].X;
				}
			}
			extremex-=10;
		}

		//evaluate equations of transect lines at extremex to get the y value
			for (unsigned int i=0; i<transectPoint.size();i++)
		{
			float y=-1/m*extremex+c+(m+1/m)*transectPoint[i].X;
			transectLineEnd.push_back(coordinate(extremex,y));
		}
	}
};

/*class TransectLine{

private:
	
	double baselineM,baselineC;

	
//	void getVar(BaseLine &base)
//	{
//		baselineM=base.m;
//		baselineC=base.c;
//	}


public:

//	friend class ShoreLineComparer;	
	/*
void getTransectPoints()
	{


	}
//Sets the endpoint coordinates for the transect lines
void setTransectLines()
	{
		float extremex;
		if (baselineM<0)
		{
			extremex=-9999999;
			//determine max X
			for(unsigned int i=0;i<shoreLinePoints.size();i++)
			{
				if(shoreLinePoints[i].X> extremex)
				{
					extremex=shoreLinePoints[i].X;
				}
			}
			extremex+=10;
		}
		else
		{
			extremex=9999999;
			//determine minX
			for(unsigned int i=0;i<shoreLinePoints.size();i++)
			{
				if(shoreLinePoints[i].X<extremex)
				{
					extremex=shoreLinePoints[i].X;
				}
			}
			extremex-=10;
		}

		//evaluate equations of transect lines at extremex to get the y value
			for (unsigned int i=0; i<transectPoint.size();i++)
		{
			float y=-1/baselineM*extremex+baselineC+(baselineM+1/baselineM)*transectPoint[i].X;
			transectLineEnd.push_back(coordinate(extremex,y));
		}
	}
};*/

class ShoreLineComparer
{
	//sum of( difference b/n point a on shoreline A and corresponding point b on shoreline B[ =distance changed/ ])
	//divided by the number of years difference. (year of shapefile)
	
private:
	double d;			// Sums the difference b/n the two transect intersectino points
	double y1,y2,x2,x1;	// This probably isn't the rigt way to go about this
	unsigned int yrs;	
	
BaseLine Base;
ShoreLine ShoreA;
ShoreLine ShoreB;

public:
void averageRate(string file1,string file2,unsigned int noOfYears)	//&file1,&file2,yrs)//accept age of shoreline by 
{	

		//	loop through the intersection points
		//	first extract the (X,Y) transectpoints into this (x1,y1),(x2,y2) then 
		//	something like transectPoints
	try{
			ShoreA.getShapePoints(file1);
			ShoreB.getShapePoints(file2);
			
			Base.getBaseLine(ShoreA);
			Base.setTransectLines();
			Base.getTransectPoints();
			
			//ShoreA.getIntersectionPoints();
			//ShoreA.printIntersectionPoints();
	
			//ShoreB.getIntersectionPoints();
			//ShoreB.printIntersectionPoints();

			
			vector <double> individualD;
			for (unsigned int i=0;i<=transectPoint.size();i++)
			{
				
				// how do i access a vector of a vector of a boost library point?
				// the second loop to go through 
				for (unsigned int j;j<=ShoreA.intersectingPointsOfTransect.size();j++)	//This can't be transectPoint again
				{
					
					x1=ShoreA.intersectingPointsOfTransect[i][j].x();
					y1=ShoreA.intersectingPointsOfTransect[i][j].y();

					x2=ShoreB.intersectingPointsOfTransect[i][j].x();
					y2=ShoreB.intersectingPointsOfTransect[i][j].y();

					//cout<<"x1\t\t"<<"y1\t\t"<<"x2\t\t"<<"y2\t\t"<<endl;
					//cout<<x1<<"\t\t"<<y1<<"\t\t"<<x2<<"\t\t"<<y2<<"\t\t"<<endl;
					d+=sqrt(pow((x2-x1),2)+pow((y2-y1),2));
					individualD.push_back(d);
					
				}
			}
		
			// And the answer is ...
			
			cout<<"\nAverage Rate is:"<<d/noOfYears<<"... per year\n\n\n";
			cout<<"individualD.size()= "<<individualD.size();
			for (unsigned int i=0; i<=individualD.size();i++)
			{
				cout<<individualD[i];
			}
		}
			catch (exception&)
			{
				cout<<"Something wrong"<<endl;
			}

	}

//	these aught to work in later editions
//	Shoreline Change Envelope(SCE) [Distance b/n the shorelines farthest and closest to the baseline at each transect]
//	Net Shoreline Movement (NSM) [reports the distance between the oldest and youngest shorelines for each transect]
//	End Point Rate (EPR) [dividing the distance of shoreline movement by the time elapsed between the oldest and the most recent shoreline]
//	Linear Regression Rate (LRR) [fitting a least-squares regression line to all shoreline points for a particular transect]
//	Weighted Linear Regression (WLR) [In a weighted linear regression, more reliable data are given greater emphasis or weight towards determining a best-fit line]
void ShoreLineRate(int method) // use the methods declared globally
	{

	}
};