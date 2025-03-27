<%@ page import="com.demo.HotelChainConnection" %>
<%@ page import="com.demo.HotelChain" %>
<%@ page import="java.util.List" %>
<%@ page import="com.demo.Message" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.demo.HotelChain" %>
<%@ page import="com.demo.HotelChainConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    ArrayList<Message> messages;

    // get any incoming messages from session attribute named messages
    // if nothing exists then messages is an empty arraylist
    if ((ArrayList<Message>) session.getAttribute("messages") == null) messages = new ArrayList<>();
        // else get that value
    else messages = (ArrayList<Message>) session.getAttribute("messages");

    String msgField = "";

    // create the object in the form of a stringified json
    for (Message m : messages) {
        msgField += "{\"type\":\"" + m.type + "\",\"value\":\"" + m.value.replaceAll("['\"]+", "") + "\"},";
    }

    // empty session messages
    session.setAttribute("messages", new ArrayList<Message>());

    // retrieve grades from database
    HotelChainConnection hotelChainConnectionService = new HotelChainConnection();
    List<HotelChain> hotels = null;
    try {
        hotels = hotelChainConnectionService.getHotelChains();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Hotel Search</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
    <style>
        body {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('hello.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            color: white;
        }
        .search-container {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            padding: 30px;
            margin-top: 30px;
            margin-bottom: 30px;
            color: #333;
        }
        .form-title {
            color: #2c3e50;
            margin-bottom: 25px;
            font-weight: 600;
            text-align: center;
        }
        .form-label {
            font-weight: 500;
            color: #495057;
        }
        .btn-submit {
            background-color: #3498db;
            border: none;
            padding: 10px 25px;
            font-weight: 500;
            width: 100%;
        }
        .btn-submit:hover {
            background-color: #2980b9;
        }
        .btn-employee {
            background-color: #2ecc71;
            border: none;
            padding: 8px 20px;
            font-weight: 500;
            color: white;
            position: absolute;
            top: 20px;
            right: 20px;
        }
        .btn-employee:hover {
            background-color: #27ae60;
            color: white;
        }
        .form-control, .form-select {
            border-radius: 5px;
            padding: 10px;
            border: 1px solid #ced4da;
        }
        .form-control:focus, .form-select:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }
        .navbar {
            position: relative;
        }
        .centered-content {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 100px);
        }
    </style>
</head>

<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Hotel Booking</a>
        <a href="employeeLOGin.jsp" class="btn btn-employee">
            <i class="fas fa-user-tie me-2"></i>Employee Login
        </a>
    </div>
</nav>

<div class="centered-content">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6 search-container">
                <h2 class="form-title">Find Your Perfect Hotel</h2>

                <form action="hotelChain.jsp" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="bookingStartDate" class="form-label">Booking Start Date</label>
                            <input type="date" class="form-control" id="bookingStartDate" name="bookingStartDate" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="bookingEndDate" class="form-label">Booking End Date</label>
                            <input type="date" class="form-control" id="bookingEndDate" name="bookingEndDate" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="roomCapacity" class="form-label">Room Capacity</label>
                            <input type="number" class="form-control" id="roomCapacity" name="roomCapacity" placeholder="Number of guests">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="hotelArea" class="form-label">Hotel Area</label>
                            <input type="text" class="form-control" id="hotelArea" name="hotelArea" placeholder="City or region">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="hotelChain" class="form-label">Hotel Chain</label>
                            <input type="text" class="form-control" id="hotelChain" name="hotelChain" placeholder="Chain name (optional)">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="hotelRating" class="form-label">Minimum Rating</label>
                            <select class="form-select" id="hotelRating" name="hotelRating">
                                <option value="">Any rating</option>
                                <option value="1">★☆☆☆☆ (1 Star)</option>
                                <option value="2">★★☆☆☆ (2 Star)</option>
                                <option value="3">★★★☆☆ (3 Star)</option>
                                <option value="4">★★★★☆ (4 Star)</option>
                                <option value="5">★★★★★ (5 Star)</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="numberOfRooms" class="form-label">Number of Rooms</label>
                            <input type="number" class="form-control" id="numberOfRooms" name="numberOfRooms" placeholder="How many rooms?">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="hotelPrice" class="form-label">Maximum Price (per night)</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" class="form-control" id="hotelPrice" name="hotelPrice" placeholder="Your budget">
                            </div>
                        </div>
                    </div>

                    <div class="d-grid mt-4">
                        <button type="submit" class="btn btn-submit">
                            <i class="fas fa-search me-2"></i>Search Hotels
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<input type="hidden" id="message" value="<%= msgField %>">

<script src="/assets/js/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

<script>
    $(document).ready(function() {
        toastr.options = {
            "closeButton": true,
            "positionClass": "toast-bottom-right",
            "preventDuplicates": false
        };
        /* In order to access variables sent to ejs file to script you must Parse them to string */
        /* then to parse them back to JSON */
        let messages = document.getElementById("message").value;
        if (messages !== "") messages = JSON.parse("[" + messages.slice(0, -1) + "]");
        else messages = [];

        messages
            .forEach(({
                          type,
                          value
                      }) => {
                switch (type) {
                    case "error":
                        toastr.error(value)
                        break;
                    case "success":
                        toastr.success(value)
                        break;
                    case "warning":
                        toastr.warning(value)
                        break;
                    default:
                        toastr.info(value)
                        break;
                }
            });
    });
</script>

<script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>