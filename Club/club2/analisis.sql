USE clubv2; 
------------------------------------------
-- 1.1 Realiza un JOIN entre las tablas socio y actividad_socio para obtener el nombre de los socios y el total de actividades en las que participan.
------------------------------------------
SELECT s.nombre, COUNT(asoc.id_actividad) as totalActividades
FROM socio as s 
JOIN actividad_socio asoc ON asoc.dni = s.dni
GROUP BY s.nombre
ORDER BY totalActividades DESC
------------------------------------------
-- 1.2 Combina las tablas socio y elemento_socio para obtener el nombre de los socios y la cantidad de elementos diferentes que han alquilado.
------------------------------------------
SELECT s.nombre, COUNT(es.id_elemento) as totalElementosDiferentes
FROM elemento_socio es
JOIN socio s ON es.dni = s.dni 
GROUP BY s.nombre
------------------------------------------
-- 1.3 Realiza un JOIN entre las tablas socio y cuota_socio para obtener el nombre de los socios y el total de cuotas que han pagado.
------------------------------------------
SELECT s.nombre, COUNT(cs.dni) as totalCuotasPagadas
FROM socio s
JOIN cuota_socio cs ON cs.dni = s.dni
GROUP BY s.nombre
------------------------------------------
-- 1.4 Combina las tablas socio, actividad_socio y actividad para obtener el nombre de los socios y el promedio de valor de las actividades en las que participan.
------------------------------------------
SELECT s.nombre, (SUM(a.valor) / COUNT(s.nombre)) as valorPromedioActividades
FROM socio s 
JOIN actividad_socio acs ON s.dni = acs.dni
JOIN actividad a ON a.id = acs.id_actividad
GROUP BY s.nombre
ORDER BY valorPromedioActividades DESC
------------------------------------------
-- 1.5 Realiza un JOIN entre las tablas socio, elemento_socio y elemento para obtener el nombre de los socios y el valor total de los elementos que han alquilado.
------------------------------------------
SELECT s.nombre, SUM(e.valor) as valorTotalElementosSocio
FROM socio s
JOIN elemento_socio es ON s.dni = es.dni 
JOIN elemento e ON e.id = es.id_elemento
GROUP BY s.nombre
------------------------------------------
-- Combina las tablas socio, cuota_socio y cuota para obtener el nombre de los socios y la suma total de los valores de las cuotas que han pagado.
------------------------------------------
-- edad > 26 valor_a
-- edad < 26 valor_n
SELECT s.nombre, 
	SUM(
       CASE 
           WHEN s.edad > 25 THEN c.valor_a
		   WHEN s.edad < 26 THEN c.valor_n
       END
	) AS estado
FROM socio s 
JOIN cuota_socio cs ON s.dni = cs.dni 
JOIN cuota c ON c.id = cs.id_cuota
GROUP BY s.nombre
ORDER BY ESTADO DESC
------------------------------------------
-- 1.7 Realiza un JOIN entre las tablas socio, actividad_socio y actividad para obtener el nombre de los socios y la actividad con el valor máximo en la que participan.
------------------------------------------
SELECT s.nombre, MAX(a.valor) as ValorMaximo
FROM socio s
JOIN actividad_socio sc ON s.dni = sc.dni
JOIN actividad a ON a.id = sc.id_actividad
GROUP BY s.nombre
ORDER BY ValorMaximo DESC
------------------------------------------
-- 2.1 Crea una función que reciba el nombre de una actividad y devuelva la cantidad de socios que participan en dicha actividad.
------------------------------------------
GO
DROP FUNCTION IF EXISTS fn_cantidad_socios_en_actividad
GO
CREATE FUNCTION fn_cantidad_socios_en_actividad
(
	@nombre_actividad VARCHAR(50)
) 
RETURNS TABLE
	RETURN (SELECT a.nombre, COUNT(a.nombre) AS CantidadInscriptos
			FROM actividad a
			JOIN actividad_socio acso ON a.id = acso.id_actividad
			WHERE a.nombre = @nombre_actividad 
			GROUP BY a.nombre)
