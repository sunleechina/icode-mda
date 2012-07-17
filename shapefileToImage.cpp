#include <iostream>
#include <cassert>
#include <string>

#include "shoreLineRate.h"

using namespace std;



int main(int argc,char*  argv[])
{
	ossimTimer::instance()->setStartTick();
	ossimInit::instance()->initialize(argc, argv);

	if (argc != 3)
	{
		cout <<"\t"<< argv[0]
			<<"\n Usage\n"
			<< argv[0]<< "<shoreline1.shp> <shoreline2.shp>"
			<<"\nDescription"
			<<"\nwrites a shape file and shapePoints to \n"
			<< endl;
				return 1;
	}

	ossimFilename inputShpName1 = ossimFilename(argv[1]);
	ossimFilename inputShpName2 = ossimFilename(argv[2]);
	ShoreLineComparer clc;

	clc.loadShoreLine(inputShpName1,inputShpName2,false);
	
	clc.getBaseLine(inputShpName1,AUTO_BASELINE,2);
	clc.setTransectLines();



	
	ossimFilename outputFile  = inputShpName1.fileNoExtension().string() +"_"+ inputShpName2.fileNoExtension().string();
	//outputFile = outputFile.dirCat(inputShpName1.fileNoExtension());
	outputFile += "_output.tiff";

	cout<< "OSSIM Shoreline erosion rate estimator:"
		<< "\n <shapefile 1> "<< inputShpName1
		<< "\n <shapefile 2> "<< inputShpName2
		<< "\n Output File:  "<< outputFile
		<< endl;

	ossimRefPtr<ossimImageHandler> inputShp1 = ossimImageHandlerRegistry::instance()->open(inputShpName1);

	ossimRefPtr<ossimImageHandler> inputShp2 = ossimImageHandlerRegistry::instance()->open(inputShpName2);

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

				ossimRefPtr<ossimImageFileWriter> writer =
				ossimImageWriterFactoryRegistry::instance()->createWriterFromExtension(outputFile.ext());

				if ( writer->open( outputFile ) )
				{
					// Add a listener to get percent complete.
					ossimStdOutProgress prog(0, true);
					writer->addListener(&prog);

					writer->connectMyInputTo(0, inputShp1.get());

					//cout << inputShp->getBoundingRect() << endl;
					cout <<endl<< "     writing shapefile"<<endl;
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
			cerr << "2nd argument must also be a shape file." << endl;
		}
	}
	else
	{
		cerr <<"Either "<< inputShpName1<<" or "<<inputShpName2<<" is not not valid"<< endl;
	}
	return 0;
}