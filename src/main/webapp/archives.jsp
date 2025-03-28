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
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Booking Archives | Hotel System</title>
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    body {
      font-family: Arial, sans-serif;
      background-image: url('hello.jpg');
      background-size: cover;
      background-attachment: fixed;
      background-position: center;
      color: #333;
      padding-top: 20px;
      padding-bottom: 20px;
    }

    .container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 5px;
      padding: 20px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    .header {
      background-color: #343a40;
      color: white;
      padding: 15px;
      margin-bottom: 20px;
      border-radius: 5px;
    }

    .table {
      background-color: white;
    }

    .status-badge {
      padding: 3px 8px;
      border-radius: 3px;
      font-size: 0.8rem;
      font-weight: 600;
    }

    .badge-completed {
      background-color: #d4edda;
      color: #155724;
    }

    .badge-cancelled {
      background-color: #f8d7da;
      color: #721c24;
    }

    th {
      background-color: #f8f9fa;
    }

    tr:hover {
      background-color: #f5f5f5;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="header">
    <div class="row align-items-center">
      <div class="col-md-8">
        <h1><i class="fas fa-archive me-2"></i>Booking Archives</h1>
        <p class="mb-0">View all completed hotel reservations</p>
      </div>
      <div class="col-md-4 text-end">
        <a href="employeePage.jsp" class="btn btn-light">
          <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
        </a>
      </div>
    </div>
  </div>

  <div class="card mb-4">
    <div class="card-header bg-white">
      <h5 class="mb-0"><i class="fas fa-list me-2"></i>Completed Bookings</h5>
    </div>
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover mb-0">
          <thead>
          <tr>
            <th>Booking ID</th>
            <th>Customer</th>
            <th>Room</th>
            <th>Check-in</th>
            <th>Check-out</th>
            <th>Status</th>
          </tr>
          </thead>
          <tbody>
          <%
            String sql = "SELECT b.BookingID, " +
                    "c.fullname AS CustomerName, " +
                    "r.RoomID AS RoomNumber, " +
                    "b.StartDate AS CheckInDate, " +
                    "b.EndDate AS CheckOutDate, " +
                    "b.Status " +
                    "FROM Booking b " +
                    "JOIN Customer c ON b.CustomerID = c.CustomerID " +
                    "JOIN Room r ON b.RoomID = r.RoomID " +
                    "WHERE b.Status = 'Completed' " +
                    "ORDER BY b.BookingID DESC";

            ConnectionDB db = new ConnectionDB();
            try (Connection con = db.getConnection()) {
              PreparedStatement stmt = con.prepareStatement(sql);
              ResultSet rs = stmt.executeQuery();

              while (rs.next()) {
                String status = rs.getString("Status");
                String badgeClass = "badge-completed";
                if("Cancelled".equalsIgnoreCase(status)) {
                  badgeClass = "badge-cancelled";
                }
          %>
          <tr>
            <td><%= rs.getInt("BookingID") %></td>
            <td><%= rs.getString("CustomerName") %></td>
            <td>#<%= rs.getInt("RoomNumber") %></td>
            <td><%= rs.getString("CheckInDate") %></td>
            <td><%= rs.getString("CheckOutDate") %></td>
            <td><span class="status-badge <%= badgeClass %>"><%= status %></span></td>
          </tr>
          <%
            }
          } catch(Exception e) {
          %>
          <tr>
            <td colspan="6" class="text-center text-danger py-4">
              <i class="fas fa-exclamation-triangle me-2"></i>
              Error loading booking data. Please try again later.
            </td>
          </tr>
          <%
            }
          %>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <div class="text-center">
    <a href="employeePage.jsp" class="btn btn-dark">
      <i class="fas fa-tachometer-alt me-2"></i>Return to Dashboard
    </a>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>