<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.demo.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Hotel Booking - Confirmation</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&amp;display=swap" rel="stylesheet">

    <!-- Styles -->
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
    <style>
        .login-container {
            margin-top: 2rem;
        }
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
        .confirmation-actions .btn {
            margin: 0 0.5rem;
        }
        h1 {
            color: #343a40;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp"/>

<%
    // Process any session messages for toastr notifications
    ArrayList<Message> messages;
    if ((ArrayList<Message>) session.getAttribute("messages") == null)
        messages = new ArrayList<>();
    else
        messages = (ArrayList<Message>) session.getAttribute("messages");

    String msgField = "";
    for (Message m : messages) {
        msgField += "{\"type\":\"" + m.type + "\",\"value\":\"" + m.value.replaceAll("['\"]+", "") + "\"},";
    }
    session.setAttribute("messages", new ArrayList<Message>());

    // Get booking parameters from the request
    String customerID = request.getParameter("customerID");
    String roomID = request.getParameter("roomID");
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");

    // Insert new booking if required parameters are provided
    if (customerID != null && roomID != null && startDate != null && endDate != null) {
        String sqlInsert = "INSERT INTO Booking (CustomerID, RoomID, StartDate, EndDate, Status) VALUES (?, ?, ?, ?, ?)";
        ConnectionDB db = new ConnectionDB();
        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sqlInsert)) {

            ps.setInt(1, Integer.parseInt(customerID));
            ps.setInt(2, Integer.parseInt(roomID));
            ps.setDate(3, java.sql.Date.valueOf(startDate));
            ps.setDate(4, java.sql.Date.valueOf(endDate));
            ps.setString(5, "Booked");

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                // Optionally, you could add a success message:
                // messages.add(new Message("success", "Booking created successfully."));
            } else {
                // Optionally, add an error message if needed.
            }
        } catch(Exception e) {
            e.printStackTrace();
            // Optionally, add an error message to the session messages.
        }
    }
%>

<input type="hidden" name="message" id="message" value='<%= msgField %>' >
<div class="container">
    <div class="row" id="row">
        <div class="col-md-12">
            <div class="card" id="card-container">
                <div class="card-body" id="card">
                    <div class="confirmation-header">
                        <h1>Booking Confirmed!</h1>
                        <div class="confirmation-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <p class="confirmation-message">Thank you for your booking. Your reservation has been confirmed.</p>
                    </div>
                    <div class="confirmation-actions">
                        <button onclick="window.location.href='index.jsp'" class="btn btn-secondary">
                            <i class="fas fa-home"></i> Return to Home
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="assets/js/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
<script>
    $(document).ready(function() {
        toastr.options = {
            "closeButton": true,
            "positionClass": "toast-bottom-right",
            "preventDuplicates": false
        };

        let messages = document.getElementById("message").value;
        if (messages !== "") messages = JSON.parse("[" + messages.slice(0, -1) + "]");
        else messages = [];

        messages.forEach(({type, value}) => {
            switch (type) {
                case "error":
                    toastr.error(value);
                    break;
                case "success":
                    toastr.success(value);
                    break;
                case "warning":
                    toastr.warning(value);
                    break;
                default:
                    toastr.info(value);
                    break;
            }
        });
    });
</script>
<script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
