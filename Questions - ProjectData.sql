B1 - 


SELECT 
PED.OrderID, 
PED.Quantity,
PED.ProductID,
PROD.ReorderLevel,
FORN.SupplierID 
FROM 
TREINAMENTO.OrderDetails PED 
LEFT JOIN TREINAMENTO.Products PROD 
ON PED.ProductID  = PROD.ProductID
LEFT JOIN TREINAMENTO.Suppliers FORN
ON PROD.SupplierID = FORN.SupplierID 
WHERE PED.Quantity BETWEEN 65 AND 70
ORDER BY PED.OrderID 


B2 - 


SELECT 
ProductID,
ProductName,
EnglishName,
UnitPrice
FROM TREINAMENTO.Products 
WHERE UnitPrice < 8.00
ORDER BY ProductID 


B3 - 


SELECT 
CustomerID,
CompanyName,
Country,
Phone
FROM TREINAMENTO.Customers 
WHERE Country IN ('Canada', 'USA')
ORDER BY CustomerID 


B4 -


SELECT 
FORN.SupplierID,
FORN.Name,
PROD.ProductName,
PROD.ReorderLevel,
PROD.UnitsInStock
FROM TREINAMENTO.Suppliers FORN
LEFT JOIN TREINAMENTO.Products PROD 
ON FORN.SupplierID = PROD.SupplierID 
WHERE PROD.ReorderLevel = PROD.UnitsInStock 


B5  


SELECT 
PED.OrderID,
CLI.CompanyName,
CLI.ContactName,
CONVERT(VARCHAR, PED.ShippedDate, 107) AS ShippedDate,
DATEDIFF(YEAR, PED.ShippedDate, '2009-01-01') AS ElapsedYears
FROM TREINAMENTO.Orders PED
LEFT JOIN TREINAMENTO.Customers CLI 
ON PED.CustomerID = CLI.CustomerID 
WHERE PED.ShippedDate >= '1994-01-01'
ORDER BY PED.OrderID, ElapsedYears 


B6 - 


SELECT 
PED.OrderID,
PROD.ProductName,
CLI.CompanyName,
CONVERT(VARCHAR, PED.OrderDate, 107) AS OrderDate,
CONVERT(VARCHAR, DATEADD(DAY, 10, PED.ShippedDate), 107) AS NewShippedDate,
(PEDDETALHE.Quantity * PROD.UnitPrice) AS OrderCost 
FROM TREINAMENTO.Orders PED
LEFT JOIN TREINAMENTO.Customers CLI 
ON PED.CustomerID = CLI.CustomerID
LEFT JOIN TREINAMENTO.OrderDetails PEDDETALHE 
ON PED.OrderID = PEDDETALHE.OrderID 
LEFT JOIN TREINAMENTO.Products PROD 
ON PEDDETALHE.ProductID = PROD.ProductID 
WHERE OrderDate BETWEEN '1992-01-01' AND '1992-03-30'
AND (PEDDETALHE.Quantity * PROD.UnitPrice) > 1500


B7 - 


SELECT 
PED.OrderID,
PEDDETALHE.UnitPrice,
PEDDETALHE.Quantity
FROM TREINAMENTO.Orders PED 
LEFT JOIN TREINAMENTO.OrderDetails PEDDETALHE 
ON PED.OrderID = PEDDETALHE.OrderID 
WHERE PED.ShipCity = 'Vancouver'
ORDER BY PED.OrderID


B8 - 


SELECT 
CLI.CustomerID,
CLI.CompanyName,
CLI.Fax,
PED.OrderID,
PED.OrderDate
FROM TREINAMENTO.Orders PED
LEFT JOIN TREINAMENTO.Customers CLI 
ON PED.CustomerID = CLI.CustomerID 
WHERE PED.ShippedDate IS NULL
ORDER BY CLI.CustomerID, PED.OrderDate


B9 - 


SELECT 
ProductID,
ProductName,
QuantityPerUnit,
UnitPrice
FROM TREINAMENTO.Products 
WHERE ProductName LIKE '%choc%' 
OR ProductName LIKE '%tofu%'
ORDER BY ProductID


B10 - 


SELECT 
	SUBSTRING (p.ProductName,1,1) as primeira_letra,
	COUNT (p.ProductName) as contagem_produtos_letra
FROM TREINAMENTO.Products as p
GROUP BY SUBSTRING (p.ProductName,1,1)
HAVING COUNT (ProductName) >= 3


C1 - 


CREATE OR ALTER VIEW vw_supplier_items AS

SELECT 
FORN.SupplierID,
FORN.Name,
PROD.ProductID,
PROD.ProductName
FROM TREINAMENTO.Suppliers FORN
LEFT JOIN TREINAMENTO.Products PROD 
ON FORN.SupplierID = PROD.SupplierID 

SELECT * FROM vw_supplier_items 
ORDER BY Name, ProductID


C2 - 


CREATE OR ALTER VIEW vw_employee_info AS 

SELECT 
EmployeeID,
CONCAT(FirstName, ' ', LastName) AS Name,
BirthDate
FROM TREINAMENTO.Employees 

SELECT * FROM vw_employee_info 
WHERE EmployeeID IN (3, 6, 9)


C3 - 


UPDATE TREINAMENTO.Customers 
SET Fax = 'UNKNOWN' 
WHERE Fax IS NULL


C4 - 


CREATE OR ALTER VIEW vw_order_cost AS 

SELECT 
PED.OrderID,
PED.OrderDate,
PROD.ProductID,
CLI.CompanyName,
(PEDDETALHE.Quantity * PEDDETALHE.UnitPrice) AS OrderCost
FROM TREINAMENTO.Orders PED 
LEFT JOIN TREINAMENTO.OrderDetails PEDDETALHE 
ON PED.OrderID = PEDDETALHE.OrderID 
LEFT JOIN TREINAMENTO.Customers CLI 
ON PED.CustomerID = CLI.CustomerID 
LEFT JOIN TREINAMENTO.Products PROD 
ON PEDDETALHE.ProductID = PROD.ProductID 

SELECT * FROM vw_order_cost 
WHERE OrderID BETWEEN 10100 AND 10200
ORDER BY ProductID


C5 - 


INSERT INTO TREINAMENTO.Suppliers  
(SupplierID, Name)
VALUES (16, 'Supplier P') 


C6 - 


UPDATE TREINAMENTO.Products 
SET UnitPrice = (UnitPrice * 0.15)
WHERE UnitPrice < 5.00


C7 - 


CREATE OR ALTER VIEW vw_orders AS 

SELECT 
PED.OrderID,
CLI.CustomerID,
CLI.CompanyName,
CLI.City,
CLI.Country,
PED.ShippedDate 
FROM TREINAMENTO.Orders PED
LEFT JOIN TREINAMENTO.Customers CLI 
ON PED.CustomerID = CLI.CustomerID 

SELECT * FROM vw_orders 
WHERE ShippedDate BETWEEN '1993-01-01' AND '1993-01-31'
ORDER BY CompanyName, Country





