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
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
</head>

<body>



<jsp:include page="navbar.jsp"/>

<form action="hotelChain.jsp" method="post">
    <label for="bookingStartDate">Booking Start Date:</label><br>
    <input type="date" id="bookingStartDate" name="bookingStartDate" required><br><br>

    <label for="bookingEndDate">Booking End Date:</label><br>
    <input type="date" id="bookingEndDate" name="bookingEndDate" required><br><br>

    <label for="roomCapacity">Hotel Capacity:</label><br>
    <input type="text" id="roomCapacity" name="roomCapacity" ><br><br>

    <label for="hotelArea">Hotel Area:</label><br>
    <input type="text" id="hotelArea" name="hotelArea" ><br><br>

    <label for="hotelChain">Hotel Chain:</label><br>
    <input type="text" id="hotelChain" name="hotelChain" ><br><br>

    <label for="hotelRating">Hotel Rating:</label><br>

    <select id="hotelRating" name="hotelRating">
        <option value="1Star">1 Star</option>
        <option value="2Star">2 Star</option>
        <option value="3Star">3 Star</option>
        <option value="4Star">4 Star</option>
        <option value="4Star">5 Star</option>
    </select><br><br>

    <label for="numberOfRooms">Number Of Rooms:</label><br>
    <input type="text" id="numberOfRooms" name="numberOfRooms" ><br><br>

    <label for="hotelPrice">Hotel Price:</label><br>
    <input type="text" id="hotelPrice" name="hotelPrice" ><br><br>

    <button type="submit" class="btn btn-primary">Submit</button>

</form>

<form action="employeeLOGin.jsp" method="post">
    <button type="employee login" class="btn login">employee login</button>
</form>

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
    })
</script>

</body>

</html>