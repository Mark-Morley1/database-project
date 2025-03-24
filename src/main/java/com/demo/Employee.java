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
    private String idType; //  (IDType IN ('SSN', 'SIN', 'Driving License')),
    private Integer idNumber;
    //private   date //figure out if we should do string or calendar class

}
