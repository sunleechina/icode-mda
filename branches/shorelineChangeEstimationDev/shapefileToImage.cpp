// Refine this to something more generic rather than shoreline rate estimator
// since polar ice is also receding and growning back as well, we aught to be able
// to us this as well,
// A name like water-front change rate estimator :)

#ifndef fewerLines
#include <iostream>
#include <cassert>
#include <string>
#include <vector>
using namespace std;

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

#endif
#define PI 3.142

//Keeps shapeffile points//
class coordinate
{
public:
	//constructor
	coordinate(double x, double y)
	{
		this->X=x;
		this->Y=y;
		//		X=x;
		//		Y=y;
	}
	double X,Y;
};
//////////////////////////
class ShoreLine{
private:
	double m,c,d,slp,trns_int;
	int n;
	double x1;		
	double x2;
	double y1;	
	double y2;

public:

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
				for (unsigned int i=0;i<=numpoints;i++)
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

	void getBaseLine(double offset=0.00) // offset the line on the y-axis by adding offset number of points to the y-coord
	{

		if(X.size() == 0 || Y.size()==0){
			cerr << "no data" << endl;
			return;
		}

		x1=X.front();		
		x2=X.back();
		y1=Y.front()+offset;	//offset here

		y2=Y.back()+offset;		// offset here as well

		m=(y2-y1)/(x2-x1);		c=y1-m*x1;
		slp=atan(m)*(180/PI);	d=sqrt(pow((x2-x1),2)+pow((y2-y1),2));

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

	void writeBaselineShp(string outputFile)
	{
		ossimFilename shapefilename(outputFile+="_Shp");
		SHPHandle hSHP = SHPCreate(outputFile.c_str(), SHPT_MULTIPOINT);

		SHPObject *psObject;
		if(hSHP == NULL){
			cout << "Shapefile could not be created" << endl;
		}

		DBFHandle hDBF;
		hDBF = DBFCreate(outputFile.c_str());

		//Add all fields that we wish to access from DBF
		//DBFAddField(hDBF, "Area", FTString, 30, 0);

		int nVertices = transectPoint.size();	
		vector<int> panParts;// = new int[nVertices+1];
		vector<double> padfX;// = new double[nVertices+1];
		vector<double> padfY; //= new double[nVertices+1];

		for(int i = 0; i<transectPoint.size(); i++)
		{
			padfX.push_back(transectPoint[i].X);
			padfY.push_back(transectPoint[i].Y);
		}	

		//cout<<"\nWriting shapefile\n";
		psObject = SHPCreateObject(SHPT_MULTIPOINT, -1, 1, panParts.data(), NULL, nVertices , padfX.data(), padfY.data(), NULL, NULL); 

		SHPWriteObject(hSHP, -1, psObject );
		//DBFWriteStringAttribute(hDBF, i, 0,	ossimString::toString(polygons[i].area()));

		SHPDestroyObject(psObject );

		SHPClose(hSHP );
		DBFClose( hDBF );
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

	void setTransectLines()
	{
		/*		// calculate the maximum point on the shoreline
		// offset the maximum by a default value
		// set transect endpoint to offset value [adjusted via e]
		*/
		float extremeX;
		if (m<0)
		{
			extremeX=-99999999999;
			//determine maxX
			for(int i=0;i<X.size();i++)
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
			extremeX=99999999999;
			//determine minX
			for(int i=0;i<X.size();i++)
			{
				if(X.at(i)<extremeX)
				{
					extremeX=X[i];
				}
			}
			extremeX-=5;

		}

		//evaluate equations of transect lines at extremeX to get the y value

		for (int i=0; i<transectPoint.size();i++)
		{
			float y=-1/m*extremeX+c+(m+1/m)*transectPoint[i].X;  
			transectLineEnd.push_back(coordinate(extremeX,y));
		}
		// determine maxX and minX
		// if baseline slope <0, use maxX as the x coord needed to calculate the (x,y) to make a transect line
		// if baseline slope >0, use minX
		// y=-1/m*x+(b+m+1/m)xi     where x = minX- or maxX+, where applicable
	}

	void getIntersectionPoints()
	{
		// use the transect points to obtain the intersection point
		//
		for (int i=0;i<transectPoint.size();i++)
		{

		}
	}

	void print()
	{
		for (int j=0; j<X.size();j++)
		{
			printf("(%10.11f , %10.11f)\n",X[j],Y[j]);
		}
	}
	vector<double> X;
	vector<double> Y;
	vector<coordinate> transectPoint;
	vector<coordinate> transectLineEnd;
};
/////////////////////////
class CoastLineComparer{
	//sum of( difference b/n point a on shorelina A and corresponding point b on shoreline B[ =distance changed/ ])
	// divided by the number of years difference. (year of shapefile)

public:
	CoastLineComparer()
	{

	}
	unsigned int yr1,yr2,nMnths,mn1,mn2;
	double d;
	unsigned int nYrs;
	double y1,y2,x2,x1;

	void averageRate()//accept age of shoreline by 
	{
		//loop through the intersection points
		d+=sqrt(pow((x2-x1),2)+pow((y2-y1),2));

		// need a date calculation function/library for this job
		nYrs=yr2-yr1;
		nMnths=mn2-mn1;

		d/nYrs;
		d/nMnths;
	}
	void loadFiles(string file1, string file2, bool printFiles = false){
		//load shapefiles into member variables mCoastA and mCoastB
		mCoastA.getShapePoints(file1);
		mCoastB.getShapePoints(file2);

		if(printFiles){
			//print them to make sure they're okay
			mCoastA.print();
			mCoastB.print();
		}
	}

	void baseline(double Offset)
	{
		double o=Offset;
		mCoastA.getBaseLine(o);
	}

	void baselineShp(string outputFile)
	{
		string File=outputFile;
		mCoastA.writeBaselineShp(File);
	}

	void transect()
	{
		mCoastA.getTransectPoints();
	}

	void compare(int method){
		//now compare the two coast lines using specified method
		// method A is what we'll build first
		// method A will just build a transect and so on with preset parameters for now
		if(method==METHODA)
		{


		}

	}

	static const int METHODA = 1; // simple approach to getting baseline
	static const int METHODB = 2 ;

	ShoreLine mCoastA;
	ShoreLine mCoastB;
};
////////////////////////////////
int main(int argc,char*  argv[])
{
	ossimTimer::instance()->setStartTick();
	ossimInit::instance()->initialize(argc, argv);

	if (argc != 3)
	{
		cout << argv[0] << " <shape_file>"
			<< "\nwrites a shape file and shapePoints to \n"
			<<" an output file\n"
			<< "result to output file.\n"
			<< "output_file is a mask of image and shape.\n"
			<< endl;
		//		return 0;
	}

	ossimFilename inputShpName1 = ossimFilename(argv[1]);
	ossimFilename inputShpName2 = ossimFilename(argv[2]);
	CoastLineComparer clc;
	clc.loadFiles(argv[1], argv[2]);
	clc.baseline(1);
	clc.baselineShp("xxxxxxxxxxxxx.shp");
	clc.transect();

	//	CoastLine Ghana;
	//	Ghana.getShapePoints(argv[1]);
	//	Ghana.getBaseLine();
	//	Ghana.getTransectPoints();
	//	Ghana.writeBaselineShp(inputShpName1);
	clc.compare(CoastLineComparer::METHODA);

	//getShapePoints(inputShpName.string());
	ossimFilename outputFile  = inputShpName1.fileNoExtension().string() +"_"+ inputShpName2.fileNoExtension().string();
	//outputFile = outputFile.dirCat(inputShpName1.fileNoExtension());
	outputFile += "_output.tiff";

	cout<< "OSSIM Shoreline erosion rate estimator:"
		<< "\n <shapefile 1> "<< inputShpName1
		<< "\n <shapefile 2> "<< inputShpName2
		<< "\n Output File:  "<< outputFile
		<< endl;

	ossimRefPtr<ossimImageHandler> inputShp1 =
		ossimImageHandlerRegistry::instance()->open(inputShpName1);

	ossimRefPtr<ossimImageHandler> inputShp2 =
		ossimImageHandlerRegistry::instance()->open(inputShpName2);

	if ( inputShp1.valid() && inputShp2.valid())
	{
		if ( inputShp1->getClassName() == "ossimOgrGdalTileSource" && inputShp2->getClassName() == "ossimOgrGdalTileSource")
		{  
			ossimViewInterface* shpView1 = PTR_CAST(ossimViewInterface, inputShp1.get());
			//ossimViewInterface* shpView2 = PTR_CAST(ossimViewInterface, inputShp2.get());
			if(shpView1)//if (shpView1 && shpView2)
			{
				//set thickness to 3
				ossimRefPtr<ossimProperty> thickProp =
					new ossimStringProperty(ossimString("thickness"),
					ossimString("3"));
				inputShp1->setProperty(thickProp);
				inputShp2->setProperty(thickProp);

				ossimRefPtr<ossimImageGeometry> oig = inputShp1->getImageGeometry();
				oig->setTargetRrds(7);
				shpView1->setView(oig.get());

				/*oig = inputShp2->getImageGeometry();
				oig->setTargetRrds(7);
				shpView2->setView(oig.get());
				ossimRefPtr<ossimImageCombiner> mosaic=new ossimImageMosaic;
				mosaic->connectMyInputTo(inputShp1.get());
				mosaic->connectMyInputTo(inputShp2.get());
				*/
				/*ossimRefPtr<ossimImageGeometry> oig = mosaic->getImageGeometry();
				oig->setTargetRrds(7);
				ossimViewInterface* shpView = PTR_CAST(ossimViewInterface, mosaic.get());
				if(!shpView)
				{
				cerr << "bsddd" << endl;
				return 2;
				}
				shpView->setView(oig.get());
				mosaic->initialize();
				*/
				// Create the overview for this entry in this file:
				//bool buildOvrStatus = ob->execute();
				/*
				ossimRefPtr<ossimRLevelFilter> orlf = new ossimRLevelFilter();

				//orlf->setCurrentRLevel(7);
				orlf->setOverrideGeometryFlag(true);

				orlf->setEnableFlag(true);
				orlf->initialize();
				orlf->connectMyInputTo(ob.get());
				*/
				//mosiac code here
				//input(shapefile1, shapefile2)

				ossimRefPtr<ossimImageFileWriter> writer =
					ossimImageWriterFactoryRegistry::instance()->
					createWriterFromExtension(outputFile.ext());

				if ( writer->open( outputFile ) )
				{
					// Add a listener to get percent complete.
					ossimStdOutProgress prog(0, true);
					writer->addListener(&prog);

					writer->connectMyInputTo(0, inputShp1.get());

					//cout << inputShp->getBoundingRect() << endl;
					cout << "writing shapefile" << endl;
					writer->execute();

					cout << "Wrote file: " << outputFile
						<< "\nElapsed time(seconds): "
						<< ossimTimer::instance()->time_s() << "\n";
				}
				else
				{
					cerr << "Could not open file for writing: " << endl;
				}
			}
			else
			{
				cerr << "Could not get view interface..." << endl;
			}
		}
		else
		{
			cerr << "2nd argument must be a shape file." << endl;
		}
	}
	else
	{
		cerr << "Could not open: " << inputShpName1<<" or "<<inputShpName2<< endl;
	}
	return 0;
}