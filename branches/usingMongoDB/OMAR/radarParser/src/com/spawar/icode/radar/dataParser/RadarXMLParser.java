/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.spawar.icode.radar.dataParser;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.util.Vector;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;


import com.spawar.icode.radar.STTrackAirT;
import com.spawar.icode.radar.STTrackAirT;
import com.spawar.icode.radar.STTrackSurfT;
import com.spawar.icode.radar.STTrackSurfT;
import com.spawar.icode.radar.TrackAirT;
import com.spawar.icode.radar.TrackSurfT;
import java.io.InputStream;

/**
 *
 * @author cysneros
 */
public class RadarXMLParser {

    /**
     * Reads Radar Data XML file and returns a vector of Objects (STTrackAirT or STTrackSurfT)
     *
     * @param fileName
     * @return Vector of objects. Object types will be either STTrackAirT or
     * STTrackSurfT
     */
    public static Vector<Object> read(String fileName) throws FileNotFoundException, JAXBException {

        Vector<Object> vector = new Vector<Object>();

        //UnMarshall the XML file
        JAXBContext jaxbContext = JAXBContext.newInstance(STTrackAirT.class, STTrackSurfT.class);
        Unmarshaller unmarshaller = jaxbContext.createUnmarshaller();


        //Parse Entire Sample

        File inputFile = new File(fileName);
        java.io.InputStream inStream = new java.io.FileInputStream(inputFile);
        com.spawar.icode.radar.MultiXMLDocReader xmlReader = new com.spawar.icode.radar.MultiXMLDocReader(new InputStreamReader(inStream));
        int count = 0;
        Object object;
        while (!xmlReader.isEOF()) {
            object = unmarshaller.unmarshal(xmlReader);
            vector.add(object);
            count++;
        }

        vector.trimToSize();
        return vector;
    }//read
    
    
    
    public static Vector<Object> read(InputStream ioStream) throws FileNotFoundException, JAXBException {

        Vector<Object> vector = new Vector<Object>();

        //UnMarshall the XML file
        JAXBContext jaxbContext = JAXBContext.newInstance(STTrackAirT.class, STTrackSurfT.class);
        Unmarshaller unmarshaller = jaxbContext.createUnmarshaller();


        //Parse Entire Sample

       //File inputFile = new File(fileName);
       // java.io.InputStream inStream = new java.io.FileInputStream(ioStream);
        com.spawar.icode.radar.MultiXMLDocReader xmlReader = new com.spawar.icode.radar.MultiXMLDocReader(new InputStreamReader(ioStream));
        int count = 0;
        Object object;
        while (!xmlReader.isEOF()) {
            object = unmarshaller.unmarshal(xmlReader);
            vector.add(object);
            count++;
        }

        vector.trimToSize();
        return vector;
    }//read
}
