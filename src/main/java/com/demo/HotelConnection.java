package com.demo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class HotelConnection {
    public List<Hotel> getHotels() throws Exception {
        String sql = "SELECT * FROM public.hotel";

        ConnectionDB db = new ConnectionDB();

        List<Hotel> hotels = new ArrayList<>();
        try (Connection con = db.getConnection()) {

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {

                Hotel hotel = new Hotel(
                        rs.getInt("hotelID"),
                        rs.getInt("chainID"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("contactEmail"),
                        rs.getString("contactPhone"),
                        rs.getString("area"),
                        rs.getInt("rating"),
                        rs.getInt("numberOfRooms")
                );

                hotels.add(hotel);
            }
            rs.close();
            // close the statement
            stmt.close();
            con.close();
            db.close();

            // return the grades retrieved from database
            return hotels;
        } catch (Exception e) {
            // throw any errors occurred
            throw new Exception(e.getMessage());
        }

    }

    public HotelChain getHotelChain(int hotelChainID) throws Exception {
        ConnectionDB db = new ConnectionDB();
        String sql = "SELECT * FROM public.hotelchain WHERE chainID = ?"; // Use * to fetch all columns
        HotelChain hotelChain = null;

        try (Connection con = db.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, hotelChainID); // Set the parameter for hotelID

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) { // Ensure there's a result before reading data
                    hotelChain = new HotelChain(
                            hotelChainID,
                            rs.getString("name"),
                            rs.getString("centralofficeaddress"),
                            Integer.valueOf(rs.getString("numberofhotels")),
                            rs.getString("contactemail"),
                            rs.getString("contactphone")
                    );
                }
            }
        } catch (Exception e) {
            throw new Exception("Database error: " + e.getMessage(), e);
        }

        return hotelChain;
    }
}