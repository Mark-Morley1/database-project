<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.demo.*" %>

<!DOCTYPE html>
<html lang="en">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="navbar.jsp"/>

    <%
    ArrayList<Message> messages;
    // Get messages from session; if not available, initialize an empty list
    if (session.getAttribute("messages") == null) {
        messages = new ArrayList<>();
    } else {
        messages = (ArrayList<Message>) session.getAttribute("messages");
    }

    String msgField = "";
    for (Message m : messages) {
        msgField += "{\"type\":\"" + m.type + "\",\"value\":\"" + m.value.replaceAll("['\"]+", "") + "\"},";
    }

    // Clear messages from session
    session.setAttribute("messages", new ArrayList<Message>());

    String customerID = request.getParameter("customerID");
    String roomID = request.getParameter("roomID");
    String bookingStartDate = request.getParameter("bookingStartDate");
    String bookingEndDate = request.getParameter("bookingEndDate");
    System.out.println(customerID);

    BookingConnection bookingConnection = new BookingConnection();

        if (bookingConnection.createBooking(Integer.parseInt(roomID), Integer.parseInt(customerID), bookingStartDate, bookingEndDate)) {
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

    <% } else { %>
<input type="hidden" name="message" id="message" value='<%=msgField%>' >
<div class="container">
    <div class="row" id="row">
        <div class="col-md-12">
            <div class="card" id="card-container">
                <div class="card-body" id="card">
                    <div class="error-header">
                        <h1>Booking Failed!</h1>
                        <h1>This Room is Already Booked For The Time Provided</h1>
                        <div class="error-icon">
                            <i class="fas fa-exclamation-circle"></i>
                        </div>
                        <p class="error-message">An error occurred while processing your booking. Please try again later.</p>
                    </div>
                    <div class="error-actions">
                        <button onclick="window.history.back()" class="btn btn-danger">
                            <i class="fas fa-arrow-left"></i> Go Back
                        </button>
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
    .error-header {
        text-align: center;
        margin: 2rem 0;
        padding: 1rem;
        background-color: #f8d7da;
        border-radius: 5px;
    }

    .error-icon {
        font-size: 5rem;
        color: #dc3545;
        margin: 1rem 0;
    }

    .error-message {
        font-size: 1.2rem;
        color: #721c24;
    }

    .error-actions {
        text-align: center;
        margin: 2rem 0;
    }

    .error-actions .btn {
        margin: 0 0.5rem;
    }

    h1 {
        color: #343a40;
        margin-bottom: 1rem;
    }
</style>
    <% } %>
