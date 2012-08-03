//Standard library includes
#include <string>
#include <vector>
#include <deque>
#include <ctime>
		
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
	
	//baseline type parameter. To be developed later
#define AUTO_BASELINE	1
#define SINGLE_BASELINE	2
#define MULTI_BASELINE	3

	//shoreline change rate change tool [parameter] to use. To be developed later
#define LINEAR_REGRESSION_RATE		1
#define LEAST_MEDIAN_SQUARE			2
#define ENDPOINT_RATE				3
#define SHORELINE_CHANGE_ENVELOPE	4
#define NET_SHORELINE_MOVEMENT		5

	vector < double > X;
	vector < double > Y;
	typedef boost::geometry::model::d2::point_xy<double> point;
	typedef boost::geometry::model::linestring<point> linestring;


class coordinate{
public:
	coordinate(double x, double y)
	{
		this->X=x;
		this->Y=y;
	}
	double X,Y;
};
vector <coordinate> transectPoint;
vector <coordinate> transectLineEnd;

//contains the baseline/collection of baselines for the shoreline
class ShoreLine{
public:
		
	void loadShoreLine(string file1, string file2, bool printFiles = false)
	{
		ShoreLine mShoreLineA;
		ShoreLine mShoreLineB;

		//load shapefiles into member variables mShoreLineA and mShoreLineB
		mShoreLineA.getShapePoints(file1);
		mShoreLineB.getShapePoints(file2);

		if(printFiles = true)
		//Will have to print both file's names 
		cout<<endl<<"--------------"<<file1<<"-------------------"<<endl;
		mShoreLineA.printShoreLine();
		cout<<endl<<"--------------"<<file2<<"-------------------"<<endl;
		mShoreLineB.printShoreLine();
	}


	void getShapePoints(string filename)
	{
		RegisterOGRShape();				/* OGR Drivers for reading shapefiles only */
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
	void getIntersectionPoints()// string shorelineName)
	{
		// use the transect points to obtain the intersection point

		linestring shoreline;//You could just initialise shoreline to the shapefile

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
	
	void printShoreLine()
	{
		for (unsigned int j=0; j<X.size();j++)
		{
			printf("(%10.11f , %10.11f)\n",X[j],Y[j]);
		}
	}
		
	vector < vector < point > > intersectingPointsOfTransect;
};

class BaseLine{
private:
	double d,slp,trns_int;
	int n;
	
protected:
	double x1, x2, y1,y2;
public:
	double m,c;
	//Test this method. How ever, its not nearly the most important thing in question here
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
	void getBaseLine(string Filename,int baseLineType, double offset=0.00)
	{
		
		if(baseLineType==1)
		{
			if(X.size() == 0 || Y.size() == 0)  //X & Y need to be coordinates from the shapefile1
			{
				cerr << "no data" << endl;
				
				//must make this a coordinate type
				X.begin();
				Y.begin();
				X.end();
				Y.end();

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
				//vector of vector coordinates

				vector<coordinate> multiBaseLine;
				//now how to read in values. 
				//consult matlab script
			}
		}

		x1 = X.front() + (-m*offset) / sqrt(pow(m,2) + 1);
		x2 = X.back() + (-m*offset) / sqrt(pow(m,2) + 1);
		y1 = Y.front() + offset*( 1 / sqrt(pow(m,2) + 1) );
		y2 = Y.back() + offset*( 1 / sqrt(pow(m,2) + 1) );

		m = (y2-y1) / (x2-x1);	
		c = y1-m*x1;
		slp = atan(m)*(180/PI);
		d = sqrt(pow((x2-x1),2)+pow((y2-y1),2));

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
//Obtains transect points of baseline / shoreline. Not sure which yet
	void getTransectPoints()
		{
		double a=d*cos(atan(m)); // what is a?

		for (int i=0;i<n;i++)
		{
			double xx=x1+i*a;
			transectPoint.push_back(coordinate(xx,m*(xx)+c));
		}
	}
};

class TransectLine:BaseLine{
public:
void getTransectPoints()
	{}
//Sets the endpoint coordinates for the transect lines
void setTransectLines()
	{
		float extremex;
		if (m<0)
		{
			extremex=-9999999;
			//determine max X
			for(unsigned int i=0;i<X.size();i++)
			{
				if(X.at(i)> extremex)
				{
					extremex=X[i];
				}
			}
			extremex+=10;
		}
		else
		{
			extremex=9999999;
			//determine minX
			for(unsigned int i=0;i<X.size();i++)
			{
				if(X.at(i)<extremex)
				{
					extremex=X[i];
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

class ShoreLineComparer
{
	//sum of( difference b/n point a on shoreline A and corresponding point b on shoreline B[ =distance changed/ ])
	//divided by the number of years difference. (year of shapefile)
	
private:
	double d;			// sums the difference b/n the two transect intersectino points
	double y1,y2,x2,x1;	//

public:
	unsigned int yrs;	
void averageRate()//&file1,&file2,yrs)//accept age of shoreline by 
{	
	cout<<"\nenter time difference in years"<<endl;

		for (unsigned int i=0;i<=transectPoint.size();i++)
		{

		//loop through the intersection points
		//first extract the (X,Y) transectpoints into this (x1,y1),(x2,y2) then 
		//something like transectPoints
		d+=sqrt(pow((x2-x1),2)+pow((y2-y1),2));
		}
	}

// this aught to work in later editions
/*
void compare(int method)
	{
		}
		*/
};