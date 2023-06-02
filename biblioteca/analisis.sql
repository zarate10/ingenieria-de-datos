SELECT * FROM prestamo; 
GO
-------------------------------------------------
-- Crea una función en SQL que tome dos números 
-- como parámetros y devuelva su suma.
-------------------------------------------------
DROP FUNCTION IF EXISTS fn_sumar; 
GO
CREATE FUNCTION dbo.fn_sumar 
(
	@num1 INT, 
	@num2 INT
) 
RETURNS INT
AS
BEGIN
	DECLARE @resultado INT = @num1 + @num2;
	RETURN @resultado; 
END

SELECT dbo.fn_sumar(10, 3) as SUMA; 
-------------------------------------------------
-- Implementa una función en SQL que tome el nombre 
-- de un autor como parámetro y devuelva la cantidad de libros escritos por ese autor.
-------------------------------------------------
DROP FUNCTION IF EXISTS dbo.fn_cantidad_libros_autor; 
GO
CREATE FUNCTION dbo.fn_cantidad_libros_autor 
(
	@nombre VARCHAR(50)
)
RETURNS INT
AS 
BEGIN
	DECLARE @cantidad INT = (SELECT COUNT(l.titulo)
							 FROM autor a 
							 INNER JOIN libro l 
							 ON l.id_autor = a.id 
							 WHERE nombre = @nombre)
	RETURN @cantidad; 
END

SELECT dbo.fn_cantidad_libros_autor('John Smith') as 'Cantidad de libros';
-------------------------------------------------
-- Diseña una función en SQL que calcule el promedio 
-- de las edades de los usuarios en la tabla de usuarios.
-------------------------------------------------
DROP FUNCTION IF EXISTS dbo.fn_calcular_promedio_edad; 
GO
CREATE FUNCTION dbo.fn_calcular_promedio_edad()
RETURNS INT 
AS
BEGIN 
	DECLARE @promedio INT = (SELECT AVG(edad) FROM usuario);
	
	RETURN @promedio 
END 

SELECT dbo.fn_calcular_promedio_edad() as 'Promedio de edades'; 
-------------------------------------------------
-- Implementa una función en SQL que tome un autor como parámetro
-- y devuelva la lista de géneros en los que ha escrito ese autor, 
-- utilizando joins entre las tablas de autores, libros y géneros.
-------------------------------------------------
DROP FUNCTION IF EXISTS fn_generos_x_autor; 
GO
CREATE FUNCTION fn_generos_x_autor 
(
	@autor VARCHAR(50)
)
RETURNS TABLE 
AS
RETURN (
	SELECT DISTINCT g.nombre
	FROM libro l
	JOIN autor a 
	ON l.id_autor = a.id 
	JOIN genero g 
	ON l.id_genero = g.id
	WHERE a.nombre = @autor
);

SELECT * FROM fn_generos_x_autor('John Smith'); 
-------------------------------------------------
-- Crea un procedimiento almacenado en SQL que tome el ID de un autor
-- como parámetro y devuelva todos los libros escritos por ese autor.
-------------------------------------------------
DROP PROCEDURE IF EXISTS pr_libros_x_autor; 
GO
CREATE PROCEDURE pr_libros_x_autor  
(
	@id_autor INT 
)
AS 
BEGIN
	SELECT titulo FROM libro WHERE id_autor = @id_autor; 
END 

EXECUTE pr_libros_x_autor 1; 
-------------------------------------------------
-- Diseña un procedimiento almacenado en SQL que tome el nombre 
-- de un género como parámetro y devuelva la cantidad de libros 
-- en la biblioteca que pertenecen a ese género.
-------------------------------------------------
DROP PROCEDURE IF EXISTS pr_cantidad_libros_genero; 
GO 
CREATE PROCEDURE pr_cantidad_libros_genero 
(
	@genero VARCHAR(30)
)
AS 
BEGIN
	DECLARE @id_genero INT = (SELECT id FROM genero WHERE nombre = @genero); 
	
	SELECT COUNT(*) as 'Cantidad de libros' FROM libro WHERE id_genero = @id_genero; 
END

EXECUTE pr_cantidad_libros_genero 'Ficción';
-------------------------------------------------
-- Implementa un procedimiento almacenado en SQL que tome el ID de un usuario 
-- y devuelva todos los libros que ha prestado actualmente, es decir, 
-- aquellos que aún no han sido devueltos
-------------------------------------------------
GO
DROP PROCEDURE IF EXISTS pr_libros_prestados_user; 
GO
CREATE PROCEDURE pr_libros_prestados_user
(
	@id INT 
)
AS
BEGIN
	SELECT * FROM prestamo WHERE devuelto = 0 AND id_usuario = @id; 
END

EXECUTE pr_libros_prestados_user 64; 
