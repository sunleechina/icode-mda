/*
 * OMAR Stager.  
 * 
 * Does all processing necessary to get images into OMAR.
 * 
 * OSSIM exe must be in your path
 * 
 */
package omarstager;

import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.core.util.MultivaluedMapImpl;
import gnu.getopt.Getopt;
import gnu.getopt.LongOpt;
import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;
import javax.ws.rs.core.MultivaluedMap;

/**
 *
 * @author dib
 */
public class OmarStager {

    public static final int ID = 1;
    public static final int IMAGE = 2;
    public static final int FILENAME = 3;
    public static final boolean DEBUG = false;
    List<String> m_listSupportedExtensions;
    Connection connection = null;
    Client jerseyClient = null;
    WebResource webResource = null;
    static String dbHost = "127.0.0.1";
    static String dbName = "omardb-1.8.14-prod";
    static String dbUser = "postgres";
    static String dbPW = "postgres";
    String omarHost = "localhost";
    String omarPort = "8082";
    boolean ssh = false;

    OmarStager() {

        //Add Supported extensions
        m_listSupportedExtensions = new ArrayList<String>();
        m_listSupportedExtensions.add(".nitf");
        m_listSupportedExtensions.add(".ntf");
        m_listSupportedExtensions.add(".tif");

        //Setup Restful client
        jerseyClient = Client.create();
        jerseyClient.setConnectTimeout(300 * 1000); //Timeout after 5 min
        jerseyClient.setReadTimeout(300 * 1000); //Timeout after 5 min

    }

    public void setSSH(boolean newBoo) {
        ssh = newBoo;
    }

    public void setOmarPort(String newPort) {
        omarPort = newPort;
    }

    public void setOmarHost(String newHost) {
        omarHost = newHost;
    }

    public void addSupportedExtension(String newExt) {
        m_listSupportedExtensions.add(newExt);
    }

    public void setDBHost(String newHost) {
        dbHost = newHost;
    }

    public void setDBName(String newName) {
        dbName = newName;
    }

    public void setDBUser(String newUser) {
        dbUser = newUser;
    }

    public void setDBPassWord(String newPW) {
        dbPW = newPW;
    }

    /**
     * Returns FIle Name without Extension or Path
     *
     * @param path
     * @return
     */
    public static String getFileName(String path) {

        String fileName = null;
        String separator = File.separator;

        int pos = path.lastIndexOf(separator);
        int pos2 = path.lastIndexOf(".");

        if (pos2 > -1) {
            fileName = path.substring(pos + 1, pos2);
        } else {
            fileName = path.substring(pos + 1);
        }

        return fileName;
    }

    /**
     * Returns FIle Extension
     *
     * @param path
     * @return
     */
    public static String getFileExt(String path) {

        String fileName = null;
        String separator = File.separator;

        int pos = path.lastIndexOf(separator);
        int pos2 = path.lastIndexOf(".");

        if (pos2 > -1) {
            fileName = path.substring(pos2);
        } else {
            fileName = "";
        }

        return fileName;
    }

    /**
     * Returns FIle Name and Path without Extension
     *
     * @param path
     * @return
     */
    public static String getFileRoot(String path) {

        String fileName = null;
        String separator = File.separator;

        int pos = path.lastIndexOf(separator);
        int pos2 = path.lastIndexOf(".");

        if (pos2 > -1) {
            fileName = path.substring(0, pos2);
        } else {
            fileName = path;
        }

        return fileName;
    }

    /**
     * Returns FIle Path only
     *
     * @param path
     * @return
     */
    public static String getFilePath(String path) {

        String fileName = null;
        String separator = File.separator;

        int pos = path.lastIndexOf(separator);

        fileName = path.substring(0, pos);

        return fileName;
    }

