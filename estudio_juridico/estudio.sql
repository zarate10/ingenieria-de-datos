CREATE DATABASE estudiojur;

USE estudiojur;

CREATE TABLE CLIENTE (
	id INT NOT NULL,
	dni INT NOT NULL, 
	nombre VARCHAR(30) NOT NULL, 
	apellido VARCHAR(30) NOT NULL, 
	direccion VARCHAR(50) NOT NULL, 
	CONSTRAINT pk_cliente PRIMARY KEY (id)
);

CREATE TABLE PROCURADOR(
    id integer not null primary key,
    nombre varchar(250) not null,
    apellido varchar(250) not null,
    matricula integer not null
);

CREATE TABLE ASUNTO (
	id INT NOT NULL, 
	numero INT NOT NULL, 
	cliente_id INT NOT NULL, 
	fecha_inicio DATE NOT NULL,
	fecha_archivo DATE, 
	estado VARCHAR(30) NOT NULL,
	CHECK(estado in ('en trámite', 'archivado')),
	CONSTRAINT pk_asunto PRIMARY KEY (id)
);

CREATE TABLE ASUNTO_PROCURADOR (
    id integer not null primary key,
    procurador_id integer not null,
    asunto_id integer not null,
    foreign key (procurador_id) references procurador(id),
    foreign key (asunto_id) references asunto(id)
);

ALTER TABLE ASUNTO ADD CONSTRAINT fk_cliente_id_asunto FOREIGN KEY (cliente_id) REFERENCES Cliente(id);

INSERT INTO CLIENTE (id, dni, nombre, apellido, direccion)
VALUES 
(1, 12345678, 'William', 'Belgrano', 'Av. de Mayo 123'),
(2, 23456789, 'Victoria', 'San Martín', 'Av. Rivadavia 456'),
(3, 34567890, 'Arthur', 'Paso', 'Calle Florida 789'),
(4, 45678901, 'Winston', 'Moreno', 'Av. Corrientes 2468'),
(5, 56789012, 'Margaret', 'Güemes', 'Av. Cabildo 369'),
(6, 67890123, 'Charles', 'Pueyrredón', 'Calle Corrientes 555'),
(7, 78901234, 'Elizabeth', 'Saavedra', 'Av. 9 de Julio 111'),
(8, 89012345, 'Henry', 'Urquiza', 'Av. Santa Fe 222'),
(9, 90123456, 'Catherine', 'Belgrano', 'Av. Callao 333'),
(10, 11234567, 'Richard', 'San Martín', 'Av. de Mayo 444'),
(11, 22345678, 'George', 'Paso', 'Av. Libertador 555'),
(12, 33456789, 'Diana', 'Moreno', 'Av. Corrientes 678'),
(13, 44567890, 'Philip', 'Güemes', 'Av. Cabildo 789'),
(14, 55678901, 'Mary', 'Pueyrredón', 'Av. Corrientes 890'),
(15, 66789012, 'Edward', 'Saavedra', 'Calle Florida 901'),
(16, 77890123, 'Anne', 'Urquiza', 'Av. Santa Fe 1234'),
(17, 88901234, 'Robert', 'Belgrano', 'Av. 9 de Julio 2345'),
(18, 99012345, 'Andrew', 'San Martín', 'Av. de Mayo 3456'),
(19, 11234556, 'David', 'Paso', 'Av. Libertador 4567'),
(20, 22345667, 'Kate', 'Moreno', 'Av. Corrientes 5678');

INSERT INTO PROCURADOR (id, nombre, apellido, matricula)
VALUES
(1, 'Hans', 'Schmidt', 1001),
(2, 'Klaus', 'Müller', 1002),
(3, 'Greta', 'Bauer', 1003),
(4, 'Fritz', 'Schneider', 1004),
(5, 'Eva', 'Weber', 1005),
(6, 'Helga', 'Schuster', 1006),
(7, 'Rudolf', 'Schwarz', 1007),
(8, 'Gerhard', 'Krause', 1008),
(9, 'Ingrid', 'Wagner', 1009),
(10, 'Karl', 'Becker', 1010),
(11, 'Maria', 'Hoffmann', 1011),
(12, 'Heinz', 'Wolf', 1012),
(13, 'Ursula', 'Mayer', 1013);

