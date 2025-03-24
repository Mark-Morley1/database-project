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
}
