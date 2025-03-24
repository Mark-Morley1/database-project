package com.demo;

public class Room {

    private Integer roomId;
    private Integer hotelID;
    private Double price;
    private Integer capacity;
    private String view;
    private Boolean extendable;
    private String amenities;
    private String damageDescription;

    public Room(Integer primaryKey, Integer hotelID, Double price, Integer capacity, Boolean extendable, String view, String amenities, String damageDescription) {
        this.roomId = primaryKey;
        this.hotelID = hotelID;
        this.price = price;
        this.capacity = capacity;
        this.extendable = extendable;
        this.view = view;
        this.amenities = amenities;
        this.damageDescription = damageDescription;
    }

    public Room(Integer hotelID, Double price, Integer capacity, String view, Boolean extendable, String amenities, String damageDescription) {
        this.hotelID = hotelID;
        this.price = price;
        this.capacity = capacity;
        this.view = view;
        this.extendable = extendable;
        this.amenities = amenities;
        this.damageDescription = damageDescription;
    }

    public Integer getPrimaryKey() {
        return roomId;
    }

    public Integer getHotelID() {
        return hotelID;
    }

    public Integer getCapacity() {
        return capacity;
    }

    public Double getPrice() {
        return price;
    }

    public String getView() {
        return view;
    }

    public String getAmenities() {
        return amenities;
    }

    public Boolean getExtendable() {
        return extendable;
    }

    public String getDamageDescription() {
        return damageDescription;
    }

    public void setPrimaryKey(Integer primaryKey) {
        this.roomId = primaryKey;
    }

    public void setHotelID(Integer hotelID) {
        this.hotelID = hotelID;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }

    public void setView(String view) {
        this.view = view;
    }

    public void setExtendable(Boolean extendable) {
        this.extendable = extendable;
    }

    public void setAmenities(String amenities) {
        this.amenities = amenities;
    }

    public void setDamageDescription(String damageDescription) {
        this.damageDescription = damageDescription;
    }
}
