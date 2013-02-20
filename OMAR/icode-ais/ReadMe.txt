ICODE-AIS Installation

Currently this plugin does not run on OMAR.  Use the geodata-test Grails application, which is located at the Same level as the OMAR grails applications, to run it.


1) Download the AIS plugin from:  "https://icode-mda.googlecode.com/svn/trunk/OMAR/icode-ais"

2) Check the BuildConfig.groovy file.  In the geodata-test application, edit the ./grails-app/conf/BuildConfig.groovy so it points to the AIS plugin.  Should be a line similar to:

grails.plugin.location.icodeAis = "${System.env['HOME']}/projects/icode-ais"


3) Check the BootStrap.groovy file.  Should look similiar to the following:
----------------------------------------------------------------------------------------
import geodata.City
import geodata.CityData
import gov.spawar.icode.Ais
import gov.spawar.icode.DataLoader

class BootStrap
{
  def sessionFactory

  def init = { servletContext ->
    if ( City.count() == 0 )
    {
      CityData.load()
    }

      if (Ais.count() == 0)
      {
          def aisDataLoader = new DataLoader(sessionFactory: sessionFactory)

          aisDataLoader.loadAllData();
      }

  }

  def destroy = {
  }
}
------------------------------------------------------------------------------------------------

4) Install JAI. Add all JAI jars ( jai.zip ) to applications ./lib directory


5) Set up the database.  From the geodata-test root directory, run "./setupdb.sh"


6) From the geodata-test application, Run:  grails run-app

7) Go to http://localhost:8080/geodata-test/ais/map