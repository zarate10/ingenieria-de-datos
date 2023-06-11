USE Northwind; 
--------------------------------------------
-- VIEWS 
--------------------------------------------
GO
--------------------------------------------
-- Obtén una vista de todas las órdenes realizadas en la tabla "orders" 
-- junto con los detalles del cliente correspondiente de la tabla "customers".
--------------------------------------------
GO
DROP VIEW IF EXISTS vw_ordenes_realizadas; 
GO
CREATE VIEW vw_ordenes_realizadas 
WITH ENCRYPTION 
AS 
	(SELECT c.CustomerName as NombreCliente, p.ProductName as NombreProducto, od.Quantity as Cantidad FROM Orders o 
	JOIN Customers c ON o.CustomerID = c.CustomerID
	JOIN OrderDetails od ON od.OrderID = o.OrderID 
	JOIN Products p ON p.ProductID = od.ProductID)
GO
SELECT * FROM vw_ordenes_realizadas;
--------------------------------------------
-- Crea una vista que muestre los nombres de los productos, 
-- su precio unitario y la cantidad disponible en stock de la tabla "products".
--------------------------------------------
GO
DROP VIEW IF EXISTS vw_productos
GO
CREATE VIEW vw_productos
WITH ENCRYPTION
AS 
	(SELECT ProductName as Producto, Price as Precio FROM Products)
GO
SELECT * FROM vw_productos
--------------------------------------------
-- Genera una vista que muestre el nombre del empleado y el total 
-- de ventas que ha realizado, utilizando la tabla "employees" y la tabla "orders".
--------------------------------------------
GO
DROP VIEW IF EXISTS vw_ventas_x_empleado 
GO
CREATE VIEW vw_ventas_x_empleado 
WITH ENCRYPTION
AS
	(
	SELECT e.FirstName + ' ' + e.LastName as NombreEmpleado, COUNT(o.OrderID) as Ventas
	FROM Employees e
	JOIN Orders o ON e.EmployeeID = o.EmployeeID
	GROUP BY e.FirstName, e.LastName
	) 
GO
SELECT * FROM vw_ventas_x_empleado ORDER BY Ventas DESC;
--------------------------------------------
-- Crea una vista que muestre los nombres de los clientes, junto con la cantidad total de productos
-- que han ordenado y el monto total gastado por cada uno, utilizando las tablas "customers", "orders" y "order_details".
--------------------------------------------
GO
DROP VIEW IF EXISTS vw_log_clientes 
GO
CREATE VIEW vw_log_clientes
WITH ENCRYPTION
AS
	(
	SELECT c.CustomerName
	FROM Customers c
	JOIN Orders o ON c.CustomerID = o.CustomerID
	)
