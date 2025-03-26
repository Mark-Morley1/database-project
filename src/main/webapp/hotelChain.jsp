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

    // retrieve hotels and hotel chains from database
    HotelChainConnection hotelChainConnectionService = new HotelChainConnection();
    HotelConnection hotelConnection = new HotelConnection();
    RoomConnection roomConnection = new RoomConnection();
    List<HotelChain> hotelChainList = null;
    List<Hotel> hotels = null;
    List<Room> rooms = null;

    //get info from user
    String bookingStartDate = request.getParameter("bookingStartDate");
    String bookingEndDate = request.getParameter("bookingEndDate");
    String roomCapacity = request.getParameter("roomCapacity");
    String hotelArea = request.getParameter("hotelArea");
    String hotelChain= request.getParameter("hotelChain");
    String hotelRating= request.getParameter("hotelRating");
    String numberOfRooms = request.getParameter("numberOfRooms");
    String hotelPrice = request.getParameter("hotelPrice");

    try {
        hotelChainList = hotelChainConnectionService.getHotelChains();
        hotels = hotelConnection.getHotels();
        rooms = roomConnection.getRooms();

    } catch (Exception e) {
        e.printStackTrace();
    }

    //filter the lists of hotels


    if(hotels != null){

        for(Hotel hotel: hotels){



        }

    }



%>
<input type="hidden" name="message" id="message" value='<%=msgField%>' >
<div class="container">
    <div class="row" id="row">
        <div class="col-md-12">
            <div class="card" id="card-container">
                <div class="card-body" id="card">
                    <% if (hotels != null && hotels.size() == 0) { %>
                    <h1 style="margin-top: 5rem;">No Hotels found!</h1>
                    <% } else { %>
                    <!--<h1 style="margin-top: 5rem;"><bookingStartDate%></h1>-->
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Hotel Name</th>
                                <th>Address</th>
                                <th>Number of Hotels</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th></th>

                            </tr>
                            </thead>
                            <tbody>
                            <%
                                for (HotelChain hotel : hotelChainList) { %>

                            <tr>
                                <td><%= hotel.getChainID() %></td>
                                <td><%= hotel.getName() %></td>
                                <td><%= hotel.getCentralOfficeAddress() %></td>
                                <td><%= hotel.getNumberOfHotels() %></td>
                                <td><%= hotel.getContactEmail() %></td>
                                <td><%= hotel.getContactPhone() %></td>
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