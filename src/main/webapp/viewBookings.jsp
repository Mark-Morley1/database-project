<%@ page import="java.sql.*" %>
<%@ page import="com.demo.BookingConnection" %>
<%@ page import="java.util.List" %>
<%@ page import="com.demo.Booking" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.demo.ConnectionDB" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>View Bookings</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center">Online Bookings</h2>

    <table class="table table-striped table-bordered mt-4">
        <thead class="table-dark">
        <tr>
            <th>Booking ID</th>
            <th>Customer ID</th>
            <th>Room ID</th>
            <th>Check-in Date</th>
            <th>Check-out Date</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <%        String sql = "SELECT b.BookingID, " +
                "c.fullname AS CustomerName, " +
                "r.RoomID AS RoomNumber, " +
                "b.StartDate AS CheckInDate, " +
                "b.EndDate AS CheckOutDate " +
                "FROM Booking b " +
                "JOIN Customer c ON b.CustomerID = c.CustomerID " +
                "JOIN Room r ON b.RoomID = r.RoomID " +
                "ORDER BY b.BookingID DESC";

        ConnectionDB db = new ConnectionDB();

        List<Booking> bookings = new ArrayList<>();
        try (Connection con = db.getConnection()) {
            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // get the results from executing the query
            ResultSet rs = stmt.executeQuery();

            // iterate through the result set
            while (rs.next()) {%>
            <td><%= rs.getInt("bookingid") %></td>
            <td><%= rs.getString("customername") %></td>
            <td><%= rs.getInt("roomnumber") %></td>
            <td><%= rs.getString("checkindate") %></td>
            <td><%= rs.getString("checkoutdate") %></td>
            <%}}

        catch(Exception e){%>
        </tr>
        <tr><td colspan="6" class="text-danger text-center">Error loading bookings.</td></tr>
        <%}%>

        </tbody>
    </table>

    <div class="text-center mt-4">
        <a href="login.jsp" class="btn btn-primary">Back to Dashboard</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
