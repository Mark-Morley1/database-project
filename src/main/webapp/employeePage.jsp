<%@ page import="com.demo.EmployeeConnection" %>
<%@ page import="com.demo.Employee" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
  <title>Employee Dashboard | Hotel Management System</title>
  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <!-- Animate CSS -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
  <style>
    :root {
      --primary: #3498db;
      --secondary: #2ecc71;
      --success: #28a745;
      --info: #17a2b8;
      --warning: #fd7e14;
      --danger: #dc3545;
      --light: #f8f9fa;
      --dark: #343a40;
    }

    body {
      font-family: 'Poppins', sans-serif;
      margin: 0;
      padding: 0;
      background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
      url('hello.jpg') no-repeat center center fixed;
      background-size: cover;
      min-height: 100vh;
      display: flex;
      align-items: center;
      color: #333;
    }

    .glass-card {
      width: 100%;
      max-width: 550px;
      margin: 2rem auto;
      padding: 2.5rem;
      background: rgba(255, 255, 255, 0.95);
      border-radius: 20px;
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255, 255, 255, 0.2);
      transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }

    .glass-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
    }

    .dashboard-header {
      text-align: center;
      margin-bottom: 2.5rem;
      position: relative;
    }

    .user-avatar {
      width: 100px;
      height: 100px;
      margin: 0 auto 1.5rem;
      background: linear-gradient(135deg, var(--primary), var(--secondary));
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
      transition: all 0.3s ease;
    }

    .user-avatar:hover {
      transform: scale(1.05) rotate(5deg);
    }

    .user-avatar i {
      font-size: 3rem;
      color: white;
    }

    .dashboard-title {
      color: var(--dark);
      font-weight: 700;
      margin-bottom: 0.5rem;
      font-size: 2rem;
      background: linear-gradient(to right, var(--primary), var(--secondary));
      -webkit-background-clip: text;
      background-clip: text;
      color: transparent;
      display: inline-block;
    }

    .welcome-message {
      background: rgba(40, 167, 69, 0.15);
      border-left: 4px solid var(--success);
      color: var(--success);
      padding: 1rem;
      border-radius: 8px;
      margin-bottom: 2rem;
      display: flex;
      align-items: center;
      animation: fadeIn 0.8s ease;
    }

    .welcome-message i {
      margin-right: 10px;
      font-size: 1.5rem;
    }

    .action-buttons {
      display: grid;
      grid-template-columns: 1fr;
      gap: 1rem;
    }

    .action-btn {
      padding: 1rem;
      border-radius: 12px;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 1px;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
      position: relative;
      overflow: hidden;
      border: none;
      color: white;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .action-btn i {
      margin-right: 12px;
      font-size: 1.2rem;
      transition: all 0.3s;
    }

    .action-btn:hover {
      transform: translateY(-3px);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
    }

    .action-btn:hover i {
      transform: scale(1.2);
    }

    .action-btn::after {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: linear-gradient(rgba(255, 255, 255, 0.1), rgba(255, 255, 255, 0));
      opacity: 0;
      transition: all 0.3s;
    }

    .action-btn:hover::after {
      opacity: 1;
    }

    .btn-create {
      background: linear-gradient(135deg, var(--success), #20c997);
    }

    .btn-view {
      background: linear-gradient(135deg, var(--info), #007bff);
    }

    .btn-logout {
      background: linear-gradient(135deg, var(--danger), var(--warning));
    }

    .footer-text {
      text-align: center;
      margin-top: 2rem;
      color: #6c757d;
      font-size: 0.9rem;
    }

    .footer-text a {
      color: var(--primary);
      text-decoration: none;
      transition: all 0.3s;
    }

    .footer-text a:hover {
      color: var(--secondary);
      text-decoration: underline;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(10px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @media (max-width: 576px) {
      .glass-card {
        padding: 1.5rem;
        margin: 1rem;
      }

      .dashboard-title {
        font-size: 1.5rem;
      }

      .user-avatar {
        width: 80px;
        height: 80px;
      }
    }
  </style>
</head>
<body>

<div class="container">
  <div class="glass-card animate__animated animate__fadeIn">
    <div class="dashboard-header">
      <div class="user-avatar">
        <i class="fas fa-user-tie"></i>
      </div>
      <h1 class="dashboard-title">Employee Dashboard</h1>
      <p class="text-muted">Manage hotel bookings and reservations</p>
    </div>

    <div class="welcome-message">
      <i class="fas fa-check-circle"></i>
      <div>
        <strong>Welcome back!</strong> You have successfully logged in to the system.
      </div>
    </div>

    <div class="action-buttons">
      <a href="createBooking.jsp" class="action-btn btn-create">
        <i class="fas fa-calendar-plus"></i> Create New Booking
      </a>
      <a href="viewBookings.jsp" class="action-btn btn-view">
        <i class="fas fa-list-ol"></i> View All Bookings
      </a>
      <a href="homepage.jsp" class="action-btn btn-logout">
        <i class="fas fa-sign-out-alt"></i> Logout
      </a>
    </div>

    <p class="footer-text">
      Hotel Management System v2.0 © 2023 |
      <a href="#" data-bs-toggle="modal" data-bs-target="#helpModal">Need help?</a>
    </p>
  </div>
</div>

<!-- Help Modal -->
<div class="modal fade" id="helpModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title"><i class="fas fa-question-circle me-2"></i>Help Center</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <h6><i class="fas fa-info-circle text-primary me-2"></i>Dashboard Guide</h6>
        <p>This dashboard allows you to manage hotel bookings and reservations.</p>

        <h6 class="mt-3"><i class="fas fa-tasks text-primary me-2"></i>Available Actions</h6>
        <ul>
          <li><strong>Create Booking:</strong> Add new hotel reservations</li>
          <li><strong>View Bookings:</strong> See all current reservations</li>
          <li><strong>Logout:</strong> Securely exit the system</li>
        </ul>

        <div class="alert alert-info mt-3">
          <i class="fas fa-phone-alt me-2"></i> For immediate assistance, call support at: <strong>1-800-HOTEL-HELP</strong>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Add animation to buttons on hover
  document.querySelectorAll('.action-btn').forEach(button => {
    button.addEventListener('mouseenter', function() {
      this.classList.add('animate__animated', 'animate__pulse');
    });

    button.addEventListener('mouseleave', function() {
      this.classList.remove('animate__animated', 'animate__pulse');
    });
  });
</script>
</body>
</html>