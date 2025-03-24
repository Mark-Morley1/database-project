package com.demo;
/*
CREATE TABLE BookingArchive (
    ArchiveID SERIAL PRIMARY KEY,
    BookingID INT,
    CustomerID INT,
    RoomID INT,
    StartDate DATE,
    EndDate DATE,
    Status VARCHAR(20) CHECK (Status IN ('Booked', 'Cancelled', 'Completed')),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) ON DELETE SET NULL
);
 */

public class Booking {

}
