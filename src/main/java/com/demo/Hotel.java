package com.demo;

/*
CREATE TABLE Hotel (
    HotelID SERIAL PRIMARY KEY,
    ChainID INT NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Address TEXT NOT NULL,
    ContactEmail VARCHAR(255),
    ContactPhone VARCHAR(20),
    Category INT CHECK (Category BETWEEN 1 AND 5),
    NumberOfRooms INT DEFAULT 0,
    FOREIGN KEY (ChainID) REFERENCES HotelChain(ChainID) ON DELETE CASCADE
);
 */
public class Hotel {

    private Integer hotelID;
    private Integer chainID;
    private String name;
    private String address;
    private String contactEmail;
    private String contactPhone;
    private String area;
    private Integer rating;
    private Integer numberOfRooms;

    public Hotel(Integer hotelID, Integer chainID, String name, String address, String contactEmail, String contactPhone, String area, Integer rating, Integer numberOfRooms) {
        this.hotelID = hotelID;
        this.chainID = chainID;
        this.name = name;
        this.area = area;
        this.address = address;
        this.contactEmail = contactEmail;
        this.contactPhone = contactPhone;
        this.rating = rating;
        this.numberOfRooms = numberOfRooms;
    }

    public Hotel(Integer chainID, String name, String address, String contactEmail, String area, String contactPhone, Integer rating, Integer numberOfRooms) {
        this.chainID = chainID;
        this.name = name;
        this.area = area;
        this.address = address;
        this.contactEmail = contactEmail;
        this.contactPhone = contactPhone;
        this.rating = rating;
        this.numberOfRooms = numberOfRooms;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public void setHotelID(Integer hotelID) {
        this.hotelID = hotelID;
    }

    public void setChainID(Integer chainID) {
        this.chainID = chainID;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public void setNumberOfRooms(Integer numberOfRooms) {
        this.numberOfRooms = numberOfRooms;
    }

    public Integer getHotelID() {
        return hotelID;
    }

    public Integer getChainID() {
        return chainID;
    }

    public String getName() {
        return name;
    }

    public String getAddress() {
        return address;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public Integer getRating() {
        return rating;
    }

    public Integer getNumberOfRooms() {
        return numberOfRooms;
    }
}