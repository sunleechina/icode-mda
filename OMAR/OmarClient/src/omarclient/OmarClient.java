/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package omarclient;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.core.util.MultivaluedMapImpl;
import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;
import javax.ws.rs.core.MultivaluedMap;

/**
 *
 * @author Nelson
 */
public class OmarClient {

    Client jerseyClient=null;
    WebResource webResource=null;
    String m_omarURL;
    String m_imageID;
    String m_sConfigFile;

    OmarClient() {
        jerseyClient = Client.create();
        jerseyClient.setConnectTimeout(300 * 1000); //Timeout after 5 min
        jerseyClient.setReadTimeout(300 * 1000); //Timeout after 5 min
        m_omarURL = "http://omar.ossim.org/omar/ogc";
        m_imageID = "c1b89b0005e2cd183fe7ddba07c5db11491d58c67d020830285223465be3b543";
    }
    
    OmarClient(String serverURL){
        this();
        
        m_omarURL = serverURL;
        setServerURL(m_omarURL);
    }
    
    void loadConfigFile(String configFileUrl){
        
         // Get and Load Configuration file
        m_sConfigFile = configFileUrl;
        try {

            Configuration.loadConfigFile(m_sConfigFile);
        } catch (IOException ex1) {
            System.out.print(ex1.getMessage() + "\n");
            System.out.print("GdsDriver::Problem loading Configuration file: "
                    + m_sConfigFile + "\n");
            System.exit(1);
        }

        // Load all constant configuration data
        loadConfigurationData();
        
    }

    void setServerURL(String strURL) {
        m_omarURL = strURL;
        try {
            webResource = jerseyClient.resource(new URI(m_omarURL));
        } catch (URISyntaxException e) {
            System.out.println("GDSClient:DMAP Search:  Problem with URL: " + m_omarURL);
            m_omarURL = null;
            return;
        }
    }

    void setImageID(String strImgID) {
        m_imageID = strImgID;
    }
    
    String getWmsURL(String imageID) {
        String wmsURL = null;

        MultivaluedMap<String, String> params = new MultivaluedMapImpl();

        if (webResource == null) {
            System.out.println("ERROR: Server URL not set");
            return null;
        }

        //Set Service Parameters
        params.add("request", "GetMap");
        params.add("layers", imageID);

        wmsURL = webResource.path("wms").queryParams(params).toString();
        return wmsURL;
    }

    /**
     * *******************************
     * Returns InputStream of KML file
     *
     * @param imageID of image
     * @return InputStream of KML
     */
    InputStream getKML(String imageID) {
        InputStream inputStream = null;
        MultivaluedMap<String, String> params = new MultivaluedMapImpl();
        
        if(webResource==null){
            System.out.println("ERROR: Server URL not set");
            return null;
        }

        //Set Service Parameters
        params.add("request", "GetKML");
        params.add("layers", imageID);
        params.add("format", "image/png");
        params.add("transparent", "true");

        inputStream = (InputStream) webResource.path("wms").queryParams(params).get(InputStream.class);

        return inputStream;
    }
    
    

    /**
     * Write KML of image to given file
     * 
     * @param imageID
     * @param outputFile 
     */
    void writeKML(String imageID, File outputFile) {
        InputStream inputStream = null;
        MultivaluedMap<String, String> params = new MultivaluedMapImpl();
        
        if(webResource==null){
            System.out.println("ERROR: Server URL not set");
            return;
        }

        //Set Service Parameters
        params.add("request", "GetKML");
        params.add("layers", imageID);
        params.add("format", "image/png");
        params.add("transparent", "true");

        inputStream = (InputStream) webResource.path("wms").queryParams(params).get(InputStream.class);

        // write the inputStream to a FileOutputStream
        try {
            OutputStream out = new FileOutputStream(outputFile);

            int read = 0;
            byte[] bytes = new byte[1024];

            while ((read = inputStream.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }

            inputStream.close();
            out.flush();
            out.close();

        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }
    
    
      /**
     * Load all non-modifiable configuration data from Properties list into class
     */
        /**
     * Load all non-modifiable configuration data from Properties list into class
     */
    public void loadConfigurationData() {

        //////////
        // Log4j
        ///////////
        /************************************
        try {
            m_sLog4jUrl = Configuration.getAsString(ConfigConstants.sLog4jProps);

            if (m_sLog4jUrl.endsWith("xml")) {
                DOMConfigurator.configure(m_sLog4jUrl);
                // logger.info("Log4j DOMConfigurator used: " + m_sLog4jUrl);
            } else {
                PropertyConfigurator.configure(m_sLog4jUrl);
                // logger.info("Log4j PropertyConfigurator used: " +
                // m_sLog4jUrl);
            }

            // logger.info("log4j logger is active.");
        } catch (Exception ex1) {

            logger.info(ex1.getMessage());
            logger.fatal("loadConstantConfigurationData::Problem loading Log4j Properties: "
                    + ConfigConstants.sLog4jProps);
            System.exit(1);
        }
        ****************************************************************/
        
        ///////////////////////////
        // Omar Server URL
        ///////////////////////////
        try {

            m_omarURL = Configuration.getAsString(ConfigConstants.sOmarServerURL);
            setServerURL(m_omarURL);

        } catch (Exception ex1) {

            System.out.println(ex1.getMessage());
            System.out.println("loadConstantConfigurationData::Problem loading Server URL: "
                    + ConfigConstants.sOmarServerURL);
            System.exit(1);
        }


    }// loadConfigurationData


    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        OmarClient client = new OmarClient("http://omar.ossim.org/omar/ogc");
        String wmsURL = client.getWmsURL("5");
        
    }
}
