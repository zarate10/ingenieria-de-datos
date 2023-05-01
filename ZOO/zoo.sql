CREATE DATABASE zoo;

USE zoo;

-- modelos

CREATE TABLE TipoAnimal (
	id INT NOT NULL, 
	nombre VARCHAR(50) NOT NULL,
	CONSTRAINT pk_tipoAnimal PRIMARY KEY(id)
); 

CREATE TABLE Ciudad (
	id INT NOT NULL, 
	nombre VARCHAR(50) NOT NULL,
	CONSTRAINT pk_ciudad PRIMARY KEY (id)
);

CREATE TABLE Clima(
	id INT NOT NULL, 
	nombre VARCHAR(50) NOT NULL,
	CONSTRAINT pk_clima PRIMARY KEY (id)
);

CREATE TABLE Cuidador (
	id INT NOT NULL, 
	nombre VARCHAR(50) NOT NULL,
	CONSTRAINT pk_cuidador PRIMARY KEY (id)
);

CREATE TABLE Recinto (
	id INT NOT NULL, 
	nombre VARCHAR(50) NOT NULL,
	clima_id INT NOT NULL,
	FOREIGN KEY (clima_id) REFERENCES Clima(id), 
	CONSTRAINT pk_recinto PRIMARY KEY (id)
);

CREATE TABLE Animal (
	id INT NOT NULL, 
	nombre VARCHAR(50) NOT NULL, 
	peso INT NOT NULL, 
	fecha_nac Date NOT NULL, 
	ciudad_id INT NOT NULL, 
	tipoAnimal_id INT NOT NULL, 
	FOREIGN KEY (ciudad_id) REFERENCES Ciudad(id),
	FOREIGN KEY (tipoAnimal_id) REFERENCES tipoAnimal(id),
	CONSTRAINT pk_animal PRIMARY KEY (id)
);

CREATE TABLE Animal_Cuidador (
	id INT NOT NULL, 
	animal_id INT NOT NULL, 
	cuidador_id INT NOT NULL, 
	FOREIGN KEY (animal_id) REFERENCES Animal(id),
	FOREIGN KEY (cuidador_id) REFERENCES Cuidador(id),
	CONSTRAINT pk_animalxcuidador PRIMARY KEY (id)
);

ALTER TABLE Animal ADD recinto INT NOT NULL FOREIGN KEY (recinto) REFERENCES Recinto(id);

-------------------------------
-- consultas
-------------------------------

INSERT INTO Clima 
VALUES (1, 'CÁLIDO'),
	   (2, 'FRÍO'),
	   (3, 'AUSTRIACO');

INSERT INTO Ciudad 
VALUES (1, 'Gesell'),
	   (2, 'Pinamar'),
	   (3, 'Mardel'),
	   (4, 'Sancle');

INSERT INTO TipoAnimal (id, nombre)
VALUES (1, 'Perro'), (2, 'Gato'), (3, 'Conejo'), (4, 'Pájaro'), (5, 'Pez'), (6, 'Reptil');

INSERT INTO Recinto (id, nombre, clima_id)
VALUES (1, 'Recinto Gabriela Mistral', 1),
	   (2, 'Recinto Dos', 2),
       (3, 'Recinto Tres', 2),
	   (4, 'Recinto Malvo', 3); 

INSERT INTO Cuidador (id, nombre)
VALUES (1, 'Elena'),
       (2, 'Carlos'),
       (3, 'Sofia'),
       (4, 'Pedro'),
       (5, 'Ana'),
       (6, 'Mario'),
       (7, 'Lucia'),
       (8, 'Juan'),
       (9, 'Luisa'),
       (10, 'Diego');

