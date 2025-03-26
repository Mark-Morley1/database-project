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

                /*
                this.hotelID = hotelID;
        this.price = price;
        this.capacity = capacity;
        this.view = view;
        this.extendable = extendable;
        this.amenities = amenities;
        this.damageDescription = damageDescription;
                 */

                Room room = new Room(
                        rs.getInt("hotelID"),
                        rs.getDouble("price"),
                        rs.getInt("capacity"),
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
}