USE MARKETHUB;
-- Procedure 1: Get Customer Orders
DELIMITER //
 CREATE PROCEDURE GetcustomerOrders(IN cust_id INT )
 BEGIN 
  SELECT 
    OrderId,
    OrderDate,
    TotalAmount
    FROM Orders 
    WHERE CustomerId = cust_id;
    END //
    DELIMITER ;
    
-- Test Procedure 1
CALL GetCustomerOrders(1);

-- Procedure 2: Get Products By Category
DELIMITER //

CREATE PROCEDURE GetProductsByCategory(IN cat_id INT)
BEGIN
    SELECT
        ProductID,
        ProductName,
        Price,
        Stock
    FROM Products
    WHERE CategoryID = cat_id;
END //

DELIMITER ;

-- Test Procedure 2
CALL GetProductsByCategory(1);

-- Procedure 3: Get Low Stock Products
DELIMITER //
CREATE PROCEDURE GetLowStockProducts(IN stock_limit INT)
BEGIN
    SELECT
        ProductID,
        ProductName,
        Price,
        Stock
    FROM Products
    WHERE Stock < stock_limit
    ORDER BY Stock ASC;
END //
DELIMITER ;


-- Test Procedure 3
CALL GetLowStockProducts(30);


-- Procedure 4: Get High Value Orders
DELIMITER //
CREATE PROCEDURE GetHighValueOrders(IN min_amount DECIMAL(10,2))
BEGIN
    SELECT
        o.OrderID,
        c.CustomerID,
        c.FirstName,
        c.LastName,
        o.OrderDate,
        o.TotalAmount
    FROM Orders o
    JOIN Customers c
        ON o.CustomerID = c.CustomerID
    WHERE o.TotalAmount >= min_amount
    ORDER BY o.TotalAmount DESC;
END //

DELIMITER ;

-- Test Procedure 4
CALL GetHighValueOrders(500);

-- Procedure 5: Get Customer Spending

DELIMITER //

CREATE PROCEDURE GetCustomerSpending(IN cust_id INT)
BEGIN
    SELECT
        c.CustomerID,
        c.FirstName,
        c.LastName,
        SUM(o.TotalAmount) AS TotalSpending
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    WHERE c.CustomerID = cust_id
    GROUP BY
        c.CustomerID,
        c.FirstName,
        c.LastName;
END //

DELIMITER ;
-- Test 
CALL GetCustomerSpending(1);

-- Procedure 6: Get Product Sales

DELIMITER //

CREATE PROCEDURE GetProductSales(IN prod_id INT)
BEGIN
    SELECT
        p.ProductID,
        p.ProductName,
        SUM(oi.Quantity) AS TotalQuantitySold,
        SUM(oi.Quantity * oi.Price) AS TotalSales
    FROM Products p
    JOIN OrderItems oi
        ON p.ProductID = oi.ProductID
    WHERE p.ProductID = prod_id
    GROUP BY
        p.ProductID,
        p.ProductName;
END //

DELIMITER ;
-- Test
CALL GetProductSales(1);



 