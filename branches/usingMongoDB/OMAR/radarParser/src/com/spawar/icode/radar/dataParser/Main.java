/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.spawar.icode.radar.dataParser;

import com.spawar.icode.radar.MultiXMLDocReader;
import com.spawar.icode.radar.STTrackAirT;
import com.spawar.icode.radar.STTrackAirT;
import com.spawar.icode.radar.STTrackSurfT;
import com.spawar.icode.radar.STTrackSurfT;
import com.spawar.icode.radar.TrackAirT;
import com.spawar.icode.radar.TrackSurfT;
import java.io.*;
import javax.xml.bind.*;
import java.io.InputStream;
import java.util.ListIterator;
import java.util.Vector;
import org.xml.sax.InputSource;

/**
 * MAIN application to test and run library functions. Can be used as an example
 * on how to use lib funtions
 *
 * @author cysneros
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {

        //Parse Sample XML into objects

        try {

            String xmlFile = "./sample/airTrack_1.xml";
            String xmlFile2 = "./sample/surfTrack_1.xml";
            String xmlFile3 = "./sample/ST_Track.xml";

            //UnMarshall the XML file
            JAXBContext jaxbContext = JAXBContext.newInstance(STTrackAirT.class, STTrackSurfT.class);
            Unmarshaller unmarshaller = jaxbContext.createUnmarshaller();
            //unmarshaller.setEventHandler(new XmlValidationEventHandler());
            FileReader fileReader = new FileReader(xmlFile);
            Object object = unmarshaller.unmarshal(fileReader);
            //JAXBElement<OpIntelType> opIntel = (JAXBElement<OpIntelType>) object;
            //OpIntelType myOp = (OpIntelType) object;
            System.out.println("Done Parsing Air Track");

            STTrackAirT myAir = (STTrackAirT) object;



            //Parse Surf Track
            fileReader = new FileReader(xmlFile2);
            object = unmarshaller.unmarshal(fileReader);
            System.out.println("Done Parsing Surf Track");
            STTrackSurfT mySurf = (STTrackSurfT) object;

            //Parse Entire Sample
            File inputFile = new File(xmlFile3);
            java.io.InputStream inStream = new java.io.FileInputStream(inputFile);
            MultiXMLDocReader xmlReader = new MultiXMLDocReader(new InputStreamReader(inStream));
            int count = 0;
            while (!xmlReader.isEOF()) {
                object = unmarshaller.unmarshal(xmlReader);
                count++;
            }
            //System.out.println("Done Parsing Complete Sample doc: " + count);


            //Use RadarXMLParser calls
            Vector<Object> vector = RadarXMLParser.read(xmlFile3);
            System.out.println("Vec Size: " + vector.size());

            /*
             * Get a ListIterator object for Vector using listIterator() method.
             */
            ListIterator itr = vector.listIterator();
            while (itr.hasNext()) {
                Object obj = itr.next();
                if (obj instanceof STTrackAirT) {
                    STTrackAirT air = (STTrackAirT) obj;

                } 
                else if (obj instanceof STTrackSurfT) {

                    STTrackSurfT air = (STTrackSurfT) obj;

                } 
                else {
                    System.out.println("Don't know what type of Object this element is");
                }
            }//while
            
            //////////////////////////
            //Parse Input Stream 
            //////////////////////////
            File inputFile2 = new File(xmlFile3);
            java.io.InputStream inStream2 = new java.io.FileInputStream(inputFile2);
              //Use RadarXMLParser calls
            Vector<Object> vector2 = RadarXMLParser.read(inStream2);
            System.out.println("Vec2 Size: " + vector2.size());




        } catch (JAXBException ex1) {
            System.out.println("ERROR(1): Problem Parsing XML file.");
            System.out.println(ex1.getMessage());
            return;
        } catch (IOException ex2) {
            System.out.println("ERROR(2): Problem Parsing XML file.");
            System.out.println(ex2.getMessage());
            return;
        } catch (Exception ex3) {
            System.out.println("ERROR(3): Problem Parsing XML file.");
            System.out.println(ex3.getMessage());
            return;
        }

        System.out.println("File Parsed Successfully!");

    }

    public class XmlValidationEventHandler implements ValidationEventHandler {

        public boolean handleEvent(ValidationEvent ve) {


            if (ve.getSeverity() == ValidationEvent.FATAL_ERROR
                    || ve.getSeverity() == ValidationEvent.ERROR) {
                ValidationEventLocator locator = ve.getLocator();

                //Print message from valdation event
                System.out.println("Invalid OpIntel document: "
                        + locator.getURL());

                System.out.println("Error: " + ve.getMessage());

                //Output line and column number
                System.out.println("Error at column "
                        + locator.getColumnNumber()
                        + ", line "
                        + locator.getLineNumber());
            }
            return true;
        }
    }
}
