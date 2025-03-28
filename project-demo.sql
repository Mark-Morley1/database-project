-- Hotel Chains Table
CREATE TABLE HotelChain (
                            ChainID SERIAL PRIMARY KEY,
                            Name VARCHAR(255) NOT NULL,
                            CentralOfficeAddress TEXT NOT NULL,
                            NumberOfHotels INT DEFAULT 0,
                            ContactEmail VARCHAR(255),
                            ContactPhone VARCHAR(20)
);

-- Hotels Table
CREATE TABLE Hotel (
                       HotelID SERIAL PRIMARY KEY,
                       ChainID INT NOT NULL,
                       Name VARCHAR(255) NOT NULL,
                       Address TEXT NOT NULL,
                       ContactEmail VARCHAR(255),
                       ContactPhone VARCHAR(20),
                       Rating INT CHECK (Rating BETWEEN 1 AND 5),
                       NumberOfRooms INT DEFAULT 0,
                       Area VARCHAR(255) NOT NULL,
                       FOREIGN KEY (ChainID) REFERENCES HotelChain(ChainID) ON DELETE CASCADE
);

-- Rooms Table
CREATE TABLE Room (
                      RoomID SERIAL PRIMARY KEY,
                      HotelID INT NOT NULL,
                      Price DECIMAL(10,2) NOT NULL,
                      Capacity VARCHAR(20) CHECK (Capacity IN ('Single', 'Double', 'Suite', 'Family')),
                      View VARCHAR(20) CHECK (View IN ('Sea', 'Mountain', 'None')),
    Extendable BOOLEAN,
    Amenities TEXT,
    DamageDescription TEXT,
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID) ON DELETE CASCADE
);

-- Customers Table
CREATE TABLE Customer (
                          CustomerID SERIAL PRIMARY KEY,
                          FullName VARCHAR(255) NOT NULL,
                          Address TEXT NOT NULL,
                          IDType VARCHAR(20) CHECK (IDType IN ('SSN', 'SIN', 'Driving License')),
                          IDNumber VARCHAR(50) UNIQUE NOT NULL,
                          RegistrationDate DATE NOT NULL
);

-- Employees Table
CREATE TABLE Employee (
                          EmployeeID SERIAL PRIMARY KEY,
                          HotelID INT NOT NULL,
                          FullName VARCHAR(255) NOT NULL,
                          Address TEXT NOT NULL,
                          SSN_SIN VARCHAR(50) UNIQUE NOT NULL,
                          Position VARCHAR(255) NOT NULL,
                          FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID) ON DELETE CASCADE
);

