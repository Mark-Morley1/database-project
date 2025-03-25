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

    private Integer archiveId;
    private Integer bookingId;
    private Integer customerId;
    private Integer roomId;
    private String startDate;
    private String endDate;
    private String status;


    public Booking(Integer archiveId, Integer bookingId, Integer customerId, Integer roomId, String startDate, String endDate, String status) {
        this.archiveId = archiveId;
        this.bookingId = bookingId;
        this.customerId = customerId;
        this.roomId = roomId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
    }

    public Booking(Integer bookingId, Integer customerId, String startDate, Integer roomId, String endDate, String status) {
        this.bookingId = bookingId;
        this.customerId = customerId;
        this.startDate = startDate;
        this.roomId = roomId;
        this.endDate = endDate;
        this.status = status;
    }

    public Integer getArchiveId() {
        return archiveId;
    }

    public void setArchiveId(Integer archiveId) {
        this.archiveId = archiveId;
    }

    public Integer getBookingId() {
        return bookingId;
    }

    public void setBookingId(Integer bookingId) {
        this.bookingId = bookingId;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }
}
