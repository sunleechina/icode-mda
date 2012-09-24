/****************************************************************************************
 *				*** shoreLineRates.cpp ***												*
 *					Project:	icode-mda												*
 *																						*
 *					Purpose:	Implementation for shoreline rate change calculations	*
 *																						*
 *					Author:		Tsatsu Amable											*
 *																						*
 ****************************************************************************************/
 // last edited: 13/9/2012

//#include "stdafx.h"
#include "shoreLineRates.h"
#include <vector>
#include <string>

using namespace std;
coordinate::coordinate(double x,double y){
	this->X=x;
	this->Y=y;
}

//coordinate;//(double x, double y);
//contains the baseline/collection of baselines for the shoreline
void ShoreLine::getShapePoints(string filename){
		RegisterOGRShape();				//	OGR Drivers for reading shapefiles only
		OGRDataSource *poDS;

		cout<<"Reading in file shapefile"<<filename<<endl;
		poDS = OGRSFDriverRegistrar::Open( filename.c_str(), FALSE );
		
		if ( poDS == NULL ){
			printf("Open fail");
			exit(1);
		}

		OGRLayer  *poLayer; 
		poLayer = poDS->GetLayer(0);

		OGRGeometry *poGeometry;
		//poGeometry = poLayer->

		OGRFeature *poFeature;
		poFeature= poLayer->GetNextFeature();

		poLayer->ResetReading();
		
		if (poGeometry==NULL){
			return;
		}
		switch(wkbFlatten(poGeometry->getGeometryType()))
		{
		case wkbPoint:
		{	((OGRPoint*)poGeometry);/////////////////////////
			break;
		}

		case wkbLineString:
        case wkbLinearRing:
        {
            
            OGRLineString* poLS = (OGRLineString*) poGeometry;
            for(int i=0;i<poLS->getNumPoints();i++)
					shoreLinePoints.push_back(coordinate(poLS->getX(i),poLS->getY(i)));
            break;
        }
		
        case wkbPolygon:
        {
            int i;
            OGRPolygon* poPoly = (OGRPolygon*) poGeometry;
            //SetZ(poPoly->getExteriorRing(), dfZ);
            for(i=0;i<poPoly->getNumInteriorRings();i++)
              //  SetZ(poPoly->getInteriorRing(i), dfZ);
            break;
        }

        case wkbMultiPoint:
        case wkbMultiLineString:
        case wkbMultiPolygon:
        case wkbGeometryCollection:
        {
            int i;
            OGRGeometryCollection* poGeometryColl = (OGRGeometryCollection*) poGeometry;
            for(i=0;i<poGeometryColl->getNumGeometries();i++)
               // SetZ(poGeometryColl->getGeometryRef(i), dfZ);
            break;
        }

        default:
			printf( "no readable geometry\n" );
            break;
    }
	
			OGRFeature::DestroyFeature( poFeature );
		

		OGRDataSource::DestroyDataSource( poDS );
		return;
	}

void ShoreLine::loadShoreLine(string fileName,bool printFiles)
	{
	ShoreLine mShoreLineA;
	
		//load shapefiles into member variables mShoreLineA and mShoreLineB
		mShoreLineA.getShapePoints(fileName);

		if(printFiles = true)
		//Will have to print both file's names 
		cout<<endl<<"--------------"<<fileName<<"-------------------"<<endl;

		mShoreLineA.printShoreLine();
	}

	
void ShoreLine::getIntersectionPoints()// string shorelineName)
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
			//transect.push_back(transectPointFromBaseline);

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
	
void ShoreLine::printShoreLine()
	{
		for (unsigned int i=0; i<shoreLinePoints.size();i++)
		{
			printf("(%10.11f , %10.11f)\n",shoreLinePoints[i].X,shoreLinePoints[i].Y);
		}
	}
void ShoreLine::printIntersectionPoints()
	{
			for(unsigned int i=0; i<intersectingPoints.size(); i++)
			{
				cout << "(" << intersectingPoints[i].x() <<", " <<
					intersectingPoints[i].y() << ")" << endl;
			}
	}
	


//Test this method. How ever, its not nearly the most important thing in question here
void BaseLine::writeBaselineShp(string outputFile)
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

void BaseLine::getBaseLine(ShoreLine BaseShoreLine, double offset,bool detail)
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