-- Bookings Table
CREATE TABLE Booking (
                         BookingID SERIAL PRIMARY KEY,
                         CustomerID INT NOT NULL,
                         RoomID INT NOT NULL,
                         StartDate DATE NOT NULL,
                         EndDate DATE NOT NULL,
                         Status VARCHAR(20) CHECK (Status IN ('Booked', 'Rented', 'Completed')) NOT NULL,
                         FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
                         FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

-- Renting Table
CREATE TABLE Renting (
                         RentingID SERIAL PRIMARY KEY,
                         CustomerID INT NOT NULL,
                         RoomID INT NOT NULL,
                         EmployeeID INT NOT NULL,
                         StartDate DATE NOT NULL,
                         EndDate DATE NOT NULL,
                         Status VARCHAR(20) CHECK (Status IN ('Active', 'Completed')) NOT NULL,
                         FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
                         FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
                         FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Archive for Bookings
CREATE TABLE BookingArchive (
                                ArchiveID SERIAL PRIMARY KEY,
                                BookingID INT,
                                CustomerID INT,
                                RoomID INT,
                                StartDate DATE,
                                EndDate DATE,
                                Status VARCHAR(20) CHECK (Status IN ('Booked', 'Cancelled', 'Completed')),
                                FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) ON DELETE SET NULL
);

-- Archive for Rentings
CREATE TABLE RentingArchive (
                                ArchiveID SERIAL PRIMARY KEY,
                                RentingID INT,
                                CustomerID INT,
                                RoomID INT,
                                EmployeeID INT,
                                StartDate DATE,
                                EndDate DATE,
                                Status VARCHAR(20) CHECK (Status IN ('Active', 'Completed')),
                                FOREIGN KEY (RentingID) REFERENCES Renting(RentingID) ON DELETE SET NULL
);


INSERT INTO Hotel (ChainID, Name, Address, ContactEmail, ContactPhone, Rating, NumberOfRooms, Area)
VALUES
    (1, 'HotelName1', 'HotelAddress1', 'hotel1@example.com', '123-456-7890', 4, 100, 'Downtown'),
    (1, 'HotelName2', 'HotelAddress2', 'hotel2@example.com', '123-456-7891', 5, 120, 'City Center'),
    (2, 'HotelName3', 'HotelAddress3', 'hotel3@example.com', '123-456-7892', 3, 80, 'Uptown'),
    (2, 'HotelName4', 'HotelAddress4', 'hotel4@example.com', '123-456-7893', 4, 90, 'Suburban'),
    (3, 'HotelName5', 'HotelAddress5', 'hotel5@example.com', '123-456-7894', 5, 150, 'Beachside'),
    (3, 'HotelName6', 'HotelAddress6', 'hotel6@example.com', '123-456-7895', 2, 60, 'Beachside'),
    (4, 'HotelName7', 'HotelAddress7', 'hotel7@example.com', '123-456-7896', 3, 70, 'Near Airport'),
    (4, 'HotelName8', 'HotelAddress8', 'hotel8@example.com', '123-456-7897', 4, 110, 'Business District');

INSERT INTO Room (HotelID, Price, Capacity, View, Extendable, Amenities, DamageDescription) VALUES
                                                                                                -- Rooms for Hotel 69
                                                                                                (1, 120.00, 'Single', 'None', FALSE, 'WiFi, TV, Mini-Fridge', NULL),
                                                                                                (1, 150.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony, Mini-Fridge', NULL),
                                                                                                (1, 200.00, 'Suite', 'Mountain', TRUE, 'WiFi, TV, Kitchen, Jacuzzi', NULL),
                                                                                                (1, 130.00, 'Family', 'None', FALSE, 'WiFi, TV, Sofa Bed', NULL),
                                                                                                (1, 180.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL),

                                                                                                -- Rooms for Hotel 70
                                                                                                (2, 110.00, 'Single', 'Mountain', FALSE, 'WiFi, TV, Air Conditioning', NULL),
                                                                                                (2, 140.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony', NULL),
                                                                                                (2, 190.00, 'Suite', 'None', TRUE, 'WiFi, TV, Kitchen, Bathtub', NULL),
                                                                                                (2, 125.00, 'Family', 'Mountain', FALSE, 'WiFi, TV, Sofa Bed', NULL),
                                                                                                (2, 175.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL),

                                                                                                -- Rooms for Hotel 71
                                                                                                (3, 100.00, 'Single', 'None', FALSE, 'WiFi, TV, Mini-Fridge', 'Scratched Desk'),
                                                                                                (3, 130.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony, Mini-Fridge', NULL),
                                                                                                (3, 210.00, 'Suite', 'Mountain', TRUE, 'WiFi, TV, Kitchen, Jacuzzi', NULL),
                                                                                                (3, 140.00, 'Family', 'None', FALSE, 'WiFi, TV, Sofa Bed', 'Broken Lamp'),
                                                                                                (3, 170.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL),

                                                                                                -- Rooms for Hotel 72
                                                                                                (4, 125.00, 'Single', 'Mountain', FALSE, 'WiFi, TV, Air Conditioning', NULL),
                                                                                                (4, 135.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony', NULL),
                                                                                                (4, 220.00, 'Suite', 'None', TRUE, 'WiFi, TV, Kitchen, Bathtub', 'Cracked Window'),
                                                                                                (4, 145.00, 'Family', 'Mountain', FALSE, 'WiFi, TV, Sofa Bed', NULL),
                                                                                                (4, 160.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL),

                                                                                                -- Rooms for Hotel 73
                                                                                                (5, 105.00, 'Single', 'None', FALSE, 'WiFi, TV, Mini-Fridge', NULL),
                                                                                                (5, 145.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony, Mini-Fridge', NULL),
                                                                                                (5, 230.00, 'Suite', 'Mountain', TRUE, 'WiFi, TV, Kitchen, Jacuzzi', 'Loose Door Handle'),
                                                                                                (5, 135.00, 'Family', 'None', FALSE, 'WiFi, TV, Sofa Bed', NULL),
                                                                                                (5, 185.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL),

                                                                                                -- Rooms for Hotel 74
                                                                                                (6, 95.00, 'Single', 'Mountain', FALSE, 'WiFi, TV, Air Conditioning', NULL),
                                                                                                (6, 155.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony', NULL),
                                                                                                (6, 240.00, 'Suite', 'None', TRUE, 'WiFi, TV, Kitchen, Bathtub', NULL),
                                                                                                (6, 115.00, 'Family', 'Mountain', FALSE, 'WiFi, TV, Sofa Bed', NULL),
                                                                                                (6, 195.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL),

                                                                                                -- Rooms for Hotel 75
                                                                                                (7, 130.00, 'Single', 'None', FALSE, 'WiFi, TV, Mini-Fridge', 'Stained Carpet'),
                                                                                                (7, 165.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony, Mini-Fridge', NULL),
                                                                                                (7, 250.00, 'Suite', 'Mountain', TRUE, 'WiFi, TV, Kitchen, Jacuzzi', NULL),
                                                                                                (7, 155.00, 'Family', 'None', FALSE, 'WiFi, TV, Sofa Bed', NULL),
                                                                                                (7, 205.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL),

                                                                                                -- Rooms for Hotel 76
                                                                                                (8, 120.00, 'Single', 'Mountain', FALSE, 'WiFi, TV, Air Conditioning', NULL),
                                                                                                (8, 175.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony', NULL),
                                                                                                (8, 260.00, 'Suite', 'None', TRUE, 'WiFi, TV, Kitchen, Bathtub', 'Leaky Faucet'),
                                                                                                (8, 165.00, 'Family', 'Mountain', FALSE, 'WiFi, TV, Sofa Bed', NULL),
                                                                                                (8, 215.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL);


INSERT INTO hotelchain (chainid, name, centralofficeaddress, numberofhotels, contactemail, contactphone)
VALUES
    (1, 'Luxury Stays', '100 Main St, New York, USA', 8, 'contact@luxurystays.com', '+1-555-1000'),
    (2, 'Comfort Inns', '200 Lake Rd, Toronto, Canada', 8, 'info@comfortinns.com', '+1-555-2000'),
    (3, 'Royal Resorts', '300 Sunset Blvd, Miami, USA', 8, 'support@royalresorts.com', '+1-555-3000'),
    (4, 'Elite Hotels', '400 Ocean Dr, Vancouver, Canada', 8, 'help@elitehotels.com', '+1-555-4000'),
    (5, 'Global Retreats', '500 Mountain Ave, Denver, USA', 8, 'global@retreats.com', '+1-555-5000');



INSERT INTO Employee (HotelID, FullName, Address, SSN_SIN, Position)
VALUES
    (1, 'Alice Thompson', '100 Elm St, Ottawa, ON', '111223333', 'General Manager'),
    (2, 'Brian White', '200 Oak St, Toronto, ON', '222334444', 'Front Desk Clerk'),
    (3, 'Catherine Green', '300 Pine St, Montreal, QC', '333445555', 'Housekeeper'),
    (4, 'David Black', '400 Birch St, Vancouver, BC', '444556666', 'Chef'),
    (5, 'Emma Harris', '500 Maple St, Calgary, AB', '555667777', 'Bartender'),
    (6, 'Frank Robinson', '600 Cedar St, Halifax, NS', '666778888', 'Concierge'),
    (7, 'Grace Lewis', '700 Willow St, Winnipeg, MB', '777889999', 'Security Officer'),
    (8, 'Henry Walker', '800 Spruce St, Edmonton, AB', '888990000', 'Maintenance Supervisor');

-- Example Customer Insertions

INSERT INTO Customer (FullName, Address, IDType, IDNumber, RegistrationDate)
VALUES
    ('John Doe', '123 Maple St, Ottawa, ON', 'SSN', '123-45-6789', '2025-03-01'),
    ('Jane Smith', '456 Oak St, Toronto, ON', 'SIN', '987-65-4321', '2025-03-02'),
    ('Michael Johnson', '789 Pine St, Montreal, QC', 'Driving License', 'B1234567', '2025-03-03'),
    ('Emily Davis', '101 Birch St, Calgary, AB', 'SSN', '555-66-7777', '2025-03-04'),
    ('Robert Brown', '202 Cedar St, Vancouver, BC', 'SIN', '111-22-3333', '2025-03-05');

INSERT INTO Booking (CustomerID, RoomID, StartDate, EndDate, Status)
VALUES
    (1, 41, '2025-04-01', '2025-04-05', 'Booked');

