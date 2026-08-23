-- MarketHub - E-Commerce Sales Analytics Project
-- Database: MySQL
-- Purpose: Create database, tables and insert sample data



-- 1. CREATE DATABASE


CREATE DATABASE MarketHub;

-- Select MarketHub database for the project
USE MarketHub;


-- 2. CREATE CUSTOMERS TABLE
-- Stores information about customers


CREATE TABLE Customers(
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(50),
    PhoneNo VARCHAR(50),
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    ZIPcode VARCHAR(50),
    Country VARCHAR(50),

    -- Automatically stores the date and time
    -- when the customer record is created
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- 3. CREATE CATEGORIES TABLE
-- Stores different product categories


CREATE TABLE Categories(
    CategoryId INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    Description VARCHAR(255)
);


-- 4. CREATE PRODUCTS TABLE
-- Stores products available in the e-commerce store
-- CategoryId connects each product to a category


CREATE TABLE Products(
    ProductId INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    CategoryId INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT DEFAULT 0,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,

    -- Creates a relationship between Products and Categories
    FOREIGN KEY (CategoryId)
    REFERENCES Categories(CategoryId)
);


-- 5. CREATE ORDERS TABLE
-- Stores information about customer orders
-- CustomerId connects each order to a customer


CREATE TABLE Orders(
    OrderId INT AUTO_INCREMENT PRIMARY KEY,
    CustomerId INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10,2),

    -- Creates a relationship between Orders and Customers
    FOREIGN KEY (CustomerId)
    REFERENCES Customers(CustomerID)
);



-- 6. CREATE ORDER ITEMS TABLE
-- Stores individual products included in each order


CREATE TABLE OrderItems(
    OrderItemId INT AUTO_INCREMENT PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,

    -- Connects OrderItems to Orders
    FOREIGN KEY (OrderId)
    REFERENCES Orders(OrderId),

    -- Connects OrderItems to Products
    FOREIGN KEY (ProductId)
    REFERENCES Products(ProductId)
);


-- 7. INSERT CATEGORY DATA
-- Adds sample product categories


INSERT INTO Categories(CategoryName, Description)
VALUES
('Electronics','Electronic gadgets'),
('Clothing','Fashion products'),
('Books','Books and magazines'),
('Home Appliances','Home appliances'),
('Sports','Sports equipment');


-- 8. INSERT PRODUCT DATA
-- Adds sample products and connects them to categories


INSERT INTO Products(ProductName, CategoryID, Price, Stock)
VALUES
('Smartphone', 1, 699.99, 50),
('Laptop', 1, 999.99, 30),
('T-shirt', 2, 19.99, 100),
('Jeans', 2, 49.99, 60),
('Fiction Novel', 3, 14.99, 200),
('Science Journal', 3, 29.99, 150),
('Electric Kettle', 4, 1499.00, 25),
('Smart Watch', 1, 3499.00, 20),
('Cricket Bat', 5, 1999.00, 15),
('Air Fryer', 4, 4999.00, 10);


-- 9. INSERT CUSTOMER DATA
-- Adds sample customers

INSERT INTO Customers(
    FirstName,
    LastName,
    Email,
    PhoneNo,
    Address,
    City,
    State,
    ZIPcode,
    Country
)
VALUES
('Sameer', 'Khanna',
 'sameer.khanna@example.com',
 '123-456-7890',
 '123 Elm St.',
 'Springfield',
 'IL',
 '62701',
 'USA'),

('Jane', 'Smith',
 'jane.smith@example.com',
 '234-567-8901',
 '456 Oak St.',
 'Madison',
 'WI',
 '53703',
 'USA'),

('Harshad', 'Patel',
 'harshad.patel@example.com',
 '345-678-9012',
 '789 Dalal St.',
 'Mumbai',
 'Maharashtra',
 '41520',
 'INDIA'),

('Rahul', 'Sharma',
 'rahul@gmail.com',
 '9876543210',
 'Park Street',
 'Kolkata',
 'West Bengal',
 '700016',
 'India'),

('Priya', 'Singh',
 'priya@gmail.com',
 '9876543211',
 'Salt Lake',
 'Kolkata',
 'West Bengal',
 '700091',
 'India'),

('Amit', 'Das',
 'amit@gmail.com',
 '9876543212',
 'MG Road',
 'Bangalore',
 'Karnataka',
 '560001',
 'India'),

('Neha', 'Gupta',
 'neha@gmail.com',
 '9876543213',
 'Connaught Place',
 'Delhi',
 'Delhi',
 '110001',
 'India'),

('Arjun', 'Roy',
 'arjun@gmail.com',
 '9876543214',
 'Garia',
 'Kolkata',
 'West Bengal',
 '700084',
 'India');



-- 10. INSERT ORDER DATA
-- Adds sample customer orders


INSERT INTO Orders(CustomerId, TotalAmount)
VALUES
(1, 719.98),
(2, 49.99),
(3, 44.98),
(4, 1499.00),
(5, 3499.00),
(1, 1999.00),
(2, 4999.00),
(3, 999.99),
(4, 599.00),
(5, 2499.00);


-- 11. INSERT ORDER ITEM DATA
-- Connects products with individual orders


INSERT INTO OrderItems(
    OrderID,
    ProductID,
    Quantity,
    Price
)
VALUES
(1, 1, 1, 699.99),
(1, 3, 1, 19.99),
(2, 4, 1, 49.99),
(3, 5, 1, 14.99),
(3, 6, 1, 29.99),
(4, 1, 1, 699.99),
(5, 3, 2, 19.99),
(6, 5, 2, 14.99),
(7, 6, 1, 29.99),
(8, 1, 1, 699.99);



-- 12. VERIFY PRODUCT DATA
-- Displays Product ID and Product Name


SELECT ProductId, ProductName
FROM Products;


