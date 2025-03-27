<%@ page import="com.demo.HotelChainConnection" %>
<%@ page import="com.demo.HotelChain" %>
<%@ page import="java.util.List" %>
<%@ page import="com.demo.Message" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.demo.HotelChain" %>
<%@ page import="com.demo.HotelChainConnection" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
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

    String customerID = request.getParameter("customerID");

    // retrieve grades from database
    HotelChainConnection hotelChainConnectionService = new HotelChainConnection();
    List<HotelChain> hotels = null;
    try {
        hotels = hotelChainConnectionService.getHotelChains();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Get current date and next day for default values
    LocalDate today = LocalDate.now();
    LocalDate tomorrow = today.plusDays(1);
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String todayStr = today.format(formatter);
    String tomorrowStr = tomorrow.format(formatter);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Search for Hotels</title>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&amp;family=Playfair+Display:wght@400;500;600;700&amp;display=swap" rel="stylesheet">

    <!-- Styles -->
    <link rel="stylesheet" href="styles/search.css">
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .search-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-top: 30px;
            margin-bottom: 30px;
        }

        .form-title {
            color: #2c3e50;
            margin-bottom: 25px;
            font-weight: 600;
            text-align: center;
            font-family: 'Playfair Display', serif;
        }

        .form-label {
            font-weight: 500;
            color: #495057;
            margin-bottom: 8px;
            display: block;
        }

        .fieldContainer {
            margin-bottom: 20px;
        }

        .form-control, .form-select {
            border-radius: 5px;
            padding: 10px;
            border: 1px solid #ced4da;
            width: 100%;
        }

        .form-control:focus, .form-select:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
        }

        .btn-submit {
            background-color: #3498db;
            border: none;
            padding: 12px 25px;
            font-weight: 500;
            width: 100%;
            color: white;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .btn-submit:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }

        .date-range {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .date-range-text {
            color: #6c757d;
            font-weight: 500;
        }

        .ratingFont {
            font-family: Arial, sans-serif;
        }

        .row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .row > div {
            flex: 1;
        }

        .full-width {
            width: 100%;
        }

        .centered-content {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 100px);
            padding: 20px;
        }
    </style>
</head>

<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Hotel Booking</a>
    </div>
</nav>

<div class="centered-content">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6 search-container">
                <h2 class="form-title">Find Your Perfect Hotel</h2>

                <form action="hotelChain.jsp" method="post">
                    <!-- Hotel Chain -->
                    <div class="fieldContainer">
                        <label for="hotelChain" class="form-label">Hotel Chain</label>
                        <input type="text" class="form-control" id="hotelChain" name="hotelChain" placeholder="Chain name (optional)">
                    </div>

                    <div class="row">
                        <!-- Area -->
                        <div class="fieldContainer">
                            <label for="hotelArea" class="form-label">Hotel Area</label>
                            <select class="form-select" id="hotelArea" name="hotelArea">
                                <option value="">Any area</option>
                                <option value="Downtown">Downtown</option>
                                <option value="City Center">City Center</option>
                                <option value="Uptown">Uptown</option>
                                <option value="Suburban">Suburban</option>
                                <option value="Beachside">Beachside</option>
                                <option value="Near Airport">Near Airport</option>
                                <option value="Business District">Business District</option>
                            </select>
                        </div>
                        <!-- Rating -->
                        <div class="fieldContainer">
                            <label for="hotelRating" class="form-label">Minimum Rating</label>
                            <select class="form-select" id="hotelRating" name="hotelRating">
                                <option class="ratingFont" value="0">Any rating</option>
                                <option class="ratingFont" value="1">★☆☆☆☆ (1 Star)</option>
                                <option class="ratingFont" value="2">★★☆☆☆ (2 Star)</option>
                                <option class="ratingFont" value="3">★★★☆☆ (3 Star)</option>
                                <option class="ratingFont" value="4">★★★★☆ (4 Star)</option>
                                <option class="ratingFont" value="5">★★★★★ (5 Star)</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Room Type -->
                        <div class="fieldContainer">
                            <label for="roomCapacity" class="form-label">Room Type</label>
                            <select class="form-select" id="roomCapacity" name="roomCapacity">
                                <option value="">Any room type</option>
                                <option value="Single">Single</option>
                                <option value="Double">Double</option>
                                <option value="Family">Family</option>
                                <option value="Suite">Suite</option>
                            </select>
                        </div>
                        <!-- Number of Rooms -->
                        <div class="fieldContainer">
                            <label for="numberOfRooms" class="form-label">Number of Rooms</label>
                            <input type="number" class="form-control" id="numberOfRooms" name="numberOfRooms"
                                   placeholder="How many rooms?" min="0" value="1">
                        </div>
                    </div>

                    <!-- Hotel Price -->
                    <div class="fieldContainer">
                        <label for="hotelPrice" class="form-label">Maximum Price (per night)</label>
                        <div class="input-group">
                            <span class="input-group-text">$</span>
                            <input type="number" class="form-control" id="hotelPrice" name="hotelPrice"
                                   placeholder="Your budget" min="0">
                        </div>
                    </div>

                    <!-- Date Range -->
                    <div class="fieldContainer full-width">
                        <label class="form-label">Booking Dates</label>
                        <div class="date-range">
                            <input type="date" class="form-control date-picker" id="bookingStartDate"
                                   name="bookingStartDate" value="<%= todayStr %>" required>
                            <span class="date-range-text">to</span>
                            <input type="date" class="form-control date-picker" id="bookingEndDate"
                                   name="bookingEndDate" value="<%= tomorrowStr %>" required>
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

        messages.forEach(({
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