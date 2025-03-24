package com.demo;
/*
CREATE TABLE Renting (
    RentingID SERIAL PRIMARY KEY,
    CustomerID INT NOT NULL,
    RoomID INT NOT NULL,
    EmployeeID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Status VARCHAR(20) CHECK (Status IN ('Active', 'Completed')) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);
 */

public class Renting {



}
