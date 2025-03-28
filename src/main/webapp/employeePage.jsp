<%@ page import="com.demo.EmployeeConnection" %>
<%@ page import="com.demo.Employee" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Employee Dashboard | Hotel Management System</title>
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

    .dashboard-card {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 10px;
      padding: 30px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      max-width: 500px;
      margin: 0 auto;
      width: 100%;
    }

    .user-avatar {
      width: 80px;
      height: 80px;
      background-color: #007bff;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 20px;
      color: white;
      font-size: 2rem;
    }

    .dashboard-title {
      text-align: center;
      margin-bottom: 20px;
      color: #333;
    }

    .welcome-message {
      background-color: #e8f5e9;
      border-left: 4px solid #4caf50;
      padding: 10px 15px;
      margin-bottom: 20px;
      border-radius: 4px;
      display: flex;
      align-items: center;
    }

    .welcome-message i {
      margin-right: 10px;
      color: #4caf50;
    }

    .action-btn {
      margin-bottom: 15px;
      padding: 12px;
      text-align: center;
      border-radius: 5px;
      color: white;
      text-decoration: none;
      display: block;
      transition: all 0.3s;
    }

    .action-btn i {
      margin-right: 10px;
    }

    .action-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 10px rgba(0,0,0,0.1);
      color: white;
    }

    .btn-create {
      background-color: #28a745;
    }

    .btn-view {
      background-color: #17a2b8;
    }

    .btn-archive {
      background-color: #6c757d;
    }

    .btn-logout {
      background-color: #dc3545;
    }

    .footer-text {
      text-align: center;
      margin-top: 20px;
      color: #6c757d;
      font-size: 0.9rem;
    }
  </style>
</head>
<body>

<div class="dashboard-card">
  <div class="user-avatar">
    <i class="fas fa-user-tie"></i>
  </div>

  <h2 class="dashboard-title">Employee Dashboard</h2>

  <div class="welcome-message">
    <i class="fas fa-check-circle"></i>
    <div>Welcome back! You have successfully logged in.</div>
  </div>

  <a href="createBooking.jsp" class="action-btn btn-create">
    <i class="fas fa-calendar-plus"></i> Create New Renting
  </a>

  <a href="viewBookings.jsp" class="action-btn btn-view">
    <i class="fas fa-list-ol"></i> View All Bookings
  </a>

  <!-- New Archive Button -->
  <a href="archives.jsp" class="action-btn btn-archive">
    <i class="fas fa-archive"></i> View Archives
  </a>

  <a href="homepage.jsp" class="action-btn btn-logout">
    <i class="fas fa-sign-out-alt"></i> Logout
  </a>

  <p class="footer-text">
    Hotel Management System v2.0 © 2023
  </p>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>