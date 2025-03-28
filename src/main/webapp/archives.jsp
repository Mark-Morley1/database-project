<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Booking Archives | Hotel Management System</title>
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
      color: #333;
      padding-top: 20px;
      padding-bottom: 20px;
    }

    .container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 5px;
      padding: 20px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    .header {
      background-color: #343a40;
      color: white;
      padding: 15px;
      margin-bottom: 20px;
      border-radius: 5px;
    }

    .table {
      background-color: white;
    }

    .status-badge {
      padding: 3px 8px;
      border-radius: 3px;
      font-size: 0.8rem;
      font-weight: 600;
    }

    .badge-completed {
      background-color: #d4edda;
      color: #155724;
    }

    .badge-cancelled {
      background-color: #f8d7da;
      color: #721c24;
    }

    th {
      background-color: #f8f9fa;
    }

    tr:hover {
      background-color: #f5f5f5;
    }

    .btn-back {
      background-color: #6c757d;
      color: white;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="header">
    <div class="row align-items-center">
      <div class="col-md-8">
        <h1><i class="fas fa-archive me-2"></i>Booking Archives</h1>
        <p class="mb-0">View historical booking records</p>
      </div>
      <div class="col-md-4 text-end">
        <a href="employeePage.jsp" class="btn btn-light">
          <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
        </a>
      </div>
    </div>
  </div>

  <div class="card mb-4">
    <div class="card-header bg-white">
      <h5 class="mb-0"><i class="fas fa-history me-2"></i>Archived Bookings</h5>
    </div>
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover mb-0">
          <thead>
          <tr>
            <th>Booking ID</th>
            <th>Customer</th>
            <th>Room</th>
            <th>Check-in</th>
            <th>Check-out</th>
            <th>Status</th>
            <th>Archived Date</th>
          </tr>
          </thead>
          <tbody>
          <!-- Sample archived booking 1 -->
          <tr>
            <td>1001</td>
            <td>John Smith</td>
            <td>#205</td>
            <td>2023-05-10</td>
            <td>2023-05-15</td>
            <td><span class="status-badge badge-completed">Completed</span></td>
            <td>2023-05-16</td>
          </tr>

          <!-- Sample archived booking 2 -->
          <tr>
            <td>1002</td>
            <td>Sarah Johnson</td>
            <td>#312</td>
            <td>2023-06-01</td>
            <td>2023-06-05</td>
            <td><span class="status-badge badge-completed">Completed</span></td>
            <td>2023-06-06</td>
          </tr>

          <!-- Sample archived booking 3 -->
          <tr>
            <td>1003</td>
            <td>Michael Brown</td>
            <td>#107</td>
            <td>2023-07-20</td>
            <td>2023-07-25</td>
            <td><span class="status-badge badge-cancelled">Cancelled</span></td>
            <td>2023-07-19</td>
          </tr>

          <!-- Sample archived booking 4 -->
          <tr>
            <td>1004</td>
            <td>Emily Davis</td>
            <td>#409</td>
            <td>2023-08-12</td>
            <td>2023-08-18</td>
            <td><span class="status-badge badge-completed">Completed</span></td>
            <td>2023-08-19</td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <div class="text-center">
    <a href="employeePage.jsp" class="btn btn-back">
      <i class="fas fa-tachometer-alt me-2"></i>Return to Dashboard
    </a>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>