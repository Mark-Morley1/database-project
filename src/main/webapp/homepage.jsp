<%@ page import="com.demo.ConnectionDB" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hotel Booking - Login</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet">
    <!-- Styles -->
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 450px;
        }
        .login-title {
            color: #2c3e50;
            margin-bottom: 30px;
            font-weight: 600;
            text-align: center;
            font-size: 28px;
        }
        .form-control {
            border-radius: 5px;
            padding: 12px;
            border: 1px solid #ced4da;
            width: 100%;
            margin-bottom: 20px;
        }
        .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }
        .btn-login {
            background-color: #3498db;
            border: none;
            padding: 12px;
            font-weight: 500;
            width: 100%;
            color: white;
            border-radius: 5px;
            transition: all 0.3s;
            font-size: 16px;
            margin-top: 10px;
        }
        .btn-login:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }
        .input-icon {
            position: relative;
        }
        .input-icon i {
            position: absolute;
            top: 15px;
            left: 15px;
            color: #6c757d;
        }
        .input-icon input {
            padding-left: 40px;
        }
    </style>
</head>
<body>
<%
    // Process login only when the form is submitted via POST
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check for null or empty values
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            response.sendRedirect("homepage.jsp");
            return;
        }

        // Use parameterized queries to validate credentials
        String sqlCustomer = "SELECT customerId FROM customer WHERE customerId = " + username + " AND password = \'" + password + "\'";
        String sqlEmployee = "SELECT employeeId FROM Employee WHERE employeeId = " + username + " AND ssn_sin = \'" + password + "\'";

        ConnectionDB db = new ConnectionDB();
        try (Connection con = db.getConnection()) {
            // Validate as Customer

            PreparedStatement stmt = con.prepareStatement(sqlCustomer);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                // Valid customer found; redirect to customer index page
                response.sendRedirect("index.jsp");
                return;
            }
            rs.close();
            stmt.close();

            // Validate as Employee
            stmt = con.prepareStatement(sqlEmployee);

            rs = stmt.executeQuery();

            if (rs.next()) {
                // Valid employee found; redirect to employee index page
                response.sendRedirect("login.jsp");
                return;
            }
            // If no record is found, redirect back to login with error message
            response.sendRedirect("homepage.jsp?error=Invalid%20credentials");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("homepage.jsp?error=Database%20error");
            return;
        }
    }
%>

<!-- Display Login Form if not POST or if login validation did not redirect -->
<div class="login-container">
    <h1 class="login-title">Hotel Booking System</h1>
    <form action="homepage.jsp" method="post">
        <div class="input-icon">
            <i class="fas fa-user"></i>
            <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
        </div>
        <div class="input-icon">
            <i class="fas fa-lock"></i>
            <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
        </div>
        <button type="submit" class="btn btn-login">
            <i class="fas fa-sign-in-alt me-2"></i>Login
        </button>
    </form>
</div>

<script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
