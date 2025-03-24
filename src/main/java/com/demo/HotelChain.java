package com.demo;

/*
CREATE TABLE HotelChain (
    ChainID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    CentralOfficeAddress TEXT NOT NULL,
    NumberOfHotels INT DEFAULT 0,
    ContactEmail VARCHAR(255),
    ContactPhone VARCHAR(20)
);
 */

public class HotelChain {

    private Integer chainID;
    private String name;
    private String centralOfficeAddress;
    private Integer numberOfHotels;
    private String contactEmail;
    private String contactPhone;

    public HotelChain(Integer chainID, String name, String centralOfficeAddress, Integer numberOfHotels, String contactEmail, String contactPhone) {
        this.chainID = chainID;
        this.name = name;
        this.centralOfficeAddress = centralOfficeAddress;
        this.numberOfHotels = numberOfHotels;
        this.contactEmail = contactEmail;
        this.contactPhone = contactPhone;
    }

    public HotelChain(String name, String centralOfficeAddress, Integer numberOfHotels, String contactPhone, String contactEmail) {
        this.name = name;
        this.centralOfficeAddress = centralOfficeAddress;
        this.numberOfHotels = numberOfHotels;
        this.contactPhone = contactPhone;
        this.contactEmail = contactEmail;
    }

    public Integer getChainID() {
        return chainID;
    }

    public String getName() {
        return name;
    }

    public String getCentralOfficeAddress() {
        return centralOfficeAddress;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public Integer getNumberOfHotels() {
        return numberOfHotels;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setChainID(Integer chainID) {
        this.chainID = chainID;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCentralOfficeAddress(String centralOfficeAddress) {
        this.centralOfficeAddress = centralOfficeAddress;
    }

    public void setNumberOfHotels(Integer numberOfHotels) {
        this.numberOfHotels = numberOfHotels;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }
}
