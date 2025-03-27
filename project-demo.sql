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
                       Rating INT CHECK (Category BETWEEN 1 AND 5),
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
                         Status VARCHAR(20) CHECK (Status IN ('Booked', 'Cancelled', 'Completed')) NOT NULL,
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
                                                                                                (69, 120.00, 'Single', 'None', FALSE, 'WiFi, TV, Mini-Fridge', NULL),
                                                                                                (69, 150.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony, Mini-Fridge', NULL),
                                                                                                (69, 200.00, 'Suite', 'Mountain', TRUE, 'WiFi, TV, Kitchen, Jacuzzi', NULL),
                                                                                                (69, 130.00, 'Family', 'None', FALSE, 'WiFi, TV, Sofa Bed', NULL),
                                                                                                (69, 180.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL),

                                                                                                -- Rooms for Hotel 70
                                                                                                (70, 110.00, 'Single', 'Mountain', FALSE, 'WiFi, TV, Air Conditioning', NULL),
                                                                                                (70, 140.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony', NULL),
                                                                                                (70, 190.00, 'Suite', 'None', TRUE, 'WiFi, TV, Kitchen, Bathtub', NULL),
                                                                                                (70, 125.00, 'Family', 'Mountain', FALSE, 'WiFi, TV, Sofa Bed', NULL),
                                                                                                (70, 175.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL),

                                                                                                -- Rooms for Hotel 71
                                                                                                (71, 100.00, 'Single', 'None', FALSE, 'WiFi, TV, Mini-Fridge', 'Scratched Desk'),
                                                                                                (71, 130.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony, Mini-Fridge', NULL),
                                                                                                (71, 210.00, 'Suite', 'Mountain', TRUE, 'WiFi, TV, Kitchen, Jacuzzi', NULL),
                                                                                                (71, 140.00, 'Family', 'None', FALSE, 'WiFi, TV, Sofa Bed', 'Broken Lamp'),
                                                                                                (71, 170.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL),

                                                                                                -- Rooms for Hotel 72
                                                                                                (72, 125.00, 'Single', 'Mountain', FALSE, 'WiFi, TV, Air Conditioning', NULL),
                                                                                                (72, 135.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony', NULL),
                                                                                                (72, 220.00, 'Suite', 'None', TRUE, 'WiFi, TV, Kitchen, Bathtub', 'Cracked Window'),
                                                                                                (72, 145.00, 'Family', 'Mountain', FALSE, 'WiFi, TV, Sofa Bed', NULL),
                                                                                                (72, 160.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL),

                                                                                                -- Rooms for Hotel 73
                                                                                                (73, 105.00, 'Single', 'None', FALSE, 'WiFi, TV, Mini-Fridge', NULL),
                                                                                                (73, 145.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony, Mini-Fridge', NULL),
                                                                                                (73, 230.00, 'Suite', 'Mountain', TRUE, 'WiFi, TV, Kitchen, Jacuzzi', 'Loose Door Handle'),
                                                                                                (73, 135.00, 'Family', 'None', FALSE, 'WiFi, TV, Sofa Bed', NULL),
                                                                                                (73, 185.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL),

                                                                                                -- Rooms for Hotel 74
                                                                                                (74, 95.00, 'Single', 'Mountain', FALSE, 'WiFi, TV, Air Conditioning', NULL),
                                                                                                (74, 155.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony', NULL),
                                                                                                (74, 240.00, 'Suite', 'None', TRUE, 'WiFi, TV, Kitchen, Bathtub', NULL),
                                                                                                (74, 115.00, 'Family', 'Mountain', FALSE, 'WiFi, TV, Sofa Bed', NULL),
                                                                                                (74, 195.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL),

                                                                                                -- Rooms for Hotel 75
                                                                                                (75, 130.00, 'Single', 'None', FALSE, 'WiFi, TV, Mini-Fridge', 'Stained Carpet'),
                                                                                                (75, 165.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony, Mini-Fridge', NULL),
                                                                                                (75, 250.00, 'Suite', 'Mountain', TRUE, 'WiFi, TV, Kitchen, Jacuzzi', NULL),
                                                                                                (75, 155.00, 'Family', 'None', FALSE, 'WiFi, TV, Sofa Bed', NULL),
                                                                                                (75, 205.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL),

                                                                                                -- Rooms for Hotel 76
                                                                                                (76, 120.00, 'Single', 'Mountain', FALSE, 'WiFi, TV, Air Conditioning', NULL),
                                                                                                (76, 175.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Balcony', NULL),
                                                                                                (76, 260.00, 'Suite', 'None', TRUE, 'WiFi, TV, Kitchen, Bathtub', 'Leaky Faucet'),
                                                                                                (76, 165.00, 'Family', 'Mountain', FALSE, 'WiFi, TV, Sofa Bed', NULL),
                                                                                                (76, 215.00, 'Double', 'Sea', TRUE, 'WiFi, TV, Coffee Maker', NULL);



