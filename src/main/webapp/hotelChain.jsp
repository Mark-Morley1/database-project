<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.demo.*" %><%--
  Created by IntelliJ IDEA.
  User: markmorley
  Date: 2025-03-25
  Time: 7:31 p.m.
  To change this template use File | Settings | File Templates.
--%>

<!DOCTYPE html>
<html lang="en">

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="navbar.jsp"/>
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

    // retrieve rooms from database
    RoomConnection roomConnection = new RoomConnection();
    List<Room> rooms = null;
    List<Criteria> availableRooms = new ArrayList<>();

    //get info from user
    String bookingStartDate = request.getParameter("bookingStartDate");
    String bookingEndDate = request.getParameter("bookingEndDate");
    String roomCapacity = request.getParameter("roomCapacity");
    String hotelArea = request.getParameter("hotelArea");
    String hotelChain= request.getParameter("hotelChain");
    String hotelRating= request.getParameter("hotelRating");
    String numberOfRooms = request.getParameter("numberOfRooms");
    String hotelPrice = request.getParameter("hotelPrice");

    if(roomCapacity.equals("")){
        roomCapacity = "";
    }
    if (numberOfRooms.equals("")){
        numberOfRooms = "9999";
    }
    if(hotelPrice.equals("")){
        hotelPrice = "0";
    }

    Criteria userCriteria = new Criteria(bookingStartDate,
            bookingEndDate,
            roomCapacity,
            hotelArea,
            hotelChain,
            Integer.parseInt(hotelRating),
            Integer.parseInt(numberOfRooms),
            Double.parseDouble(hotelPrice)
        );

    try {
        rooms = roomConnection.getRooms();

    } catch (Exception e) {
        e.printStackTrace();
    }

    //filter the lists of hotels

    if(rooms != null){

        for(Room room: rooms){
            Hotel currentHotel = roomConnection.getHotel(room.getHotelID());

            HotelConnection hotelConnection = new HotelConnection();

            HotelChain currentChain = hotelConnection.getHotelChain(currentHotel.getChainID());

            if(currentChain == null){
                continue;
            }
            Criteria currentAvailableRoom = new Criteria(bookingStartDate,
                bookingEndDate,
                room.getCapacity(),
                currentHotel.getArea(),
                currentChain.getName(),
                currentHotel.getNumberOfRooms(),
                currentHotel.getRating(),
                room.getPrice()
            );
            if(userCriteria.meetsRequirements(currentAvailableRoom)){
                availableRooms.add(currentAvailableRoom);
            }
        }

    }



%>
<input type="hidden" name="message" id="message" value='<%=msgField%>' >
<div class="container">
    <div class="row" id="row">
        <div class="col-md-12">
            <div class="card" id="card-container">
                <div class="card-body" id="card">
                    <% if (availableRooms == null || availableRooms.size() == 0) { %>
                    <h1 style="margin-top: 5rem;">No Hotels found!</h1>
                    <% } else { %>
                    <!--<h1 style="margin-top: 5rem;"><bookingStartDate%></h1>-->
                    <!--**Print the hotels here**-->
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>Capacity</th>
                                <th>Area</th>
                                <th>Name</th>
                                <th>Rating</th>
                                <th>Number of Rooms</th>
                                <th>Price</th>
                                <th></th>

                            </tr>
                            </thead>
                            <tbody>
                            <%
                                for (Criteria criteria : availableRooms) { %>

                            <tr>
                                <td><%= criteria.getHotelCapaciy() %></td>
                                <td><%= criteria.getHotelArea() %></td>
                                <td><%= criteria.getHotelChain() %></td>
                                <td><%= criteria.getNumberOfRooms() %></td>
                                <td><%= criteria.getHotelRating() %></td>
                                <td><%= criteria.getPrice() %></td>

                            </tr>

                            <% } %>
                            </tbody>
                        </table>
                    </div>
                    <%} %>
                </div>
            </div>
        </div>

    </div>
</div>