void BaseLine::getBaseLine(string Filename,int baseLineType, double offset){
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
void BaseLine::getTransectPoints()
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
	
void BaseLine::setTransectLines()
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


	//sum of( difference b/n point a on shoreline A and corresponding point b on shoreline B[ =distance changed/ ])
	//divided by the number of years difference. (year of shapefile)
void ShoreLineComparer::averageRate(string file1,string file2,unsigned int noOfYears)	//&file1,&file2,yrs)//accept age of shoreline by 
{	

		//	loop through the intersection points
		//	first extract the (X,Y) transectpoints into this (x1,y1),(x2,y2) then 
		//	something like transectPoints
			ShoreA.getShapePoints(file1);
			ShoreB.getShapePoints(file2);
			
			Base.getBaseLine(ShoreA);
			Base.setTransectLines();
			Base.getTransectPoints();
			
			for (unsigned int i=0;i<=transectPoint.size();i++)
			{
				
				// how do i access a vector of a vector of a boost library point?
				// the second loop to go through 
				for (unsigned int j=0;j<=ShoreA.intersectingPointsOfTransect.size();j++)	//This can't be transectPoint again
				{
					
					x1=ShoreA.intersectingPointsOfTransect[i][j].x();
					y1=ShoreA.intersectingPointsOfTransect[i][j].y();

					x2=ShoreB.intersectingPointsOfTransect[i][j].x();
					y2=ShoreB.intersectingPointsOfTransect[i][j].y();

					d+=sqrt(pow((x2-x1),2)+pow((y2-y1),2));
					
				}
			}
		
			// And the answer is ...
			cout<<"\nAverage Rate is:"<<d/noOfYears<<"... per year\n\n\n";		
}


/*		OTHER USEFUL PIECES OF CODE
	//                         TranslateLayer()                           

static int TranslateLayer( OGRDataSource *poSrcDS, 
                           OGRLayer * poSrcLayer,
                           OGRDataSource *poDstDS,
                           char **papszLCO,
                           const char *pszNewLayerName,
                           int bTransform, 
                           OGRSpatialReference *poOutputSRS,
                           int bNullifyOutputSRS,
                           OGRSpatialReference *poSourceSRS,
                           char **papszSelFields,
                           int bAppend, int eGType, int bOverwrite,
                           GeomOperation eGeomOp,
                           double dfGeomOpParam,
                           char** papszFieldTypesToString,
                           long nCountLayerFeatures,
                           int bWrapDateline,
                           OGRGeometry* poClipSrc,
                           OGRGeometry *poClipDst,
                           int bExplodeCollections,
                           const char* pszZField,
                           const char* pszWHERE,
                           GDALProgressFunc pfnProgress,
                           void *pProgressArg)

{
    OGRLayer    *poDstLayer;
    OGRFeatureDefn *poSrcFDefn;
    OGRFeatureDefn *poDstFDefn = NULL;
    int         bForceToPolygon = FALSE;
    int         bForceToMultiPolygon = FALSE;
    int         bForceToMultiLineString = FALSE;
    
    char**      papszTransformOptions = NULL;

    if( pszNewLayerName == NULL )
        pszNewLayerName = poSrcLayer->GetName();

    if( wkbFlatten(eGType) == wkbPolygon )
        bForceToPolygon = TRUE;
    else if( wkbFlatten(eGType) == wkbMultiPolygon )
        bForceToMultiPolygon = TRUE;
    else if( wkbFlatten(eGType) == wkbMultiLineString )
        bForceToMultiLineString = TRUE;

//      Setup coordinate transformation if we need it.                  
//

OGRCoordinateTransformation *poCT = NULL;

    if( bTransform )
    {
        if( poSourceSRS == NULL )
            poSourceSRS = poSrcLayer->GetSpatialRef();

        if( poSourceSRS == NULL )
        {
            fprintf( stderr, "Can't transform coordinates, source layer has no\n"
                    "coordinate system.  Use -s_srs to set one.\n" );
            exit( 1 );
        }

        CPLAssert( NULL != poSourceSRS );
        CPLAssert( NULL != poOutputSRS );

        poCT = OGRCreateCoordinateTransformation( poSourceSRS, poOutputSRS );
        if( poCT == NULL )
        {
            char        *pszWKT = NULL;

            fprintf( stderr, "Failed to create coordinate transformation between the\n"
                   "following coordinate systems.  This may be because they\n"
                   "are not transformable, or because projection services\n"
                   "(PROJ.4 DLL/.so) could not be loaded.\n" );
            
            poSourceSRS->exportToPrettyWkt( &pszWKT, FALSE );
            fprintf( stderr,  "Source:\n%s\n", pszWKT );
            
            poOutputSRS->exportToPrettyWkt( &pszWKT, FALSE );
            fprintf( stderr,  "Target:\n%s\n", pszWKT );
            exit( 1 );
        }
    }
    
    if (bWrapDateline)
    {
        if( poSourceSRS == NULL )
            poSourceSRS = poSrcLayer->GetSpatialRef();

        if (poCT != NULL && poOutputSRS->IsGeographic())
        {
            papszTransformOptions =
                CSLAddString(papszTransformOptions, "WRAPDATELINE=YES");
        }
        else if (poSourceSRS != NULL && poOutputSRS == NULL && poSourceSRS->IsGeographic())
        {
            papszTransformOptions =
                CSLAddString(papszTransformOptions, "WRAPDATELINE=YES");
        }
        else
        {
            fprintf(stderr, "-wrapdateline option only works when reprojecting to a geographic SRS\n");
        }
    }
*/