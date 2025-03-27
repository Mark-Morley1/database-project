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
            margin: 0;
            padding: 0;
            background: url('hello.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }

        .login-container {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            padding: 40px;
            width: 100%;
            max-width: 450px;
            position: relative;
            z-index: 2;
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
        }

        .login-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
        }

        .login-title {
            color: #2c3e50;
            margin-bottom: 30px;
            font-weight: 700;
            text-align: center;
            font-size: 32px;
            position: relative;
            padding-bottom: 15px;
        }

        .login-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(to right, #3498db, #2ecc71);
        }

        .form-control {
            border-radius: 8px;
            padding: 14px 20px 14px 45px;
            border: 1px solid #e0e0e0;
            width: 100%;
            margin-bottom: 20px;
            font-size: 15px;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }

        .btn-login {
            background: linear-gradient(to right, #3498db, #2ecc71);
            border: none;
            padding: 14px;
            font-weight: 600;
            width: 100%;
            color: white;
            border-radius: 8px;
            transition: all 0.3s;
            font-size: 16px;
            margin-top: 10px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .btn-login:hover {
            background: linear-gradient(to right, #2980b9, #27ae60);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .input-icon {
            position: relative;
        }

        .input-icon i {
            position: absolute;
            top: 15px;
            left: 15px;
            color: #7f8c8d;
            font-size: 18px;
        }

        .form-footer {
            text-align: center;
            margin-top: 20px;
            color: #7f8c8d;
            font-size: 14px;
        }

        .form-footer a {
            color: #3498db;
            text-decoration: none;
            transition: color 0.3s;
        }

        .form-footer a:hover {
            color: #2980b9;
            text-decoration: underline;
        }

        .logo {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo img {
            height: 60px;
        }

        .error-message {
            color: #e74c3c;
            text-align: center;
            margin-bottom: 15px;
            font-size: 14px;
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
            response.sendRedirect("homepage.jsp?error=Please%20enter%20both%20username%20and%20password");
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
                response.sendRedirect("employeePage.jsp");
                return;
            }
            // If no record is found, redirect back to login with error message
            response.sendRedirect("homepage.jsp?error=Invalid%20username%20or%20password");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("homepage.jsp?error=Database%20error");
            return;
        }
    }

    String error = request.getParameter("error");
%>

<!-- Display Login Form if not POST or if login validation did not redirect -->
<div class="login-container">
    <div class="logo">
        <i class="fas fa-hotel" style="font-size: 48px; color: #3498db;"></i>
    </div>
    <h1 class="login-title">Welcome Back</h1>

    <% if (error != null) { %>
    <div class="error-message">
        <i class="fas fa-exclamation-circle"></i> <%= error %>
    </div>
    <% } %>

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

    <div class="form-footer">
        Don't have an account? <a href="#">Contact support</a>
    </div>
</div>

<script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>