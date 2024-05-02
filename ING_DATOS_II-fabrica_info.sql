-- POSTGRESQL
CREATE TABLE fabricante (
  id INT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  id INT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio FLOAT NOT NULL,
  id_fabricante INT NOT NULL,
  FOREIGN KEY (id_fabricante) REFERENCES fabricante(id)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

SELECT * FROM fabricante;
-----
/* 
Devuelve una lista con el nombre del producto, precio y nombre 
de fabricante de todos los productos de la base de datos.
*/
SELECT p.nombre as nombre_producto, p.precio, f.nombre as nombre_fabricante
FROM producto p 
JOIN fabricante f 
ON p.id_fabricante = f.id
/* 
Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. 
Ordene el resultado por el nombre del fabricante, por orden alfabético.
*/ 
SELECT p.nombre as nombre_producto, p.precio, f.nombre as nombre_fabricante
FROM producto p 
JOIN fabricante f 
ON p.id_fabricante = f.id
ORDER BY f.nombre ASC
/* 
Devuelve una lista de todos los productos del fabricante Lenovo.
*/ 
SELECT * 
FROM producto p 
WHERE p.id_fabricante = (SELECT id FROM fabricante WHERE nombre='Lenovo');
/* 
Devuelve una lista de todos los productos del fabricante Lenovo.
Con precio menor a 500
*/ 
SELECT * 
FROM producto p 
WHERE p.id_fabricante = (SELECT id FROM fabricante WHERE nombre='Lenovo') AND p.precio < 500; 
/* 
Devuelve un listado con todos los productos de los fabricantes 
Asus, Hewlett-Packardy Seagate. Sin utilizar el operador IN.
*/ 
SELECT * 
FROM producto p 
WHERE 
	p.id_fabricante = (SELECT id FROM fabricante WHERE nombre='Asus') 
	OR p.id_fabricante = (SELECT id FROM fabricante WHERE nombre='Hewlett-Packardy') 
	OR p.id_fabricante = (SELECT id FROM fabricante WHERE nombre='Seagate')
/* 
Devuelve un listado con el nombre y el precio de todos los productos 
de los fabricantes cuyo nombre termine por la vocal e.
*/
SELECT p.nombre, p.precio 
FROM producto p
WHERE p.id_fabricante IN (SELECT id FROM fabricante WHERE nombre LIKE '%e')
/* 
Devuelve un listado de todos los fabricantes que existen en la base de datos, 
junto con los productos que tiene cada uno de ellos. 
El listado deberá mostrar también aquellos fabricantes que no tienen 
productos asociados.
*/
SELECT f.nombre, COALESCE(p.nombre, 'Sin productos')
FROM fabricante f
LEFT JOIN producto p 
ON p.id_fabricante = f.id
/* 
Devuelve un listado donde sólo aparezcan aquellos 
fabricantes que no tienen ningún producto asociado
*/ 
SELECT f.nombre
FROM fabricante f 
LEFT JOIN producto p 
ON p.id_fabricante = f.id
WHERE p IS NULL
/* 
Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
*/ 
SELECT p.* 
FROM producto p 
WHERE p.id_fabricante = (SELECT id FROM fabricante WHERE nombre = 'Lenovo')
/*
Devuelve todos los datos de los productos que tienen el mismo 
precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
*/
SELECT * 
FROM producto 
WHERE precio = (
	SELECT MAX(p.precio)
	FROM producto p 
	WHERE p.id_fabricante = (SELECT id FROM fabricante WHERE nombre = 'Lenovo')
)
/* 
Lista el nombre del producto más barato del fabricante Hewlett-Packard.
*/ 
SELECT *
FROM producto p 
WHERE p.precio = (
	SELECT MIN(precio) FROM producto pe 
	WHERE pe.id_fabricante = (SELECT id FROM fabricante WHERE nombre='Hewlett-Packard')
)
/* 
Devuelve el producto más caro que existe en 
la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.
*/ 
SELECT * 
FROM producto p 
WHERE p.precio >= ALL (SELECT precio FROM producto)
