USE MarketHub;
-- View 1: Product Details Shows products along with their category
CREATE VIEW  vw_ProductDetails AS
SELECT p.ProductId,p.ProductName,p.price,p.Stock,c.CategoryName
FROM Products p  INNER JOIN Categories c
ON p.CategoryId=c.categoryId;

-- Test View 1
SELECT * FROM vw_ProductDetails;


-- View 2: Customer Orders,Shows the total orders and total amount
-- spent by each customer
CREATE VIEW vw_CustomerOrders AS
SELECT c.CustomerId,c.FirstName,c.LastName,
COUNT( DISTINCT O.OrderId) AS TotalOrders,
SUM(oi.Quantity*p.Price) AS TotalAmount
FROM Customers c
JOIN Orders o on c.CustomerId=o.CustomerId
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY c.CustomerId,c.FirstName,c.LastName;

-- Test View 2
SELECT * FROM vw_CustomerOrders;

-- View 3: Recent Orders Displays orders placed in the last 30 days
CREATE VIEW vw_RecentOrders AS
SELECT o.OrderID,o.OrderDate,c.CustomerID,c.FirstName,c.LastName,
SUM(oi.Quantity * oi.Price) AS OrderAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
WHERE o.OrderDate >= NOW() - INTERVAL 30 DAY
GROUP BY o.OrderID,o.OrderDate,c.CustomerID,c.FirstName,c.LastName;
-- Test View 3
SELECT * FROM vw_RecentOrders;

-- Query 31: Retrieve All Products with Category Names
-- Using the ProductDetails view to get a list of all products along with their category names.
SELECT * FROM vw_ProductDetails;

-- Query 32: Retrieve Products within a Specific Price Range
-- Using the vw_ProductDetails view to find products priced between $100 and $500.
SELECT * FROM vw_ProductDetails WHERE Price BETWEEN 10 AND 500;

-- Query 33: Count the Number of Products in Each Category
-- Using the vw_ProductDetails view to count the number of products in each category.
SELECT CategoryName, Count(ProductID) AS ProductCount
FROM vw_ProductDetails GROUP BY CategoryName; 

-- Query 34: Retrieve Customers with More Than 1 Orders
-- Using the vw_CustomerOrders view to find customers who have placed more than 1 orders.
SELECT * FROM vw_CustomerOrders WHERE TotalOrders > 1;

-- Query 35: Retrieve the Total Amount Spent by Each Customer
-- Using the vw_CustomerOrders view to get the total amount spent by each customer.
SELECT CustomerID, FirstName, LastName, TotalAmount FROM vw_CustomerOrders
ORDER BY TotalAmount DESC;

-- Query 36: Retrieve Recent Orders Above a Certain Amount
-- Using the vw_RecentOrders view to find recent orders where the total amount is greater than $1000.
SELECT * FROM vw_RecentOrders WHERE OrderAmount > 500;

-- Query 37: Retrieve the latest order for each customer
-- Purpose: Find the most recent order placed by each customer

SELECT
    ro.OrderID,
    ro.OrderDate,
    ro.CustomerID,
    ro.FirstName,
    ro.LastName,
    ro.OrderAmount
FROM vw_RecentOrders ro
JOIN
(
    SELECT
        CustomerID,
        MAX(OrderDate) AS LatestOrderDate
    FROM vw_RecentOrders
    GROUP BY CustomerID
) latest
    ON ro.CustomerID = latest.CustomerID
    AND ro.OrderDate = latest.LatestOrderDate
ORDER BY ro.OrderDate DESC;

-- Query 38: Retrieve Products in a Specific Category
-- Using the vw_ProductDetails view to get all products in a specific category, such as 'Electronics'.
SELECT * FROM vw_ProductDetails WHERE CategoryName = 'Books';

-- Query 39: Retrieve Total Sales for Each Category
-- Using the vw_ProductDetails and vw_CustomerOrders views to calculate the total sales for each category.
SELECT pd.CategoryName, SUM(oi.Quantity * p.Price) AS TotalSales
FROM OrderItems oi
INNER JOIN Products p ON oi.ProductID = p.ProductID
INNER JOIN vw_ProductDetails pd ON p.ProductID = pd.ProductID
GROUP BY pd.CategoryName
ORDER BY TotalSales DESC;

-- Query 40: Retrieve Customer Orders with Product Details
-- Using the vw_CustomerOrders and vw_ProductDetails views to get customer orders along with the details 
-- of the products ordered.
SELECT co.CustomerID, co.FirstName, co.LastName, o.OrderID, o.OrderDate,
pd.ProductName, oi.Quantity, pd.Price
FROM Orders o 
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN vw_ProductDetails pd ON oi.ProductID = pd.ProductID
INNER JOIN vw_CustomerOrders co ON o.CustomerID = co.CustomerID
ORDER BY o.OrderDate DESC;

-- Query 41: Retrieve Top 5 Customers by Total Spending
-- Purpose: Find the top 5 customers based on total spending

SELECT
    CustomerID,
    FirstName,
    LastName,
    TotalAmount
FROM vw_CustomerOrders
ORDER BY TotalAmount DESC
LIMIT 5;

-- Query 42: Retrieve Products with Low Stock
-- Using the vw_ProductDetails view to find products with stock below a certain threshold, such as 10 units.
SELECT * FROM vw_ProductDetails WHERE Stock < 50;

-- Query 43: Retrieve orders placed in the last 7 days
-- Purpose: Find recent orders from the last 7 days
SELECT *
FROM vw_RecentOrders
WHERE OrderDate >= NOW() - INTERVAL 7 DAY;

-- Query 44: Retrieve Products Sold in the Last 30 Days

SELECT
    p.ProductID,
    p.ProductName,
    SUM(oi.Quantity) AS TotalSold
FROM vw_RecentOrders ro
JOIN OrderItems oi
    ON ro.OrderID = oi.OrderID
JOIN Products p
    ON oi.ProductID = p.ProductID
GROUP BY
    p.ProductID,
    p.ProductName
ORDER BY TotalSold DESC;
