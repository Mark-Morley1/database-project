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


INSERT INTO Hotel VALUES (
    (1, 'Hotel 1', 3, 'Address 1', 42, 'hotel1@gmail.com', '401-555-1001', 'Ottawa')
    (1,'Hotel 2', 5, 'Address 2', 15, 'hotel2@gmail.com', '401-555-1002', 'Toronto'),
    (1, 'Hotel 3', 2, 'Address 3', 30, 'hotel3@gmail.com', '401-555-1003', 'Calgary'),
    (1, 'Hotel 4', 4, 'Address 4', 50, 'hotel4@gmail.com', '401-555-1004', 'Vancouver'),
    (1, 'Hotel 5', 1, 'Address 5', 25, 'hotel5@gmail.com', '401-555-1005', 'Montreal'),
    (1, 'Hotel 6', 3, 'Address 6', 38, 'hotel6@gmail.com', '401-555-1006', 'Toronto'),
    (1, 'Hotel 7', 5, 'Address 7', 12, 'hotel7@gmail.com', '401-555-1007', 'Edmonton'),
    (1, 'Hotel 8', 2, 'Address 8', 47, 'hotel8@gmail.com', '401-555-1008', 'Ottawa'),

    (2, 'Hotel 9', 4, 'Address 9', 33, 'hotel9@gmail.com', '402-555-1009', 'Vancouver'),
    (2, 'Hotel 10', 1, 'Address 10', 20, 'hotel10@gmail.com', '402-555-1010', 'Edmonton'),
    (2, 'Hotel 11', 3, 'Address 11', 44, 'hotel11@gmail.com', '402-555-1011', 'Halifax'),
    (2, 'Hotel 12', 5, 'Address 12', 14, 'hotel12@gmail.com', '402-555-1012', 'Calgary'),
    (2, 'Hotel 13', 2, 'Address 13', 28, 'hotel13@gmail.com', '402-555-1013', 'Winnipeg'),
    (2, 'Hotel 14', 4, 'Address 14', 39, 'hotel14@gmail.com', '402-555-1014', 'Montreal'),
    (2, 'Hotel 15', 1, 'Address 15', 50, 'hotel15@gmail.com', '402-555-1015', 'Halifax'),
    (2, 'Hotel 16', 5, 'Address 16', 17, 'hotel16@gmail.com', '402-555-1016', 'Winnipeg'),
    (3, 'Hotel 17', 2, 'Address 17', 42, 'hotel17@gmail.com', '403-555-1017', 'Toronto'),
    (3, 'Hotel 18', 3, 'Address 18', 22, 'hotel18@gmail.com', '403-555-1018', 'Quebec City'),
    (3, 'Hotel 19', 5, 'Address 19', 33, 'hotel19@gmail.com', '403-555-1019', 'Saskatoon'),
    (3, 'Hotel 20', 1, 'Address 20', 15, 'hotel20@gmail.com', '403-555-1020', 'Victoria'),
    (3, 'Hotel 21', 4, 'Address 21', 48, 'hotel21@gmail.com', '403-555-1021', 'Quebec City'),
    (3, 'Hotel 22', 2, 'Address 22', 10, 'hotel22@gmail.com', '403-555-1022', 'Vancouver'),
    (3, 'Hotel 23', 3, 'Address 23', 37, 'hotel23@gmail.com', '403-555-1023', 'Regina'),
    (3, 'Hotel 24', 5, 'Address 24', 28, 'hotel24@gmail.com', '403-555-1024', 'Saskatoon'),

    (4, 'Hotel 25', 1, 'Address 25', 46, 'hotel25@gmail.com', '404-555-1025', 'St. John’s'),
    (4, 'Hotel 26', 3, 'Address 26', 12, 'hotel26@gmail.com', '404-555-1026', 'Fredericton'),
    (4, 'Hotel 27', 5, 'Address 27', 33, 'hotel27@gmail.com', '404-555-1027', 'Charlottetown'),
    (4, 'Hotel 28', 4, 'Address 28', 22, 'hotel28@gmail.com', '404-555-1028', 'Quebec City'),
    (4, 'Hotel 29', 2, 'Address 29', 39, 'hotel29@gmail.com', '404-555-1029', 'Regina'),
    (4, 'Hotel 30', 1, 'Address 30', 30, 'hotel30@gmail.com', '404-555-1030', 'Montreal'),
    (4, 'Hotel 31', 4, 'Address 31', 18, 'hotel31@gmail.com', '404-555-1031', 'Fredericton'),
    (4, 'Hotel 32', 5, 'Address 32', 44, 'hotel32@gmail.com', '404-555-1032', 'Charlottetown'),
    (5, 'Hotel 33', 2, 'Address 33', 25, 'hotel33@gmail.com', '405-555-1033', 'Thunder Bay'),
    (5, 'Hotel 34', 4, 'Address 34', 31, 'hotel34@gmail.com', '405-555-1034', 'Yellowknife'),
    (5, 'Hotel 35', 1, 'Address 35', 45, 'hotel35@gmail.com', '405-555-1035', 'Iqaluit'),
    (5, 'Hotel 36', 5, 'Address 36', 14, 'hotel36@gmail.com', '405-555-1036', 'Sudbury'),
    (5, 'Hotel 37', 3, 'Address 37', 50, 'hotel37@gmail.com', '405-555-1037', 'Thunder Bay'),
    (5, 'Hotel 38', 2, 'Address 38', 29, 'hotel38@gmail.com', '405-555-1038', 'Vancouver'),
    (5, 'Hotel 39', 4, 'Address 39', 17, 'hotel39@gmail.com', '405-555-1039', 'Iqaluit'),
    (5, 'Hotel 40', 5, 'Address 40', 40, 'hotel40@gmail.com', '405-555-1040', 'Sudbury'));