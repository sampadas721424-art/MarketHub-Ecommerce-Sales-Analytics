USE markethub;
-- Query 1: Retrieve all orders for a specific customer
SELECT o.OrderId, o.OrderDate, o.TotalAmount, oi.ProductId, p.ProductName, oi.Quantity, oi.Price
FROM Orders o
JOIN OrderItems oi ON o.OrderId = oi.OrderId
JOIN Products p ON oi.ProductId = p.ProductId
WHERE o.CustomerId = 1;

-- Query 2: Find the total sales for each product
SELECT p.ProductId, p.ProductName, SUM(oi.Quantity * oi.Price) AS TotalSales
FROM OrderItems oi
JOIN Products p 
ON oi.ProductId= p.ProductId
GROUP BY p.ProductId, p.ProductName
ORDER BY TotalSales DESC;

-- Query 3: Calculate the average order value
SELECT AVG(TotalAmount) AS AverageOrderValue FROM Orders;

-- Query 4: Top 5 customers by total spending
SELECT c.CustomerId,c.FirstName,c.LastName,SUM(o.TotalAmount) AS Totalspent
FROM Customers c
JOIN Orders o
on c.CustomerId=o.CustomerId
GROUP BY
c.CustomerId,c.FirstName,c.LastName
ORDER BY TotalSpent DESC
LIMIT 5;

-- Query 5: Retrieve the most popular product category
SELECT
    c.CategoryID,
    c.CategoryName,
    SUM(oi.Quantity) AS TotalQuantitySold
FROM Categories c
JOIN Products p
    ON c.CategoryID = p.CategoryID
JOIN OrderItems oi
    ON p.ProductID = oi.ProductID
GROUP BY
    c.CategoryID,
    c.CategoryName
ORDER BY TotalQuantitySold DESC
LIMIT 1;

-- to insert a product with zero stock
INSERT INTO Products(ProductName, CategoryID, Price, Stock)
VALUES ('Keyboard', 1, 39.99, 0);

-- Query 6: List all products that are out of stock, i.e. stock = 0
SELECT * FROM Products WHERE Stock = 0;
-- with category name
SELECT p.ProductID, p.ProductName, c.CategoryName, p.Stock 
FROM Products p JOIN Categories c
ON p.CategoryID = c.CategoryID
WHERE Stock = 0;

-- Query 7: Find customers who placed orders in the last 30 days
SELECT c.CustomerID,c.FirstName,c.LastName,c.Email
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= NOW() - INTERVAL 30 DAY;

-- Query 8: Calculate the total number of orders placed each month
SELECT YEAR(OrderDate) AS OrderYear,MONTH(OrderDate) AS OrderMonth,COUNT(OrderId) AS TotalOrders
FROM Orders
GROUP BY YEAR(OrderDate),MONTH(OrderDate)
ORDER BY OrderYear,OrderMonth;

-- Query 9: Retrieve the details of the most recent order
SELECT o.OrderID, o.OrderDate, o.TotalAmount, c.FirstName, c.LastName
FROM Orders o JOIN Customers c
ON o.CustomerID = c.CustomerID
ORDER BY o.OrderDate DESC
LIMIT 1;

-- Query 10: Find the average price of products in each category

SELECT c.CategoryId, c.CategoryName, AVG(p.Price) as AveragePrice 
FROM Categories c JOIN Products p
ON c.CategoryId= p.ProductId
GROUP BY c.CategoryId, c.CategoryName;

-- Query 11: List customers who have never placed an order
SELECT c.CustomerID, c.FirstName, c.LastName, c.Email, c.PhoneNo, O.OrderID, o.TotalAmount
FROM Customers c LEFT OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderId IS NULL;

-- Query 12: Retrieve the total quantity sold for each product
SELECT p.ProductID, p.ProductName, SUM(oi.Quantity) AS TotalQuantitySold
FROM OrderItems oi JOIN Products p
ON oi.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY p.ProductId;

-- Query 13: Calculate the total revenue generated from each category
SELECT c.CategoryID, c.CategoryName, SUM(oi.Quantity * oi.Price) AS TotalRevenue
FROM OrderItems oi JOIN Products p
ON oi.ProductID = p.ProductID
JOIN Categories c
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalRevenue DESC;

-- Query 14: Find the highest-priced product in each category
SELECT
    c.CategoryID,
    c.CategoryName,
    p.ProductName,
    p.Price AS HighestPrice
FROM Categories c
JOIN Products p
    ON c.CategoryID = p.CategoryID
WHERE p.Price = (
    SELECT MAX(p2.Price)
    FROM Products p2
    WHERE p2.CategoryID = p.CategoryID
)
ORDER BY HighestPrice DESC;

-- Query 15: Retrieve orders with a total amount greater than a specific value 
SELECT o.OrderID, c.CustomerID, c.FirstName, c.LastName, o.TotalAmount
FROM Orders o JOIN Customers c
ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount >= 49.99
ORDER BY o.TotalAmount DESC;

-- Query 16: List products along with the number of orders they appear in
SELECT p.ProductID, p.ProductName, COUNT(oi.OrderID) as OrderCount
FROM Products p JOIN OrderItems oi
ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY OrderCount DESC;

-- Query 17: Find the top 3 most frequently ordered products
SELECT  p.ProductID, p.ProductName, COUNT(oi.OrderID) AS OrderCount
FROM OrderItems oi JOIN  Products p
ON oi.ProductID = p.ProductID
GROUP BY  p.ProductID, p.ProductName
ORDER BY OrderCount DESC
LIMIT 3;

-- Query 18: Calculate the total number of customers from each country
SELECT Country, COUNT(CustomerID) AS TotalCustomers
FROM Customers GROUP BY Country ORDER BY TotalCustomers DESC;

-- Query 19: Retrieve the list of customers along with their total spending
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalSpending
FROM Customers c JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;


-- Query 20: List orders with more than a specified number of items 
SELECT o.OrderID, c.CustomerID, c.FirstName, c.LastName, COUNT(oi.OrderItemID) AS NumberOfItems
FROM Orders o JOIN OrderItems oi
ON o.OrderID = oi.OrderID
JOIN Customers c 
ON o.CustomerID = c.CustomerID
GROUP BY o.OrderID, c.CustomerID, c.FirstName, c.LastName
HAVING COUNT(oi.OrderItemID) >=1
ORDER BY NumberOfItems DESC;






