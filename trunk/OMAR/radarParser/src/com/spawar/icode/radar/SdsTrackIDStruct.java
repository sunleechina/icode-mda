//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 in JDK 6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2012.07.19 at 01:24:49 PM PDT 
//


package com.spawar.icode.radar;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for SdsTrackIDStruct complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="SdsTrackIDStruct">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="kluster" type="{http://www.suretrak21.com/ST_Track}kluster_t"/>
 *         &lt;element name="port" type="{http://www.suretrak21.com/ST_Track}port_t"/>
 *         &lt;element name="platform" type="{http://www.suretrak21.com/ST_Track}platform_t"/>
 *         &lt;element name="category" type="{http://www.suretrak21.com/ST_Track}category_t"/>
 *         &lt;element name="amplification" type="{http://www.suretrak21.com/ST_Track}amplification_t"/>
 *         &lt;element name="site" type="{http://www.suretrak21.com/ST_Track}site_t"/>
 *         &lt;element name="radar" type="{http://www.suretrak21.com/ST_Track}radar_t"/>
 *         &lt;element name="trackID" type="{http://www.suretrak21.com/ST_Track}trackID_t"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SdsTrackIDStruct", propOrder = {
    "kluster",
    "port",
    "platform",
    "category",
    "amplification",
    "site",
    "radar",
    "trackID"
})
public class SdsTrackIDStruct {

    protected long kluster;
    protected long port;
    protected long platform;
    protected long category;
    protected long amplification;
    protected long site;
    protected long radar;
    protected long trackID;

    /**
     * Gets the value of the kluster property.
     * 
     */
    public long getKluster() {
        return kluster;
    }

    /**
     * Sets the value of the kluster property.
     * 
     */
    public void setKluster(long value) {
        this.kluster = value;
    }

    /**
     * Gets the value of the port property.
     * 
     */
    public long getPort() {
        return port;
    }

    /**
     * Sets the value of the port property.
     * 
     */
    public void setPort(long value) {
        this.port = value;
    }

    /**
     * Gets the value of the platform property.
     * 
     */
    public long getPlatform() {
        return platform;
    }

    /**
     * Sets the value of the platform property.
     * 
     */
    public void setPlatform(long value) {
        this.platform = value;
    }

    /**
     * Gets the value of the category property.
     * 
     */
    public long getCategory() {
        return category;
    }

    /**
     * Sets the value of the category property.
     * 
     */
    public void setCategory(long value) {
        this.category = value;
    }

    /**
     * Gets the value of the amplification property.
     * 
     */
    public long getAmplification() {
        return amplification;
    }

    /**
     * Sets the value of the amplification property.
     * 
     */
    public void setAmplification(long value) {
        this.amplification = value;
    }

    /**
     * Gets the value of the site property.
     * 
     */
    public long getSite() {
        return site;
    }

    /**
     * Sets the value of the site property.
     * 
     */
    public void setSite(long value) {
        this.site = value;
    }

    /**
     * Gets the value of the radar property.
     * 
     */
    public long getRadar() {
        return radar;
    }

    /**
     * Sets the value of the radar property.
     * 
     */
    public void setRadar(long value) {
        this.radar = value;
    }

    /**
     * Gets the value of the trackID property.
     * 
     */
    public long getTrackID() {
        return trackID;
    }

    /**
     * Sets the value of the trackID property.
     * 
     */
    public void setTrackID(long value) {
        this.trackID = value;
    }

}