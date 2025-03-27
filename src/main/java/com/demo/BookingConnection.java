package com.demo;
import org.postgresql.util.PSQLException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLIntegrityConstraintViolationException;

public class BookingConnection {

    // Method to create a booking in the "booking" table.
    public boolean createBooking(Integer customerID, Integer roomID, String startdate, String enddate) {
        String status = "Booked";
        String sqlInsert = "INSERT INTO booking (bookingID, customerID, roomid, startDate, endDate, status) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlMax = "SELECT COALESCE(MAX(bookingID), 0) AS maxId FROM booking";

        ConnectionDB db = new ConnectionDB();


        try (Connection con = db.getConnection()) {
            // First, get the current maximum bookingID
            int newBookingID = 1;
            try (PreparedStatement psMax = con.prepareStatement(sqlMax);
                 ResultSet rs = psMax.executeQuery()) {
                if (rs.next()) {
                    newBookingID = rs.getInt("maxId") + 1;
                }
            }

            // Now, insert the new booking with the new bookingID
            try (PreparedStatement pstmt = con.prepareStatement(sqlInsert)) {
                pstmt.setInt(1, newBookingID);
                pstmt.setInt(2, roomID);
                pstmt.setInt(3, customerID);

                java.sql.Date sqlStartDate = java.sql.Date.valueOf(startdate); // format must be yyyy-MM-dd
                java.sql.Date sqlEndDate = java.sql.Date.valueOf(enddate);
                pstmt.setDate(4, sqlStartDate);
                pstmt.setDate(5, sqlEndDate);
                pstmt.setString(6, status);

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Booking added successfully with BookingID: " + newBookingID);
                } else {
                    System.out.println("Booking insertion failed.");
                }
            }
        } catch (Exception e) {
            //The room is already saved in booking violates the unique booking constraint
            e.printStackTrace();
            return false;
        }
        return true;
    }

}
