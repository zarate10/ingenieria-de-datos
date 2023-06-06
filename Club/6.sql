USE club; 
GO
-- 1 - JOIN:
-- Listado de deuda por grupo familiar.
-- Listado de socios sin actividad.
SELECT * FROM socio s 
LEFT JOIN actividad_socio acs
ON s.dni = acs.dni 
WHERE acs.dni IS NULL 
-- 2 - FUNCIONES:
-- Crear una función que reciba por parametro el nombre de una actividad, y devuelva, de aquellos socios que realizan dicha actividad,
-- una tabla que contenga el nombre y la cantidad de personas que tiene a cargo.
GO
DROP FUNCTION IF EXISTS dbo.fn_cantidad_personas_a_cargo; 
GO
CREATE FUNCTION dbo.fn_cantidad_personas_a_cargo 
(
	@nombre VARCHAR(50)
) 
RETURNS TABLE 
AS
RETURN 
	SELECT (SELECT nombre FROM socio WHERE dni=s.dni_responsable), COUNT(s.dni_responsable) as 'cantidad a cargo' 
	FROM actividad_socio acs 
	JOIN socio s ON s.dni = acs.dni
	GROUP BY s.dni_responsable

SELECT * FROM dbo.fn_cantidad_personas_a_cargo('Carolina Silva')

SELECT * FROM socio