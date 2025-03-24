package com.demo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class HotelChainConnection {
    public List<HotelChain> getHotelChains() throws Exception {
        String sql = "SELECT * FROM public.hotelchain";

        ConnectionDB db = new ConnectionDB();

        List<HotelChain> hotelChains = new ArrayList<>();
        try (Connection con = db.getConnection()) {
            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {

                HotelChain hotelChain = new HotelChain(
                        rs.getInt("chainID"),
                        rs.getString("name"),
                        rs.getString("centralOfficeAddress"),
                        rs.getInt("numberOfHotels"),
                        rs.getString("contactEmail"),
                        rs.getString("contactPhone")
                );

                hotelChains.add(hotelChain);
            }
            rs.close();
            // close the statement
            stmt.close();
            con.close();
            db.close();

            // return the grades retrieved from database
            return hotelChains;
        } catch (Exception e) {
            // throw any errors occurred
            throw new Exception(e.getMessage());
        }

    }
}