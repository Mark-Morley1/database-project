<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.demo.*" %>

<%
    // Get current date and tomorrow's date
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    Calendar calendar = Calendar.getInstance();

    String today = dateFormat.format(calendar.getTime());
    calendar.add(Calendar.DATE, 1);
    String tomorrow = dateFormat.format(calendar.getTime());

    // Variables to collect form inputs
    String customerId = request.getParameter("customerId");
    String roomId = request.getParameter("roomId");
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");
    String status = request.getParameter("status");

    boolean bookingSuccess = false;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        customerId = request.getParameter("customerId");
        roomId = request.getParameter("roomId");
        startDate = request.getParameter("startDate");
        endDate = request.getParameter("endDate");
        status = request.getParameter("status");

        BookingConnection bookingConnection = new BookingConnection();
        bookingSuccess = bookingConnection.createBooking(Integer.parseInt(roomId), Integer.parseInt(customerId), startDate, endDate);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= bookingSuccess ? "Booking Confirmed" : "Create New Booking" %></title>
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
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 20px;
        }

        .booking-card {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto;
            width: 100%;
        }

        .header {
            background-color: #343a40;
            color: white;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-weight: 600;
            margin-bottom: 8px;
        }

        .btn-primary {
            background-color: #28a745;
            border: none;
            padding: 10px 20px;
        }

        .btn-primary:hover {
            background-color: #218838;
        }

        .btn-secondary {
            background-color: #6c757d;
            border: none;
            padding: 10px 20px;
        }

        .confirmation-box {
            text-align: center;
            padding: 30px;
        }

        .confirmation-icon {
            font-size: 4rem;
            color: #28a745;
            margin-bottom: 20px;
        }

        .error-box {
            text-align: center;
            padding: 30px;
            background-color: #f8d7da;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .error-icon {
            font-size: 4rem;
            color: #dc3545;
            margin-bottom: 20px;
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="booking-card">
    <% if (bookingSuccess) { %>
    <div class="header">
        <h2><i class="fas fa-check-circle me-2"></i>Booking Confirmed</h2>
    </div>
    <div class="confirmation-box">
        <div class="confirmation-icon">
            <i class="fas fa-check-circle"></i>
        </div>
        <h3>Thank you for your booking!</h3>
        <p>Your reservation has been successfully confirmed.</p>
        <div class="button-group">
            <a href="employeePage.jsp" class="btn btn-secondary">
                <i class="fas fa-home me-2"></i>Return to Dashboard
            </a>
        </div>
    </div>
    <% } else if ("POST".equalsIgnoreCase(request.getMethod())) { %>
    <div class="header">
        <h2><i class="fas fa-exclamation-circle me-2"></i>Booking Failed</h2>
    </div>
    <div class="error-box">
        <div class="error-icon">
            <i class="fas fa-exclamation-circle"></i>
        </div>
        <h3>This room is already booked</h3>
        <p>Please choose different dates or another room.</p>
    </div>
    <div class="button-group">
        <button onclick="window.history.back()" class="btn btn-secondary">
            <i class="fas fa-arrow-left me-2"></i>Go Back
        </button>
        <a href="employeePage.jsp" class="btn btn-secondary">
            <i class="fas fa-home me-2"></i>Dashboard
        </a>
    </div>
    <% } else { %>
    <div class="header">
        <h2><i class="fas fa-calendar-plus me-2"></i>Create New Booking</h2>
    </div>
    <form method="post">
        <div class="form-group">
            <label for="customerId">Customer ID:</label>
            <input type="text" class="form-control" id="customerId" name="customerId" value="<%= customerId != null ? customerId : "" %>" required>
        </div>

        <div class="form-group">
            <label for="roomId">Room ID:</label>
            <input type="text" class="form-control" id="roomId" name="roomId" value="<%= roomId != null ? roomId : "" %>" required>
        </div>

        <div class="form-group">
            <label for="startDate">Start Date:</label>
            <input type="date" class="form-control" id="startDate" name="startDate" value="<%= startDate != null ? startDate : today %>" required>
        </div>

        <div class="form-group">
            <label for="endDate">End Date:</label>
            <input type="date" class="form-control" id="endDate" name="endDate" value="<%= endDate != null ? endDate : tomorrow %>" required>
        </div>

        <div class="form-group">
            <label for="status">Status:</label>
            <select class="form-control" id="status" name="status" required>
                <option value="Renting" <%= "Renting".equals(status) ? "selected" : "" %>>Renting</option>
                <option value="Booking" <%= "Booking".equals(status) || status == null ? "selected" : "" %>>Booking</option>
            </select>
        </div>

        <div class="button-group">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save me-2"></i>Create Booking
            </button>
            <a href="employeePage.jsp" class="btn btn-secondary">
                <i class="fas fa-home me-2"></i>Dashboard
            </a>
        </div>
    </form>
    <% } %>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>