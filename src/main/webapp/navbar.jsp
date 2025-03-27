<%--
  Clean Navigation Bar with Home Button Only
  User: markmorley
  Date: 2025-03-22
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <!-- Add these in your head section or include them from a CDN -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    #nav-bar {
      background: linear-gradient(135deg, #6e8efb, #a777e3);
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      padding: 0.8rem 1rem;
    }

    .navbar-brand {
      font-weight: 600;
      font-size: 1.3rem;
      color: white !important;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .navbar-brand:hover {
      transform: scale(1.05);
      text-decoration: none;
    }

    .container-fluid {
      justify-content: center; /* Centers the brand */
    }
  </style>
</head>
<body>
<nav class="navbar navbar-dark" id="nav-bar">
  <div class="container-fluid">
    <a class="navbar-brand" href="<%=request.getContextPath()%>">
      <i class="fas fa-home"></i>
      <span>Home Page</span>
    </a>
  </div>
</nav>

<!-- Include Bootstrap JS (optional if you don't need dropdowns/toggles) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>