package com.demo;

/*
CREATE TABLE Employee (
    EmployeeID SERIAL PRIMARY KEY,
    HotelID INT NOT NULL,
    FullName VARCHAR(255) NOT NULL,
    Address TEXT NOT NULL,
    SSN_SIN VARCHAR(50) UNIQUE NOT NULL,
    Position VARCHAR(255) NOT NULL,
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID) ON DELETE CASCADE
);
 */

public class Employee {

    private Integer employeeId;
    private Integer hotelId;
    private String fullName;
    private String address;
    private String SSN; //  (IDType IN ('SSN', 'SIN', 'Driving License')),
    private String position;

    public Employee(Integer employeeId, Integer hotelId, String fullName, String address, String SSN, String position) {
        this.employeeId = employeeId;
        this.hotelId = hotelId;
        this.fullName = fullName;
        this.address = address;
        this.SSN = SSN;
        this.position = position;
    }

    public Employee(Integer hotelId, String fullName, String address, String SSN, String position) {
        this.hotelId = hotelId;
        this.fullName = fullName;
        this.address = address;
        this.SSN = SSN;
        this.position = position;
    }

    public Integer getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(Integer employeeId) {
        this.employeeId = employeeId;
    }

    public Integer getHotelId() {
        return hotelId;
    }

    public void setHotelId(Integer hotelId) {
        this.hotelId = hotelId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getSSN() {
        return SSN;
    }

    public void setSSN(String SSN) {
        this.SSN = SSN;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
}

