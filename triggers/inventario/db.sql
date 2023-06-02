---------------------------------
-- SQL Server Profiler 19 
-- Práctica triggers
---------------------------------
CREATE DATABASE inventario;
GO
USE inventario; 
GO
CREATE TABLE productos (
	id_Cod INT IDENTITY,
	cod_prod VARCHAR(4) NOT NULL, 
	nombre VARCHAR(50) NOT NULL, 
	existencia INT NOT NULL,
	CONSTRAINT pk_productos PRIMARY KEY (id_Cod)
);
GO
CREATE TABLE historial (
	fecha DATE, 
	descripcion VARCHAR(100), 
	usuario VARCHAR(20)
); 
GO
DROP TABLE historial; 
GO
CREATE TABLE historial (
	fecha DATE, 
	cod_prod VARCHAR(4),
	descripcion VARCHAR(100), 
	usuario VARCHAR(20)
); 
GO
CREATE TABLE ventas (
	cod_prod VARCHAR(4),
	precio MONEY,
	cantidad INT
);
GO
INSERT INTO productos VALUES ('A001', 'MEMORIA USB 32GB', 175);
INSERT INTO productos VALUES ('A002', 'DISCO DURO 2TB', 15);
INSERT INTO productos VALUES ('A003', 'AIRE COMPRIMIDO', 250);
INSERT INTO productos VALUES ('A004', 'ESPUMA LIMPIADORA', 300);
INSERT INTO productos VALUES ('A005', 'FUNDA MONITOR', 500);
INSERT INTO productos VALUES ('A006', 'LÁMPARA ESCRITORIO', 7);
GO
SELECT * FROM historial; 
SELECT * FROM productos; 

TRUNCATE TABLE productos;

TRUNCATE TABLE historial;

DELETE FROM productos WHERE cod_prod='A003'; 
DELETE FROM productos WHERE cod_prod='A005'; 
---------------------------------
-- TRIGGER INSERT
---------------------------------

DROP TRIGGER IF EXISTS TR_ProductoInsertado;
GO
CREATE TRIGGER TR_ProductoInsertado
ON productos FOR INSERT -- Se disparará por inserción de datos en la tabla productos
AS 
-- SENTENCIA
	DECLARE @cod_prod VARCHAR(4) -- Declaramos una variable con el nombre de dato que queremos traer de INSERTED
	SELECT @cod_prod = cod_prod FROM inserted; -- Le indicamos que @cod_prod va a ser igual al cod_prod de la tabla que estamos insertando

	SET NOCOUNT ON; 

	INSERT INTO historial VALUES (
	GETDATE(),
	@cod_prod, 
	'Producto nuevo', 
	'DBA'
	);
-- FIN SENTENCIA
GO

DROP TRIGGER IF EXISTS RegisterDeletes;
GO
CREATE TRIGGER RegisterDeletes
ON productos FOR DELETE
AS 
	DECLARE @identificadorProductoEliminado VARCHAR(4) = (SELECT cod_prod FROM deleted); 

	SET NOCOUNT ON;

	INSERT INTO historial VALUES (
		GETDATE(),
		@identificadorProductoEliminado, 
		'Producto eliminado', 
		'DBA'
	); 