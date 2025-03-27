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
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Booking Management | Hotel System</title>
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #3498db;
            --secondary: #2ecc71;
            --dark: #2c3e50;
            --light: #f8f9fa;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7fa;
            color: #333;
        }

        .header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .header-title {
            font-weight: 700;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.2);
        }

        .header-subtitle {
            font-weight: 300;
            opacity: 0.9;
        }

        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }

        .card-header {
            background-color: white;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            font-weight: 600;
            border-radius: 10px 10px 0 0 !important;
        }

        .table-responsive {
            border-radius: 10px;
            overflow: hidden;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-confirmed {
            background-color: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }

        .badge-pending {
            background-color: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }

        .badge-cancelled {
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }

        .btn-dashboard {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border: none;
            color: white;
            padding: 10px 25px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background-color: #f8f9fa;
            font-weight: 600;
        }

        tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="header-title"><i class="fas fa-calendar-alt me-2"></i>Booking Management</h1>
                <p class="header-subtitle">View all hotel reservations</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="employeePage.jsp" class="btn btn-light">
                    <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="card">
        <div class="card-header">
            <h5 class="mb-0"><i class="fas fa-list me-2"></i>All Bookings</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table>
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
                                "ORDER BY b.BookingID DESC";

                        ConnectionDB db = new ConnectionDB();
                        try (Connection con = db.getConnection()) {
                            PreparedStatement stmt = con.prepareStatement(sql);
                            ResultSet rs = stmt.executeQuery();

                            while (rs.next()) {
                                String status = rs.getString("Status");
                                String badgeClass = "badge-confirmed";
                                if("Pending".equalsIgnoreCase(status)) {
                                    badgeClass = "badge-pending";
                                } else if("Cancelled".equalsIgnoreCase(status)) {
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

    <div class="text-center mt-4 mb-5">
        <a href="employeePage.jsp" class="btn btn-dashboard">
            <i class="fas fa-tachometer-alt me-2"></i>Return to Dashboard
        </a>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>