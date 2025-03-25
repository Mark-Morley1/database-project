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

    private Integer rentingID;
    private Integer customerID;
    private Integer roomID;
    private Integer employeeID;
    private String startDate;
    private String endDate;
    private String status;

    public Renting(Integer rentingID, Integer customerID, Integer roomID, Integer employeeID, String startDate, String endDate, String status) {
        this.rentingID = rentingID;
        this.customerID = customerID;
        this.roomID = roomID;
        this.employeeID = employeeID;
        this.startDate = startDate;
        this.endDate = endDate;
    }


    public Renting(Integer customerID, Integer roomID, Integer employeeID, String startDate, String endDate, String status) {
        this.customerID = customerID;
        this.roomID = roomID;
        this.employeeID = employeeID;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
    }

    public Integer getRentingID() {
        return rentingID;
    }

    public void setRentingID(Integer rentingID) {
        this.rentingID = rentingID;
    }

    public Integer getCustomerID() {
        return customerID;
    }

    public void setCustomerID(Integer customerID) {
        this.customerID = customerID;
    }

    public Integer getRoomID() {
        return roomID;
    }

    public void setRoomID(Integer roomID) {
        this.roomID = roomID;
    }

    public Integer getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(Integer employeeID) {
        this.employeeID = employeeID;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
