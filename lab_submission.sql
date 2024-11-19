-- (i) A Procedure called PROC_LAB5
-- SQL syntax
CREATE PROCEDURE PROC_LAB5
@CustomerID INT --An input representing the customer whose total amount you want to find
AS
BEGIN
    SELECT 
        c.customer_name,
        SUM(o.total_amount) AS TotalAmount --Calculates total amount for the customer
    FROM 
        customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id --Combines records from the customers and orders table to match the given customer id
    WHERE 
        c.customer_id = @CustomerID
    GROUP BY 
        c.customer_name; --Outputs the customer's record
END;

--To execute the procedure above use:
EXEC PROC_LAB5 010; --010 represents the customer ID of the customer

-- (ii) A Function called FUNC_LAB5
-- SQL syntax
CREATE FUNCTION FUNC_LAB5
(@CustomerID INT, @OrderDate DATE)
RETURNS INT
AS
BEGIN
    DECLARE @OrderCount INT; --Counts the orders for the given customer id
    SELECT @OrderCount = COUNT(*) 
    FROM orders
    WHERE customer_id = @CustomerID AND order_date = @OrderDate;
    RETURN @OrderCount;
END;

--To execute the function above use:
SELECT FUNC_LAB5(010, '2024-11-18') AS OrderCount; --Obtains total number of orders that match the given customer id and order date

-- (iii) A View called VIEW_LAB5
-- SQL syntax
CREATE VIEW VIEW_LAB5
AS
SELECT TOP 10
    c.customer_name,
    SUM(o.total_amount) AS TotalAmount
FROM 
    customers c
INNER JOIN orders o ON c.customer_id = o.customer_id  
GROUP BY 
    c.customer_name --Performs an inner join between the customers and orders tables, then groups by customer_name to sum up the total amount of the customer.
ORDER BY 
    TotalAmount DESC;

--To query the view use:
SELECT * FROM VIEW_LAB5; --Gives the top 10 customers with their corresponding amount in descending order
