<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.demo.*" %><%--
  Created by IntelliJ IDEA.
  User: frank wu
  Date: 2025-03-26
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
    String customerID = request.getParameter("customerID");
    String roomID = request.getParameter("roomID");
    String bookingStartDate = request.getParameter("bookingStartDate");
    String bookingEndDate = request.getParameter("bookingEndDate");
    BookingConnection bookingConnection = new BookingConnection();
    System.out.println(roomID);

     try {
        bookingConnection.createBooking(Integer.valueOf(customerID), Integer.valueOf(roomID), bookingStartDate, bookingEndDate);

    } catch (Exception e) {
        e.printStackTrace();
    }



%>


<input type="hidden" name="message" id="message" value='<%=msgField%>' >
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

<style>
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

