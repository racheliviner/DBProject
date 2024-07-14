-- Create Person table
CREATE TABLE Person (
    Person_ID INT PRIMARY KEY,
    Person_Name VARCHAR(255)
);

-- Create Client table inheriting from Person
CREATE TABLE Client (
    Person_ID INT PRIMARY KEY,
    FOREIGN KEY (Person_ID) REFERENCES Person(Person_ID)
);

-- Create Worker table inheriting from Person
CREATE TABLE Worker (
    Person_ID INT PRIMARY KEY,
    Start_of_Work_Date DATE,
    FOREIGN KEY (Person_ID) REFERENCES Person(Person_ID)
);

-- Create Supplier table inheriting from Person
CREATE TABLE Supplier (
    Person_ID INT PRIMARY KEY,
    Region VARCHAR(255),
    FOREIGN KEY (Person_ID) REFERENCES Person(Person_ID)
);

-- Create Subscribers table inheriting from Client
CREATE TABLE Subscribers (
    Person_ID INT PRIMARY KEY,
    DiscountPercent DECIMAL(5, 2),
    ExpirationDate DATE,
    FOREIGN KEY (Person_ID) REFERENCES Client(Person_ID)
);

-- Create Category table with the new category 'Movies'
CREATE TABLE Category (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR(255)
);

-- Insert new category 'Movies' into Category table
INSERT INTO Category (Category_ID, Category_Name) VALUES (1, 'Movies');

-- Create Products table
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(255),
    Quantity INT,
    Product_Price DECIMAL(10, 2),
    Category_ID INT,
    FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID)
);

-- Create Store_Products table inheriting from Products
CREATE TABLE Store_Products (
    Product_ID INT PRIMARY KEY,
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Create Tickets table inheriting from Products
CREATE TABLE Tickets (
    Product_ID INT PRIMARY KEY,
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- Create Movies table
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(255),
    Genre VARCHAR(255),
    Director VARCHAR(255),
    ReleaseDate DATE,
    Duration INT,
    Rating DECIMAL(3, 2)
);

-- Create Dates table
CREATE TABLE Dates (
    DateID INT PRIMARY KEY,
    HourH TIME,
    DayD VARCHAR(255),
    DateD DATE
);

-- Create Theaters table
CREATE TABLE Theaters (
    TheaterID INT PRIMARY KEY,
    TheaterName VARCHAR(255),
    Capacity INT
);

-- Create Orders table
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Order_Date DATE,
    Delivery_Date DATE
);

-- Create Purchases table
CREATE TABLE Purchases (
    Purchase_ID INT PRIMARY KEY,
    Purchase_Date DATE,
    Delivery_Date DATE
);

-- Create Order_Supplier relation
CREATE TABLE Order_Supplier (
    Supplier_ID INT,
    Order_ID INT,
    PRIMARY KEY (Supplier_ID, Order_ID),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Person_ID),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

-- Create Order_Worker relation
CREATE TABLE Order_Worker (
    Worker_ID INT,
    Order_ID INT,
    PRIMARY KEY (Worker_ID, Order_ID),
    FOREIGN KEY (Worker_ID) REFERENCES Worker(Person_ID),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

-- Create Purchase_Worker relation
CREATE TABLE Purchase_Worker (
    Worker_ID INT,
    Purchase_ID INT,
    PRIMARY KEY (Worker_ID, Purchase_ID),
    FOREIGN KEY (Worker_ID) REFERENCES Worker(Person_ID),
    FOREIGN KEY (Purchase_ID) REFERENCES Purchases(Purchase_ID)
);

-- Create Purchase_Client relation
CREATE TABLE Purchase_Client (
    Client_ID INT,
    Purchase_ID INT,
    PRIMARY KEY (Client_ID, Purchase_ID),
    FOREIGN KEY (Client_ID) REFERENCES Client(Person_ID),
    FOREIGN KEY (Purchase_ID) REFERENCES Purchases(Purchase_ID)
);

-- Create Order_Product relation
CREATE TABLE Order_Product (
    Product_ID INT,
    Order_ID INT,
    PRIMARY KEY (Product_ID, Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

-- Create Purchase_Product relation
CREATE TABLE Purchase_Product (
    Product_ID INT,
    Purchase_ID INT,
    PRIMARY KEY (Product_ID, Purchase_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID),
    FOREIGN KEY (Purchase_ID) REFERENCES Purchases(Purchase_ID)
);
