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
 * <p>Java class for vector_t3 complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="vector_t3">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="heading" type="{http://www.suretrak21.com/ST_Track}heading_t"/>
 *         &lt;element name="speed" type="{http://www.w3.org/2001/XMLSchema}float"/>
 *         &lt;element name="climb" type="{http://www.w3.org/2001/XMLSchema}float"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "vector_t3", propOrder = {
    "heading",
    "speed",
    "climb"
})
public class VectorT3 {

    protected double heading;
    protected float speed;
    protected float climb;

    /**
     * Gets the value of the heading property.
     * 
     */
    public double getHeading() {
        return heading;
    }

    /**
     * Sets the value of the heading property.
     * 
     */
    public void setHeading(double value) {
        this.heading = value;
    }

    /**
     * Gets the value of the speed property.
     * 
     */
    public float getSpeed() {
        return speed;
    }

    /**
     * Sets the value of the speed property.
     * 
     */
    public void setSpeed(float value) {
        this.speed = value;
    }

    /**
     * Gets the value of the climb property.
     * 
     */
    public float getClimb() {
        return climb;
    }

    /**
     * Sets the value of the climb property.
     * 
     */
    public void setClimb(float value) {
        this.climb = value;
    }

}