INSERT INTO Animal (id, nombre, peso, fecha_nac, ciudad_id, tipoAnimal_id, recinto)
VALUES 
(1, 'Luna', 8, '2019-05-12', 1, 1, 1),
(2, 'Max', 12, '2017-11-28', 2, 1, 2),
(3, 'Bella', 6, '2020-02-10', 3, 2, 3),
(4, 'Rocky', 14, '2015-07-21', 1, 2, 1),
(5, 'Daisy', 5, '2021-01-03', 4, 3, 2),
(6, 'Bailey', 9, '2018-09-17', 2, 3, 3),
(7, 'Charlie', 11, '2016-04-29', 3, 4, 4),
(8, 'Oliver', 7, '2020-12-14', 4, 4, 1),
(9, 'Lucy', 10, '2017-01-22', 1, 5, 2),
(10, 'Toby', 13, '2015-09-05', 2, 5, 3),
(11, 'Milo', 6,  '2021-03-08', 3, 6, 4),
(12, 'Sadie', 12,  '2016-11-12', 4, 6, 1),
(13, 'Zeus', 8,  '2019-08-02', 1, 1, 2),
(14, 'Sophie', 11, '2017-05-18', 2, 1, 3),
(15, 'Cooper', 7, '2020-10-26', 3, 2, 4),
(16, 'Lola', 9, '2018-07-11', 1, 2, 1),
(17, 'Sam', 13, '2015-10-02', 4, 3, 2),
(18, 'Zoe', 6, '2021-02-16', 2, 3, 3),
(19, 'Maximus', 14, '2015-06-30', 3, 4, 4),
(20, 'Chloe', 5, '2022-02-20', 1, 4, 1),
(21, 'Bear', 12, '2016-09-08', 4, 5, 2),
(22, 'Roxy', 8, '2019-07-17', 3, 5, 3),
(23, 'Harley', 10, '2017-02-19', 2, 6, 4),
(24, 'Sasha', 7, '2020-11-30', 1, 6, 1),
(25, 'Duke', 11,'2016-05-23', 3, 1, 2);

INSERT INTO Animal_Cuidador (id, animal_id, cuidador_id)
VALUES (1, 3, 5),
       (2, 12, 3),
       (3, 8, 2),
       (4, 21, 4),
       (5, 10, 6),
       (6, 18, 8),
       (7, 1, 7),
       (8, 25, 9),
       (9, 9, 1),
       (10, 17, 2),
       (11, 4, 4),
       (12, 13, 6),
       (13, 22, 5),
       (14, 16, 8),
       (15, 7, 1),
       (16, 24, 3),
       (17, 11, 9),
       (18, 19, 7),
       (19, 6, 5),
       (20, 23, 2),
       (21, 5, 1),
       (22, 14, 9),
       (23, 20, 4),
       (24, 2, 6),
       (25, 15, 3);

----------------
-- Nombre de los cuidadores
-- asignados a cada animal
----------------

SELECT a.nombre as animal, ta.nombre as tipo, c.nombre as cuidador
FROM Animal_Cuidador axc
JOIN Animal a ON a.id = axc.animal_id
JOIN TipoAnimal ta ON a.tipoAnimal_id = ta.id
JOIN Cuidador c ON axc.cuidador_id = c.id; 

----------------
-- cantidad de animales
-- de cada especie
----------------

SELECT ta.nombre, COUNT(ta.nombre) as cantidad
FROM Animal a 
LEFT JOIN TipoAnimal ta ON a.tipoAnimal_id = ta.id
GROUP BY ta.nombre; 

----------------
-- animales asignados a
-- un cuidador determinado
----------------

SELECT c.nombre, ta.nombre as tipo_animal
FROM Animal_Cuidador axc
LEFT JOIN Animal a ON axc.animal_id = a.id
LEFT JOIN Cuidador c ON axc.cuidador_id = c.id
LEFT JOIN TipoAnimal ta ON ta.id = a.tipoAnimal_id
WHERE c.nombre = 'Carlos';

----------------
-- decir dónde se encuentra un
-- determinado animal
----------------

SELECT r.nombre as recinto, ta.nombre as animal, a.nombre
FROM Animal a 
JOIN TipoAnimal ta ON a.tipoAnimal_id = ta.id
JOIN Recinto r ON a.recinto = r.id
WHERE ta.nombre = 'Pájaro'; 

----------------
-- lista de nombre de un determinado
-- animal y en que clima se encuentran
----------------

SELECT a.nombre as nombre_animal, c.nombre as clima
FROM Animal a 
JOIN Recinto r ON a.recinto = r.id 
JOIN Clima c ON c.id = r.clima_id
JOIN TipoAnimal ta ON a.tipoAnimal_id = ta.id
WHERE ta.nombre = 'Perro';

----------------
-- Crear una consulta para mostrar el promedio 
-- de peso de los animales por tipo de animal.
----------------

SELECT ta.nombre, AVG(a.peso) as peso_promedio
FROM Animal a
JOIN TipoAnimal ta ON a.tipoAnimal_id = ta.id
GROUP BY ta.nombre;


