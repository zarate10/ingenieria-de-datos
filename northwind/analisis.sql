USE Northwind; 
---------------------------
-- Encuentra los 5 clientes que han realizado el mayor número de pedidos.
---------------------------
GO 
SELECT TOP 5 c.ContactName, COUNT(o.OrderID) AS Orders
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.ContactName
ORDER BY Orders DESC
---------------------------
-- Obtén el nombre de los empleados que han atendido pedidos realizados por clientes de Francia.
---------------------------
GO
SELECT DISTINCT e.FirstName + ' ' + e.LastName as Nombres
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID 
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country = 'France'
---------------------------
-- Encuentra los productos más vendidos en la categoría de bebidas.
---------------------------
GO
SELECT p.ProductName, COUNT(p.ProductName) as Vendidos
FROM OrderDetails od 
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON c.CategoryID = p.CategoryID 
WHERE c.CategoryName = 'Beverages'
GROUP BY p.ProductName
ORDER BY Vendidos DESC
---------------------------
-- Obtén la cantidad total de productos vendidos por cada empleado.
---------------------------
GO
SELECT o.EmployeeID, SUM(od.Quantity) as ProductosVendidos
FROM OrderDetails od 
JOIN Orders o ON o.OrderID = od.OrderID 
GROUP BY (o.EmployeeID)
ORDER BY ProductosVendidos DESC 
---------------------------
-- Encuentra los clientes que no han realizado ningún pedido hasta el momento.
--------------------------- 
GO
SELECT DISTINCT c.CustomerName as 'Clientes sin ningún pedido'
FROM Customers c 
LEFT JOIN Orders o ON o.CustomerID = c.CustomerID
WHERE o.OrderID IS NULL 
---------------------------
-- Total de ventas por categoría
---------------------------
GO
SELECT c.CategoryName, SUM(od.Quantity) as VentasXCategoria
FROM OrderDetails od
JOIN Products p ON p.ProductID = od.ProductID 
JOIN Categories c ON p.CategoryID = c.CategoryID 
GROUP BY c.CategoryName
ORDER BY VentasXCategoria DESC
---------------------------
-- Obtén el nombre del empleado y el nombre del cliente 
-- para aquellos pedidos que tienen un valor total superior a $5,000.
---------------------------
GO
SELECT e.FirstName + ' ' + e.LastName, c.CustomerName
FROM OrderDetails od 
JOIN Products p ON od.ProductID = p.ProductID
JOIN Orders o ON od.OrderID = o.OrderID 
JOIN Employees e ON e.EmployeeID = o.EmployeeID
JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE (p.Price * od.Quantity) > 5000
---------------------------
-- Calcula la media de los precios de los productos por categoría.
---------------------------
GO
SELECT c.CategoryName, AVG(p.Price) as PromedioPreciosCategoria
FROM Products p 
JOIN Categories c ON c.CategoryID = p.ProductID
GROUP BY c.CategoryName
ORDER BY PromedioPreciosCategoria DESC
