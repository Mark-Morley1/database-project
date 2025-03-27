<%@ page import="com.demo.EmployeeConnection" %>
<%@ page import="com.demo.Employee" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Employee Login</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    body {
      background-color: #f8f9fa;
    }
    .login-container {
      width: 100%;
      max-width: 400px;
      margin: 80px auto;
      padding: 30px;
      background: white;
      border-radius: 8px;
      box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    }
  </style>
</head>
<body>

<div class="container">
  <div class="login-container">
    <h2 class="text-center">Employee Login</h2>

    <div class="alert alert-success text-center">
      <strong>Welcome!</strong> You are now logged in.
    </div>
    <div class="d-grid gap-2">
      <a href="createBooking.jsp" class="btn btn-success">Create Booking</a>
      <a href="viewBookings.jsp" class="btn btn-info">View Bookings</a>
      <a href="homepage.jsp" class="btn btn-danger">Logout</a>
    </div>

  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
