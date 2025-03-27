package com.demo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EmployeeConnection {
    public List<Employee> getEmployees() throws Exception {
        String sql = "SELECT * FROM public.employee";

        ConnectionDB db = new ConnectionDB();

        List<Employee> employees = new ArrayList<>();
        try (Connection con = db.getConnection()) {
            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {

                Employee employee = new Employee(
                        rs.getInt("employeeId"),
                        rs.getInt("hotelId"),
                        rs.getString("fullname"),
                        rs.getString("address"),
                        rs.getString("ssn_sin"),
                        rs.getString("Position")
                );

                employees.add(employee);
            }
            rs.close();
            // close the statement
            stmt.close();
            con.close();
            db.close();

            // return the grades retrieved from database
            return employees;
        } catch (Exception e) {
            // throw any errors occurred
            throw new Exception(e.getMessage());
        }

    }

    public Employee getEmployee(Integer employeeId, String sin) throws Exception {
        // Define the query with placeholders for parameters
        String sql = "SELECT * FROM public.employee WHERE SSN_SIN = ? AND EmployeeID = ?";

        ConnectionDB db = new ConnectionDB();

        // Use a connection object (e.g., ConnectionDB.getConnection())
        try (Connection connection = db.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            // Set the values for the placeholders
            stmt.setString(1, sin); // Set SSN_SIN
            stmt.setInt(2, employeeId); // Set EmployeeID

            // Execute the query and get the result
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Assuming Employee has a constructor that takes these parameters
                return new Employee(
                        rs.getInt("employeeId"),
                        rs.getInt("hotelId"),
                        rs.getString("fullname"),
                        rs.getString("address"),
                        rs.getString("ssn_sin"),
                        rs.getString("Position")
                );
            }
        } catch (Exception e) {
            throw new Exception("Error executing query", e);
        }
        return null; // Return null if no employee found
    }


}