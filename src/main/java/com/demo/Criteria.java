package com.demo;

import java.util.Calendar;

public class Criteria {


    private Calendar startDate;
    private Calendar endDate;
    private String hotelCapaciy;
    private String hotelArea;
    private String hotelChain;
    private Integer hotelRating;
    private Integer numberOfRooms;
    private Double price;


    public Criteria(String startDate, String endDate, String hotelCapaciy, String hotelArea,
                    String hotelChain, Integer hotelRating, Integer numberOfRooms, Double price) {
        this.startDate = this.strToCal(startDate);
        this.endDate = this.strToCal(endDate);
        this.hotelCapaciy = hotelCapaciy;
        this.hotelArea = hotelArea;
        this.hotelChain = hotelChain;
        this.hotelRating = hotelRating;
        this.numberOfRooms = numberOfRooms;
        this.price = price;
    }

    public boolean meetsRequirements(Criteria criteria){

        return
                (this.hotelCapaciy.equals("") || criteria.hotelCapaciy.equals(this.hotelCapaciy)) &&
                criteria.hotelArea.contains(this.hotelArea) &&

                        criteria.hotelChain.contains(this.hotelChain) &&
                criteria.hotelRating >= this.hotelRating &&

                        criteria.numberOfRooms <= this.numberOfRooms &&
                        criteria.price >= this.price;
    }
    //converts the date in string format to calendar
    private Calendar strToCal(String date){
        Calendar temp = Calendar.getInstance();
        String[] spl= date.split("-");
        int month=Integer.parseInt(spl[0])-1; //month is 0 indexed so i -1
        int dated=Integer.parseInt(spl[1]);
        int year=Integer.parseInt(spl[2]);

        temp.set(Calendar.DATE, dated);
        temp.set(Calendar.MONTH, month);
        temp.set(Calendar.YEAR, year);
        return temp;
    }



    //gettters and setters
    public Calendar getStartDate() {
        return startDate;
    }

    /**
     * date in string
     * auto converts to Calendar object
     * @param date
     */
    public void setStartDate(String date) {
        this.startDate = strToCal(date);
    }

    public Calendar getEndDate() {
        return endDate;
    }

    /**
     * date in string
     * auto converts to Calendar object
     * @param date
     */
    public void setEndDate(String date) {
        this.endDate = strToCal(date);
    }

    public String getHotelCapaciy() {
        return hotelCapaciy;
    }

    public void setHotelCapaciy(String hotelCapaciy) {
        this.hotelCapaciy = hotelCapaciy;
    }

    public String getHotelArea() {
        return hotelArea;
    }

    public void setHotelArea(String hotelArea) {
        this.hotelArea = hotelArea;
    }

    public String getHotelChain() {
        return hotelChain;
    }

    public void setHotelChain(String hotelChain) {
        this.hotelChain = hotelChain;
    }

    public Integer getHotelRating() {
        return hotelRating;
    }

    public void setHotelRating(Integer hotelRating) {
        this.hotelRating = hotelRating;
    }

    public Integer getNumberOfRooms() {
        return numberOfRooms;
    }

    public void setNumberOfRooms(Integer numberOfRooms) {
        this.numberOfRooms = numberOfRooms;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }


    //to string method
    @Override
    public String toString() {
        return "Criteria{" +
                "startDate=" + startDate +
                ", endDate=" + endDate +
                ", hotelCapaciy=" + hotelCapaciy +
                ", hotelArea='" + hotelArea + '\'' +
                ", hotelChain='" + hotelChain + '\'' +
                ", hotelRating=" + hotelRating +
                ", numberOfRooms=" + numberOfRooms +
                ", price=" + price +
                '}';
    }

}
