package com.demo;

/*
CREATE TABLE Customer (
    CustomerID SERIAL PRIMARY KEY,
    FullName VARCHAR(255) NOT NULL,
    Address TEXT NOT NULL,
    IDType VARCHAR(20) CHECK (IDType IN ('SSN', 'SIN', 'Driving License')),
    IDNumber VARCHAR(50) UNIQUE NOT NULL,
    RegistrationDate DATE NOT NULL
);
 */
public class Customer {
    private Integer customerId;
    private String fullName;
    private String address;
    private String idType;
    private String idNumber;
    private String registrationDate;

    public Customer(Integer customerId, String fullName, String address, String idType, String idNumber, String registrationDate) {
        this.customerId = customerId;
        this.fullName = fullName;
        this.address = address;
        this.idType = idType;
        this.idNumber = idNumber;
        this.registrationDate = registrationDate;
    }

    public Customer(String fullName, String address, String idType, String idNumber, String registrationDate) {
        this.fullName = fullName;
        this.address = address;
        this.idType = idType;
        this.idNumber = idNumber;
        this.registrationDate = registrationDate;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
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

    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public String getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(String registrationDate) {
        this.registrationDate = registrationDate;
    }
}
