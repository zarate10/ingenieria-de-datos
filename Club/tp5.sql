USE club; 
GO
--------------------------------
-- Hacer un trigger que ante una actualización del campo DNI en la tabla
-- Socio replique el cambio en la tabla Actividad_Socio.
--------------------------------
DROP TRIGGER IF EXISTS tr_update_act_socio
GO
CREATE TRIGGER tr_update_act_socio
ON socio
FOR UPDATE 
AS 
BEGIN 
	DECLARE @dni_old INT = (SELECT dni FROM deleted);
	SET NOCOUNT ON;
	UPDATE actividad_socio SET dni = (SELECT dni FROM inserted) WHERE dni = @dni_old;
END 
--------------------------------
-- Implementar un borrado en cascada de los Alquileres de un Socio al ser eliminado.
--------------------------------
GO 
DROP TRIGGER IF EXISTS tr_delete_cascade_socio; 
GO
CREATE TRIGGER tr_delete_cascade_socio
ON socio 
FOR DELETE 
AS
BEGIN
	SET NOCOUNT ON; 
	DELETE FROM elemento_socio WHERE dni = (SELECT dni FROM deleted); 
END
--------------------------------
-- Impedir que se pueda modificar el campo Nombre de la tabla Elemento. 
--------------------------------
GO
DROP TRIGGER IF EXISTS tr_tabla_elemento
GO
CREATE TRIGGER tr_tabla_elemento
ON elemento
INSTEAD OF UPDATE
AS
BEGIN
	IF UPDATE(nombre)
		BEGIN 
			PRINT 'NO SE ADMITE LA ACTUALIZACIÓN DEL NOMBRE'
			ROLLBACK TRANSACTION
			RETURN
		END
END 
GO
SELECT * FROM elemento;
GO
UPDATE elemento SET nombre = 'Pep' WHERE id=1;
GO
--------------------------------
-- Hacer un trigger para controlar que no se eliminen Socios si tienen Cuotas, 
--------------------------------
SELECT * FROM cuota_socio
SELECT * FROM socio
GO
DROP TRIGGER IF EXISTS tr_socio_con_cuotas
GO
CREATE TRIGGER tr_socio_con_cuotas
ON socio
INSTEAD OF DELETE
AS
BEGIN
	IF EXISTS (SELECT dni FROM deleted) 
		BEGIN 
			RAISERROR('Error raised in TRY block.', -- Message text.
					   16, -- Severity.
					   1 -- State.
					   );
			ROLLBACK TRANSACTION
			RETURN
		END
END
--------------------------------
-- Grabar una tabla de Auditoria, con los datos del operador, fecha, hora y terminal 
-- desde la cual se modificó el Precio de cada Elemento.
--------------------------------
GO
create table Auditoria (
	id_elemento integer not null,
	precio_ant float not null,
	precio_act float not null,
	fecha datetime not null,
	operador varchar(250) not null,
	terminal varchar(250) not null
)
GO
SELECT * FROM elemento; 
SELECT * FROM Auditoria;
GO
DROP TRIGGER IF EXISTS tr_auditor_elemento 
GO
CREATE TRIGGER tr_auditor_elemento
ON elemento
FOR UPDATE
AS
BEGIN
	DECLARE @id_elemento INT = (SELECT id FROM inserted);
	DECLARE @precio_ant FLOAT = (SELECT valor FROM deleted);
	DECLARE @precio_act FLOAT = (SELECT valor FROM inserted);

	INSERT INTO Auditoria VALUES (@id_elemento, @precio_act, @precio_act, GETDATE(), 'z', '1'); 
END 
GO 

UPDATE elemento SET valor = 200 WHERE id = 1;

SELECT * FROM elemento; 