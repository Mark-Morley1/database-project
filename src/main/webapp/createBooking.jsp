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

        BookingConnection bookingConnection = new BookingConnection();
        bookingSuccess = bookingConnection.createBooking(Integer.parseInt(roomId), Integer.parseInt(customerId), startDate, endDate);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= bookingSuccess ? "Booking Confirmed" : "Create New Booking" %></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            line-height: 1.6;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="date"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .submit-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
        }
        .submit-btn:hover {
            background-color: #45a049;
        }
        .home-btn {
            background-color: #337ab7;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
        }
        .home-btn:hover {
            background-color: #286090;
        }
        .button-group {
            margin-top: 20px;
            text-align: center;
        }
        /* Confirmation styles */
        .confirmation-header {
            text-align: center;
            margin: 2rem 0;
            padding: 1rem;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        .confirmation-icon {
            font-size: 5rem;
            color: #28a745;
            margin: 1rem 0;
        }
        .confirmation-message {
            font-size: 1.2rem;
            color: #6c757d;
        }
        .confirmation-actions {
            text-align: center;
            margin: 2rem 0;
        }
        /* Error styles */
        .error-header {
            text-align: center;
            margin: 2rem 0;
            padding: 1rem;
            background-color: #f8d7da;
            border-radius: 5px;
        }
        .error-icon {
            font-size: 5rem;
            color: #dc3545;
            margin: 1rem 0;
        }
        .error-message {
            font-size: 1.2rem;
            color: #721c24;
        }
        .error-actions {
            text-align: center;
            margin: 2rem 0;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
<% if (bookingSuccess) { %>
<div class="container">
    <div class="confirmation-header">
        <h1>Booking Confirmed!</h1>
        <div class="confirmation-icon">
            <i class="fas fa-check-circle"></i>
        </div>
        <p class="confirmation-message">Thank you for your booking. Your reservation has been confirmed.</p>
    </div>
    <div class="confirmation-actions">
        <a href="employeePage.jsp" class="home-btn">
            <i class="fas fa-home"></i> Return to Home
        </a>
    </div>
</div>
<% } else if ("POST".equalsIgnoreCase(request.getMethod())) { %>
<div class="container">
    <div class="error-header">
        <h1>Booking Failed!</h1>
        <h2>This Room is Already Booked For The Time Provided</h2>
        <div class="error-icon">
            <i class="fas fa-exclamation-circle"></i>
        </div>
        <p class="error-message">An error occurred while processing your booking. Please try again later.</p>
    </div>
    <div class="error-actions">
        <button onclick="window.history.back()" class="home-btn" style="background-color: #dc3545;">
            <i class="fas fa-arrow-left"></i> Go Back
        </button>
        <a href="employeePage.jsp" class="home-btn">
            <i class="fas fa-home"></i> Return to Home
        </a>
    </div>
</div>
<% } else { %>
<div class="container">
    <h1>Create New Booking</h1>
    <form method="post">
        <div class="form-group">
            <label for="customerId">Customer ID:</label>
            <input type="text" id="customerId" name="customerId" value="<%= customerId != null ? customerId : "" %>" required>
        </div>

        <div class="form-group">
            <label for="roomId">Room ID:</label>
            <input type="text" id="roomId" name="roomId" value="<%= roomId != null ? roomId : "" %>" required>
        </div>

        <div class="form-group">
            <label for="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate" value="<%= startDate != null ? startDate : today %>" required>
        </div>

        <div class="form-group">
            <label for="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate" value="<%= endDate != null ? endDate : tomorrow %>" required>
        </div>

        <div class="form-group">
            <label for="status">Status:</label>
            <input type="text" id="status" name="status" value="<%= status != null ? status : "Confirmed" %>" required>
        </div>

        <div class="button-group">
            <input type="submit" value="Create Booking" class="submit-btn">
            <a href="employeePage.jsp" class="home-btn">Homepage</a>
        </div>
    </form>
</div>
<% } %>
</body>
</html>