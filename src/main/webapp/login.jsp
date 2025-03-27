<%@ page import="com.demo.EmployeeConnection" %>
<%@ page import="com.demo.Employee" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
  String employeeId = request.getParameter("username");
  String ssn = request.getParameter("password");
  boolean isLoggedIn = false;

  if (employeeId != null && ssn != null && !employeeId.isEmpty() && !ssn.isEmpty()) {
    try {
      int empId = Integer.parseInt(employeeId);
      String sin = ssn;

      EmployeeConnection employeeConnection = new EmployeeConnection();
      Employee employee = employeeConnection.getEmployee(empId, sin);

      if (employee != null) {
        session.setAttribute("loggedIn", true);
        session.setAttribute("username", employee.getSSN());
        isLoggedIn = true;
      } else {
        response.sendRedirect("employeeLOGin.jsp?error=invalid");
      }
    } catch (NumberFormatException e) {
      response.sendRedirect("employeeLOGin.jsp?error=format");
    }
  }
%>

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

    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger">
      <% if ("invalid".equals(request.getParameter("error"))) { %>
      Invalid Employee ID or SSN.
      <% } else if ("format".equals(request.getParameter("error"))) { %>
      Please enter a valid numeric Employee ID.
      <% } %>
    </div>
    <% } %>

    <% if (!isLoggedIn) { %>
    <form method="post" action="login.jsp">
      <div class="mb-3">
        <label for="username" class="form-label">Employee ID:</label>
        <input type="text" id="username" name="username" class="form-control" required>
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">SSN:</label>
        <input type="password" id="password" name="password" class="form-control" required>
      </div>
      <button type="submit" class="btn btn-primary w-100">Login</button>
    </form>
    <% } else { %>
    <div class="alert alert-success text-center">
      <strong>Welcome!</strong> You are now logged in.
    </div>
    <div class="d-grid gap-2">
      <a href="createBooking.jsp" class="btn btn-success">Create Booking</a>
      <a href="viewBookings.jsp" class="btn btn-info">View Bookings</a>
      <a href="employeeLOGin.jsp" class="btn btn-danger">Logout</a>
    </div>
    <% } %>

  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