    /**
     * Check to see if the the ImageID and Raster Entry is null. If it is, it
     * will use the File name as the Image ID.
     */
    public void updateImageID() {

        Statement stmt;
        PreparedStatement pst = null;
        String query = "Select id, image_id, filename FROM raster_entry WHERE image_id IS NULL";

        if (DEBUG) {
            System.out.println("-------- PostgreSQL " + "JDBC Connection Testing ------------");
        }

        try {

            Class.forName("org.postgresql.Driver");

        } catch (ClassNotFoundException e) {

            System.out.println("Where is your PostgreSQL JDBC Driver? "
                    + "Include in your library path!");
            e.printStackTrace();
            return;

        }

        if (DEBUG) {
            System.out.println("PostgreSQL JDBC Driver Registered!");
        }


        try {

            connection = DriverManager.getConnection("jdbc:postgresql://" + dbHost + ":5432/" + dbName, dbUser, dbPW);

        } catch (SQLException e) {

            System.out.println("Connection Failed! Check output console");
            e.printStackTrace();
            return;

        }

        if (connection != null) {
            try {

                stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(query);
                ResultSetMetaData rsmd = rs.getMetaData();
                int numberOfColumns = rsmd.getColumnCount();
                int rowCount = 1;
                while (rs.next()) {

                    if (DEBUG) {
                        System.out.println("Row " + rowCount + ":");
                        for (int i = 1; i <= numberOfColumns; i++) {
                            System.out.print("   Col " + i
                                    + ":  ");
                            System.out.println(rs.getString(i));
                        }
                        System.out.println("");
                        rowCount++;
                    }

                    //Print out all File Names:
                    String id = rs.getString(ID);
                    String fileName = getFileName(rs.getString(FILENAME));

                    String updateID = "UPDATE raster_entry SET image_id = '" + fileName + "' WHERE id = " + id;

                    if (DEBUG) {
                        System.out.println(updateID);
                    }

                    pst = connection.prepareStatement(updateID);
                    pst.executeUpdate();




                }
                stmt.close();
                connection.close();


            } catch (SQLException ex) {
                System.err.print("SQLException: ");
                System.err.println(ex.getMessage());
            }


        } else {
            System.out.println("Failed to make connection!");
        }


    }

    /**
     * Builds the OVR and HIS files needed by OMAR
     *
     * @param file
     */
    public void buildOvrsAndHis(File file) {

        if (DEBUG) {
            System.out.println("Building OVR/HIS file for: " + file.getAbsolutePath());
        }

        String hisFlag = "--create-histogram";

        String root = getFileRoot(file.getAbsolutePath());

        //Check if hist file exists
        File hisFile = new File(root + ".his");
        File hisFile2 = new File(root + "_e0.his");
        File hisFile3 = new File(root + "_e1.his");

        if (hisFile.exists() || hisFile2.exists() || hisFile3.exists()) {
            hisFlag = "";
        }

        String cmd = "ossim-img2rr " + hisFlag + " " + file.getAbsolutePath();

        if (DEBUG) {
            System.out.println("CMD : " + cmd);
        }

        try {

            Process p = Runtime.getRuntime().exec(cmd);
            p.waitFor();
        } catch (IOException e) {
            System.out.println("exception happened - Is ossim-img2rr in your path? : ");
            e.printStackTrace();
        } catch (InterruptedException e) {
            System.out.println("exception happened - Is ossim-img2rr in your path? : ");
            e.printStackTrace();
        }


    }

    /**
     * ***********************************************
     * Adds the image file into OMAR DB raster entery
     *
     * @param file ***********************************************
     */
    public void addRaster(File file) {

        String omarURL = "";
        if (ssh) {
            omarURL = "https://" + omarHost + ":" + omarPort + "/omar/dataManager/addRaster";
        } else {
            omarURL = "http://" + omarHost + ":" + omarPort + "/omar/dataManager/addRaster";
        }


        String queryString = "filename=" + file.getAbsolutePath();
        MultivaluedMap<String, String> params = new MultivaluedMapImpl();

        if (DEBUG) {
            System.out.println("Adding to Raster: " + file.getAbsolutePath());
            System.out.println("Omar URL: " + omarURL);
        }

        try {
            webResource = jerseyClient.resource(new URI(omarURL));
        } catch (URISyntaxException e) {
            System.out.println("GDSClient:DMAP Search:  Problem with URL: " + omarURL);
            return;
        }

        //Add parameters
        params.add("filename", file.getAbsolutePath());

        //Send restful POST request.  Don't worry about response. 
        ClientResponse response;
        try {
            response = webResource.type("application/x-www-form-urlencoded").post(ClientResponse.class, params);
            //response = webResource.queryParams(params).type("text/plain").put(ClientResponse.class,queryString);
            //ClientResponse response = webResourceraster_entry_file, "foo:bar");
        } catch (Exception ex) {
            System.err.println("ERROR:AddRaster" + ex.getMessage());
        }

    }