GO
SELECT * FROM fn_cantidad_socios_en_actividad('Yoga')
------------------------------------------
-- 2.10 Implementa un procedimiento que tome como parámetro la edad de un socio y devuelva la cantidad de actividades en las que participa y cuyo valor es mayor a 30.
------------------------------------------
GO
DROP PROCEDURE IF EXISTS pr_socios_en_act_con_edad
GO 
CREATE PROCEDURE pr_socios_en_act_con_edad
(
	@edad INT 
)
AS 
BEGIN
	SELECT s.nombre, a.nombre
	FROM actividad_socio acso
	JOIN actividad a ON acso.id_actividad = a.id
	JOIN socio s ON acso.dni = s.dni
	WHERE s.edad > @edad
END
GO
EXECUTE pr_socios_en_act_con_edad 30
------------------------------------------
-- 4.1 Crea un trigger que se active cada vez que se inserte una nueva fila en la tabla actividad_socio. 
-- Este trigger deberá actualizar automáticamente el campo cupo en la tabla actividad, disminuyendo en 1 la cantidad de cupos disponibles para esa actividad.
------------------------------------------
GO
DROP TRIGGER IF EXISTS tr_actualizar_actividades
GO
CREATE TRIGGER tr_actualizar_actividades
ON actividad_socio
FOR INSERT 
AS
BEGIN 
	UPDATE actividad SET cupo = cupo - 1 WHERE id = (SELECT id FROM inserted)
END 
------------------------------------------
-- 10.1 Crea una vista llamada vista_deudas que muestre el DNI, nombre y valor total de las cuotas impagas de cada socio.
------------------------------------------
GO
DROP VIEW IF EXISTS vista_deudas
GO
CREATE VIEW vista_deudas
AS
	(
		SELECT s.nombre, s.dni, SUM 
		(
		CASE
			WHEN s.edad < 26 THEN c.valor_n
			WHEN s.edad > 25 THEN c.valor_a
		END 
		) AS deuda
		FROM socio s
		JOIN cuota_socio cs ON s.dni = cs.dni 
		JOIN cuota c ON c.id = cs.id_cuota
		WHERE c.vencimiento < 6
		GROUP BY s.nombre, s.dni
	)
GO
SELECT * FROM vista_deudas
------------------------------------------
-- 2.2 Implementa una función que tome como parámetro el DNI de un socio y devuelva el total de elementos que ha alquilado.
------------------------------------------
GO
DROP FUNCTION IF EXISTS fn_elementos_alquilados_socio 
GO
CREATE FUNCTION fn_elementos_alquilados_socio 
(
	@dni VARCHAR(50)
)
RETURNS INT
AS
BEGIN 
	DECLARE @totalElementos INT

	SET @totalElementos = 
	(
	SELECT COUNT(e.nombre)
	FROM socio s
	JOIN elemento_socio es ON es.dni = s.dni
	JOIN elemento e ON es.id_elemento = e.id
	WHERE s.dni = @dni
	GROUP BY s.dni
	)
	RETURN @totalElementos
END
GO
SELECT dbo.fn_elementos_alquilados_socio('90123456I') as 'elementos alquilados';
------------------------------------------
-- 4.2 Implementa un trigger que se active cada vez que se elimine una fila en la tabla socio. 
-- Este trigger deberá eliminar en cascada todas las filas correspondientes en las tablas actividad_socio, elemento_socio y cuota_socio que estén asociadas al socio eliminado.
------------------------------------------
GO
DROP TRIGGER IF EXISTS tr_borrado_cascada_socio
GO
CREATE TRIGGER tr_borraco_cascada_socio
ON socio 
FOR DELETE 
AS
BEGIN
	DELETE FROM actividad_socio WHERE dni = (SELECT dni FROM deleted)
	DELETE FROM elemento_socio WHERE dni = (SELECT dni FROM deleted)
	DELETE FROM cuota_socio WHERE dni = (SELECT dni FROM deleted)
