package com.demo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomConnection {
    public List<Room> getRooms() throws Exception {
        String sql = "SELECT * FROM public.room";

        ConnectionDB db = new ConnectionDB();

        List<Room> rooms = new ArrayList<>();
        try (Connection con = db.getConnection()) {
            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {

                Room room = new Room(
                        rs.getInt("hotelID"),
                        rs.getDouble("price"),
                        rs.getString("capacity"),
                        rs.getString("view"),
                        rs.getBoolean("extendable"),
                        rs.getString("amenities"),
                        rs.getString("damageDescription")
                );

                rooms.add(room);
            }
            rs.close();
            // close the statement
            stmt.close();
            con.close();
            db.close();

            // return the grades retrieved from database
            return rooms;
        } catch (Exception e) {
            // throw any errors occurred
            throw new Exception(e.getMessage());
        }

    }

    public Hotel getHotel(int hotelID) throws Exception {
        ConnectionDB db = new ConnectionDB();
        String sql = "SELECT * FROM public.hotel WHERE hotelID = ?"; // Use * to fetch all columns
        Hotel hotel = null;

        try (Connection con = db.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, hotelID); // Set the parameter for hotelID

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) { // Ensure there's a result before reading data
                    hotel = new Hotel(
                            rs.getInt( "chainID"),
                            rs.getString("name"),
                            rs.getString("address"),
                            rs.getString("contactemail"),
                            rs.getString("area"),
                            rs.getString("contactphone"),

                            rs.getInt("numberofrooms"),
                            rs.getInt("rating")
                    );
                }
            }
        } catch (Exception e) {
            throw new Exception("Database error: " + e.getMessage(), e);
        }

        return hotel;
    }

}