    /**
     * ********************************************
     * Main
     *
     * @param argv *********************************************
     */
    public static void main(String[] argv) {

        OmarStager stager = new OmarStager();

        ///////////////////////////////////
        //Handle Command Line Arguments
        ///////////////////////////////////
        int c;
        String arg;
        LongOpt[] longopts = new LongOpt[8];
        StringBuffer sb = new StringBuffer();

        longopts[0] = new LongOpt("help", LongOpt.NO_ARGUMENT, null, 'h');
        longopts[1] = new LongOpt("s", LongOpt.NO_ARGUMENT, null, 's');
        longopts[2] = new LongOpt("dbhost", LongOpt.REQUIRED_ARGUMENT, sb, 1);
        longopts[3] = new LongOpt("dbname", LongOpt.REQUIRED_ARGUMENT, sb, 2);
        longopts[4] = new LongOpt("dbpw", LongOpt.REQUIRED_ARGUMENT, sb, 3);
        longopts[5] = new LongOpt("dbuser", LongOpt.REQUIRED_ARGUMENT, sb, 4);
        longopts[6] = new LongOpt("omarhost", LongOpt.REQUIRED_ARGUMENT, sb, 5);
        longopts[7] = new LongOpt("omarport", LongOpt.REQUIRED_ARGUMENT, sb, 6);
        // 
        Getopt g = new Getopt("OmarStager", argv, "", longopts);
        g.setOpterr(false); // We'll do our own error handling
        //
        while ((c = g.getopt()) != -1) {
            switch (c) {

                case 0:
                    arg = g.getOptarg();
                    int l = new Integer(sb.toString());
                    switch (l) {
                        case 1:
                            //System.out.println("DBHost Name " + arg);
                            stager.setDBHost(arg);
                            break;
                        //
                        case 2:
                            //System.out.println("DB NAME " + arg);
                            stager.setDBName(arg);
                            break;
                        //
                        case 3:
                            //System.out.println("DB PW " + arg);
                            stager.setDBPassWord(arg);
                            break;
                        //
                        case 4:
                            //System.out.println("DB User " + arg);
                            stager.setDBUser(arg);
                            break;
                        //
                        case 5:
                            //System.out.println("Omar Host " + arg);
                            stager.setOmarHost(arg);
                            break;
                        //
                        case 6:
                            //System.out.println("Omr Host " + arg);
                            stager.setOmarPort(arg);
                            break;

                    }
                    break;


                //
                case '?':
                case 'h':
                    System.out.println("OmarStager Usage:\n");
                    System.out.println("\t[");
                    System.out.println("\t--h: help menu");
                    System.out.println("\t--s: Turn on SSH (Default: off)");
                    System.out.println("\t--dbhost: Database Server Name or IP (Default: localhost)");
                    System.out.println("\t--dbname: Database Name (Default: omardb-1.8.14-prod)");
                    System.out.println("\t--dbpw: Password to access Database (Default: postgres)");
                    System.out.println("\t--dbuser: Database User (Default: postgres)");
                    System.out.println("\t--omarhost: Omar Host Name or IP address (Default: localhost)");
                    System.out.println("\t--omarport: Omar port (Default: 8082)");
                    System.out.println("\t] dir <dir2 dir3>");
                    System.exit(0);
                    break;
                //
                case 's':
                    //System.out.println("SSH ON");
                    stager.setSSH(true);
                    break;

                default:
                    break;
            }
        }
      

        /////////////////////////////////////////////////////////////////////
        //Go thru each directory given to find image files
        //////////////////////////////////////////////////////////////////////
        File baseDir;
        System.out.println("Stager Started...");

        //Look through all directories passed in for files
        for (int index = g.getOptind(); index < argv.length; index++) {

            String dir = argv[index];
            baseDir = new File(dir);
            if (baseDir.exists() && baseDir.isDirectory()) {
                String[] children = baseDir.list();
                for (int i = 0; i < children.length; i++) {

                    File file = new File(dir, children[i]);
                    String ext = getFileExt(file.getName());

                    //Check if this file is supported 
                    if (!stager.m_listSupportedExtensions.contains(ext)) {
                        continue;
                    }

                    ////////////////////////////////////
                    //Build OVRS and HIS for each file
                    ////////////////////////////////////
                    stager.buildOvrsAndHis(file);

                    ////////////////////////////////////
                    //Add File to OMAR Raster Entry
                    ////////////////////////////////////
                    stager.addRaster(file);


                }

            }

        }

        //////////////////////////////
        // Update Image IDs
        //////////////////////////////
        stager.updateImageID();

        System.out.println("Stager Completed.");
    }
}
