USE club; 
GO
----------------------------------
-- Crear un procedimiento que permita visualizar a los socios 
-- que tengan la edad que se indique por parámetro.
----------------------------------
GO
DROP PROCEDURE IF EXISTS pr_socios_de_edad; 
GO
CREATE PROCEDURE pr_socios_de_edad
(
	@edad INT
)
AS 
BEGIN
	SET NOCOUNT ON; 
	SELECT * FROM socio WHERE edad = @edad; 
END 
GO
EXECUTE pr_socios_de_edad 25; 
GO
----------------------------------
-- Crear un procedimiento que devuelva el listado de socios que tengan edad 
-- dentro de un rango de edades correspondiente. 
----------------------------------
DROP PROCEDURE IF EXISTS pr_socio_edad_entre 
GO
CREATE PROCEDURE pr_socio_edad_entre
(
	@edad1 INT,
	@edad2 INT
) 
AS
BEGIN
	IF @edad1 < @edad2
		SELECT * FROM socio WHERE edad BETWEEN @edad1 AND @edad2; 
END 
GO
EXECUTE pr_socio_edad_entre 10, 28; 
GO
----------------------------------
-- Crear un procedimiento que devuelva un parámetro de salida con la cantidad 
-- de elementos que ha alquilado un socio en toda su historia. 
----------------------------------
DROP PROCEDURE IF EXISTS elem_alq_por_socio; 
GO
CREATE PROCEDURE elem_alq_por_socio
(
	@dni INT
)
AS
BEGIN
	SELECT es.dni, el.nombre
	FROM elemento_socio es
	JOIN elemento el ON es.id_elemento = el.id 
	WHERE dni=@dni
END 
GO
EXECUTE elem_alq_por_socio 88990011;
----------------------------------
-- Realizar el procedimiento Socio_INS_DEL con los siguientes parámetros que permita 
-- dar de alta o de baja al socio indicado por parámetro según la acción especificada 
-- (DNI, Nombre, Edad, Estado, DNI Responsable).
----------------------------------
DROP PROCEDURE IF EXISTS pr_dar_altabaja_soc
GO
CREATE PROCEDURE pr_dar_altabaja_soc 
(
	@alta INT, -- 1 para alta 0 para baja
	@dni INT, 
	@nombre VARCHAR(50) = NULL,
	@edad INT = NULL, 
	@dni_resp INT = NULL
)
AS
BEGIN
	IF @alta <> 0
		INSERT INTO socio (dni, nombre, edad, estado, dni_responsable) VALUES (@dni, @nombre, @edad, 1, @dni_resp); 
	ELSE
		UPDATE socio SET estado = 0 WHERE dni = @dni; 
END
GO
EXECUTE pr_dar_altabaja_soc 1, 1241124, 'Traba', 15, 5212312
EXECUTE pr_dar_altabaja_soc 0, 1241124
