<%@ page import="com.demo.EmployeeConnection" %>
<%@ page import="com.demo.Employee" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
  // Retrieve user input from the form
  String employeeId = request.getParameter("username");
  String ssn = request.getParameter("password");

  if (employeeId != null && ssn != null && !employeeId.isEmpty() && !ssn.isEmpty()) {
    try {
      int empId = Integer.parseInt(employeeId);
      String sin = ssn;

      EmployeeConnection employeeConnection = new EmployeeConnection();
      Employee employee = employeeConnection.getEmployee(empId, sin);

      if (employee != null) {
        session.setAttribute("loggedIn", true);
        session.setAttribute("username", employee.getSSN());
        response.sendRedirect("welcome.jsp");
      } else {
        response.sendRedirect("employeeLOGin.jsp?error=invalid");
      }
    } catch (NumberFormatException e) {
      response.sendRedirect("employeeLOGin.jsp?error=format");
    }
  }
%>

<!DOCTYPE html>
<html>
<head>
  <title>Login</title>
</head>
<body>
<h2>Employee Login</h2>

<form method="post" action="login.jsp">
  <div class="form-group">
    <label for="username">Username (Employee ID):</label>
    <input type="text" id="username" name="username" required>
  </div>
  <div class="form-group">
    <label for="password">Password (SSN):</label>
    <input type="password" id="password" name="password" required>
  </div>
  <button type="submit">Login</button>
</form>
</body>
</html>