INSERT INTO ASUNTO (id, numero, cliente_id, fecha_inicio, fecha_archivo, estado)
VALUES
(1, 123, 7, '2023-01-01', '2023-03-15', 'archivado'),
(2, 456, 14, '2022-11-23', NULL, 'en trámite'),
(3, 789, 10, '2023-04-12', '2024-02-28', 'archivado'),
(4, 234, 5, '2022-08-17', NULL, 'en trámite'),
(5, 567, 18, '2023-02-05', NULL, 'en trámite'),
(6, 890, 2, '2023-05-01', '2023-06-30', 'archivado'),
(7, 432, 19, '2022-12-10', NULL, 'en trámite'),
(8, 765, 12, '2023-01-27', '2023-07-18', 'archivado'),
(9, 198, 15, '2022-10-06', NULL, 'en trámite'),
(10, 321, 8, '2023-03-10', '2023-05-20', 'archivado'),
(11, 654, 6, '2022-09-14', NULL, 'en trámite'),
(12, 987, 3, '2023-06-08', '2024-01-05', 'archivado'),
(13, 345, 16, '2022-11-30', NULL, 'en trámite'),
(14, 678, 1, '2023-04-22', NULL, 'en trámite'),
(15, 901, 11, '2022-12-03', '2023-01-31', 'archivado'),
(16, 543, 13, '2023-02-17', NULL, 'en trámite'),
(17, 876, 4, '2022-08-27', NULL, 'en trámite'),
(18, 209, 9, '2023-01-14', '2023-08-02', 'archivado'),
(19, 432, 20, '2022-10-24', NULL, 'en trámite'),
(20, 765, 17, '2023-03-24', '2023-05-31', 'archivado'),
(21, 234, 3, '2023-05-01', NULL, 'en trámite'),
(22, 567, 15, '2022-12-18', NULL, 'en trámite'),
(23, 890, 5, '2023-04-02', '2023-06-15', 'archivado'),
(24, 432, 2, '2022-09-28', NULL, 'en trámite'),
(25, 765, 12, '2023-01-17', NULL, 'en trámite'),
(26, 198, 9, '2022-11-03', NULL, 'en trámite');

INSERT INTO ASUNTO_PROCURADOR(id, procurador_id, asunto_id)
VALUES 
(1, 5, 9),
(2, 3, 7),
(3, 8, 16),
(4, 1, 21),
(5, 10, 8),
(6, 2, 6),
(7, 12, 24),
(8, 5, 13),
(9, 6, 2),
(10, 11, 17),
(11, 3, 5),
(12, 9, 12),
(13, 7, 26),
(14, 3, 25),
(15, 4, 14),
(16, 8, 20),
(17, 13, 23),
(18, 2, 4),
(19, 11, 18),
(20, 1, 22),
(21, 6, 15),
(22, 10, 1),
(23, 9, 11),
(24, 5, 3),
(25, 7, 10),
(26, 3, 19),
(27, 12, 16);

-------------------------
-- Escribe una consulta SQL que muestre el número de expediente, fecha de inicio y
-- estado de todos los asuntos que están actualmente en trámite
-------------------------

SELECT numero as n_tramite,  fecha_inicio, estado
FROM ASUNTO WHERE estado LIKE '%trámite%';

-------------------------
-- Escribe una consulta SQL que muestre el nombre y DNI de todos los clientes que tienen
-- asuntos archivados y que residen en una dirección específica.
-------------------------

SELECT a.numero 'exp', c.dni, c.nombre
FROM ASUNTO a
JOIN CLIENTE c ON a.cliente_id = c.id
WHERE a.estado = 'archivado' AND c.direccion LIKE '%Libertador%';

-------------------------
-- Escribe una consulta SQL que muestre el nombre y DNI de todos los clientes que tienen
-- asuntos llevados por un procurador específico.
-------------------------

SELECT c.nombre, c.dni
FROM ASUNTO_PROCURADOR ac 
JOIN ASUNTO a ON ac.asunto_id = a.id
JOIN CLIENTE c ON c.id = a.cliente_id
JOIN PROCURADOR p ON ac.procurador_id = p.id 
WHERE p.nombre = 'Greta'; 

-------------------------
-- Escribe una consulta SQL que muestre el nombre y DNI de todos los clientes que tienen
-- más de un asunto en trámite.
-------------------------

SELECT c.nombre, c.dni
FROM CLIENTE c 
WHERE (SELECT COUNT(*) FROM ASUNTO a WHERE c.id = a.cliente_id AND a.estado LIKE '%trámite%') > 1;

-------------------------
-- Escribe una consulta SQL que muestre el nombre y DNI de todos los clientes que tienen
-- asuntos archivados cuyo período de tiempo estuvo entre dos fechas específicas.
-------------------------

SELECT c.nombre, c.dni 
FROM ASUNTO a
JOIN CLIENTE c ON a.cliente_id = c.id
WHERE a.estado = 'archivado' AND a.fecha_inicio between '2023-04-02' and '2023-06-15';

-------------------------
-- Escribe una consulta SQL que muestre el número de expediente, nombre y DNI del
-- cliente, y nombre del procurador de todos los asuntos llevados por un procurador
-- específico.
-------------------------

SELECT a.numero as nExp, c.nombre, c.dni, p.nombre as nombre_procurador
FROM ASUNTO_PROCURADOR ap 
JOIN ASUNTO a ON ap.asunto_id = a.id
JOIN PROCURADOR p ON ap.procurador_id = p.id
JOIN CLIENTE c ON a.cliente_id = c.id
WHERE p.nombre = 'Gerhard';