END
------------------------------------------
-- 10.2 Crea una vista llamada vista_elementos_alquilados que muestre el DNI, nombre y fecha de alquiler de los elementos que están actualmente alquilados por los socios.
------------------------------------------
GO
DROP VIEW IF EXISTS vista_elementos_alquilados
GO
CREATE VIEW vista_elementos_alquilados
AS
	(
		SELECT s.dni, e.nombre, es.fecha_alq
		FROM elemento_socio es
		JOIN socio s ON es.dni = s.dni 
		JOIN elemento e ON es.id_elemento = e.id 

	)
------------------------------------------
-- 2.4 Implementa una función que tome como parámetro la edad de un socio y devuelva la cantidad de actividades en las que participa.
------------------------------------------
GO
DROP FUNCTION IF EXISTS fn_socios_edad_actividades 
GO
CREATE FUNCTION fn_socios_edad_actividades
(
	@edad INT 
)
RETURNS TABLE
	RETURN (
		SELECT a.nombre, COUNT(a.nombre) AS cantidad_inscriptos
		FROM actividad_socio acso
		JOIN socio s ON s.dni = acso.dni 
		JOIN actividad a ON acso.id_actividad = a.id
		WHERE edad > @edad
		GROUP BY a.nombre
	)
GO
SELECT * FROM fn_socios_edad_actividades(20);
------------------------------------------
-- 1.10 Combina las tablas socio, actividad_socio y actividad para obtener el nombre de los socios que no participan en ninguna actividad.
------------------------------------------
SELECT s.nombre 
FROM socio s
LEFT JOIN actividad_socio acso ON s.dni = acso.dni 
WHERE acso.dni IS NULL
------------------------------------------
-- Crea una función que reciba el nombre de una actividad y devuelva la cantidad de socios que participan en dicha actividad y tienen menos de 25 años.
------------------------------------------
GO
DROP FUNCTION IF EXISTS fn_actividad_edad_menor_25
GO
CREATE FUNCTION fn_actividad_edad_menor_25
(
	@nombre_actividad VARCHAR(50)
)
RETURNS TABLE
RETURN (
		SELECT a.nombre AS actividad, COUNT(a.nombre) AS cantidad
		FROM actividad a 
		JOIN actividad_socio acso ON a.id = acso.id_actividad
		JOIN socio s ON acso.dni = s.dni
		WHERE s.edad < 25 AND a.nombre LIKE '%' + @nombre_actividad + '%'
		GROUP BY a.nombre
)
GO
SELECT * FROM fn_actividad_edad_menor_25('Pilates')
------------------------------------------
-- 2.17 Implementa un procedimiento que reciba el DNI de un socio y devuelva una tabla que muestre el nombre de las actividades en las que participa, 
-- la cantidad de socios que también participan en esas actividades y el porcentaje de participación del socio en cada una de ellas en relación con el total de socios.
------------------------------------------
GO
DROP PROCEDURE IF EXISTS pr_porcentaje_socios_actividad
GO
CREATE PROCEDURE pr_porcentaje_socios_actividad
(
	@dni VARCHAR(50)
)
AS
BEGIN
	DECLARE @total_socios INT
	SELECT @total_socios = COUNT(*) FROM socio

	SELECT 
		a.nombre AS actividades, 
		(SELECT COUNT(*) FROM actividad_socio acso2 WHERE acso2.id_actividad = acso.id_actividad) AS cantidad,
		(COUNT(acso.id_actividad) * 100.0 / @total_socios) AS porcentaje
	FROM socio s
	JOIN actividad_socio acso ON s.dni = acso.dni 
	JOIN actividad a ON a.id = acso.id_actividad
	WHERE s.dni = @dni
	GROUP BY a.nombre, acso.id_actividad;
END
SELECT * FROM actividad
SELECT * FROM actividad_socio
GO
EXECUTE pr_porcentaje_socios_actividad '12391ASDC'