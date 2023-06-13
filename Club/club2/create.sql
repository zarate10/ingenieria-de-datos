create database clubv2;
GO
use clubv2;
GO
--EXEC sp_fkeys 'socio'
DROP TABLE IF EXISTS socio
GO
create table socio (
    dni varchar(250) not null primary key,
    nombre varchar(250) not null,
    edad integer not null,
    estado bit not null,
    dni_responsable varchar(250) not null,
    foreign key (dni_responsable) references socio(dni)
)
GO
DROP TABLE IF EXISTS actividad
GO
create table actividad (
    id integer not null primary key,
    nombre varchar(250) not null,
    valor float not null,
    cupo integer not null
)
GO
DROP TABLE IF EXISTS elemento
GO
create table elemento (
    id integer not null primary key,
    nombre varchar(250) not null,
    valor float not null
)
GO
DROP TABLE IF EXISTS cuota
GO
create table cuota (
    id integer not null primary key,
    valor_n float not null,
    valor_a float not null,
    vencimiento integer not null
)
GO
DROP TABLE IF EXISTS actividad_socio
GO
create table actividad_socio (
    id_actividad integer not null,
    dni varchar(250) not null,
    primary key (id_actividad, dni),
    foreign key (id_actividad) references actividad(id),
    foreign key (dni) references socio(dni)
)
GO
DROP TABLE IF EXISTS elemento_socio
GO
create table elemento_socio (
    id_elemento integer not null,
    dni varchar(250) not null,
    fecha_alq date not null,
    fecha_devol date,
    primary key (id_elemento, dni),
    foreign key (id_elemento) references elemento(id),
    foreign key (dni) references socio(dni)
)
GO
DROP TABLE IF EXISTS cuota_socio
GO
create table cuota_socio (
    id_cuota integer not null,
    dni varchar(250) not null,
    primary key (id_cuota, dni),
    foreign key (id_cuota) references cuota(id),
    foreign key (dni) references socio(dni)
)
GO
EXEC sp_MSforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"
GO
-- Datos de la tabla socio
INSERT INTO socio (dni, nombre, edad, estado, dni_responsable) VALUES
('12345678A', 'Juan Pérez', 25, 1, ''),
('23456789B', 'María López', 30, 1, '12345678A'),
('34567890C', 'Carlos Ramírez', 22, 1, '23456789B'),
('45678901D', 'Laura Gómez', 28, 1, '34567890C'),
('56789012E', 'Pedro Fernández', 33, 1, '45678901D'),
('67890123F', 'Ana Torres', 26, 1, '56789012E'),
('78901234G', 'Luisa Martínez', 29, 1, '67890123F'),
('89012345H', 'Roberto Sánchez', 24, 1, '78901234G'),
('90123456I', 'Elena Ríos', 27, 1, '89012345H'),
('01234567J', 'Javier Rodríguez', 31, 1, '90123456I'),
('12345678K', 'Patricia Jiménez', 23, 1, '01234567J'),
('23456789L', 'Miguel Castro', 32, 1, '12345678K'),
('34567890M', 'Susana Ortega', 25, 1, '23456789L'),
('45678901N', 'Daniel Herrera', 30, 1, '34567890M'),
('56789012O', 'Sara Paredes', 27, 1, '45678901N');
GO
-- Datos de la tabla actividad
INSERT INTO actividad (id, nombre, valor, cupo) VALUES
(1, 'Yoga', 10.5, 20),
(2, 'Pilates', 12.75, 15),
(3, 'Zumba', 8.25, 25),
(4, 'CrossFit', 15.0, 10),
(5, 'Natación', 9.0, 30),
(6, 'Ciclismo', 11.25, 20),
(7, 'Boxeo', 14.5, 15),
(8, 'Aeróbicos', 7.75, 25),
(9, 'Patinaje', 10.0, 10),
(10, 'Fútbol', 6.5, 30),
(11, 'Baloncesto', 9.75, 20),
(12, 'Tenis', 13.25, 15),
(13, 'Voleibol', 8.0, 25),
(14, 'Escalada', 12.0, 10),
(15, 'Gimnasia', 10.75, 20);
GO
-- Datos de la tabla elemento
INSERT INTO elemento (id, nombre, valor) VALUES
(1, 'Pelota', 5.0),
(2, 'Pesas', 20.0),
(3, 'Colchoneta', 8.0),
(4, 'Cuerda', 4.5),
(5, 'Aro', 6.0),
(6, 'Bicicleta', 100.0),
(7, 'Raqueta', 25.0),
(8, 'Red de voleibol', 30.0),
(9, 'Casco', 15.0),
(10, 'Patines', 40.0),
(11, 'Balón de fútbol', 15.0),
(12, 'Balón de baloncesto', 12.0),
(13, 'Red de tenis', 50.0),
(14, 'Arnés de escalada', 60.0),
(15, 'Cinta de correr', 200.0);
GO
-- Datos de la tabla cuota
INSERT INTO cuota (id, valor_n, valor_a, vencimiento) VALUES
(1, 50.0, 500.0, 15),
(2, 60.0, 600.0, 20),
(3, 70.0, 700.0, 25),
(4, 80.0, 800.0, 30),
(5, 90.0, 900.0, 5),
(6, 100.0, 1000.0, 10),
(7, 110.0, 1100.0, 15),
(8, 120.0, 1200.0, 20),
(9, 130.0, 1300.0, 25),
(10, 140.0, 1400.0, 30),
(11, 150.0, 1500.0, 5),
(12, 160.0, 1600.0, 10),
(13, 170.0, 1700.0, 15),
(14, 180.0, 1800.0, 20),
(15, 190.0, 1900.0, 25);
GO
-- Datos de la tabla actividad_socio
INSERT INTO actividad_socio (id_actividad, dni) VALUES
(1, '12345678A'),
(2, '23456789B'),
(3, '34567890C'),
(4, '45678901D'),
(5, '56789012E'),
(6, '67890123F'),
(7, '78901234G'),
(8, '89012345H'),
(9, '90123456I'),
(10, '01234567J'),
(11, '12345678K'),
(12, '23456789L'),
(13, '34567890M'),
(14, '45678901N'),
(15, '56789012O');
GO
-- Datos de la tabla elemento_socio
INSERT INTO elemento_socio (id_elemento, dni, fecha_alq, fecha_devol) VALUES
(1, '12345678A', '2023-05-01', '2023-05-05'),
(2, '23456789B', '2023-05-02', '2023-05-06'),
(3, '34567890C', '2023-05-03', '2023-05-07'),
(4, '45678901D', '2023-05-04', '2023-05-08'),
(5, '56789012E', '2023-05-05', '2023-05-09'),
(6, '67890123F', '2023-05-06', '2023-05-10'),
(7, '78901234G', '2023-05-07', '2023-05-11'),
(8, '89012345H', '2023-05-08', '2023-05-12'),
(9, '90123456I', '2023-05-09', '2023-05-13'),
(10, '01234567J', '2023-05-10', '2023-05-14'),
(11, '12345678K', '2023-05-11', '2023-05-15'),
(12, '23456789L', '2023-05-12', '2023-05-16'),
(13, '34567890M', '2023-05-13', '2023-05-17'),
(14, '45678901N', '2023-05-14', '2023-05-18'),
(15, '56789012O', '2023-05-15', '2023-05-19');
GO
-- Datos de la tabla cuota_socio
INSERT INTO cuota_socio (id_cuota, dni) VALUES
(1, '12345678A'),
(2, '23456789B'),
(3, '34567890C'),
(4, '45678901D'),
(5, '56789012E'),
(6, '67890123F'),
(7, '78901234G'),
(8, '89012345H'),
(9, '90123456I'),
(10, '01234567J'),
(11, '12345678K'),
(12, '23456789L'),
(13, '34567890M'),
(14, '45678901N'),
(15, '56789012O');

INSERT INTO actividad_socio (id_actividad, dni) VALUES (1, '23456789B');
INSERT INTO actividad_socio (id_actividad, dni) VALUES (3, '67890123F');
INSERT INTO actividad_socio (id_actividad, dni) VALUES (1, '56789012E');
INSERT INTO actividad_socio (id_actividad, dni) VALUES (3, '56789012E');
INSERT INTO actividad_socio (id_actividad, dni) VALUES (3, '45678901D');
INSERT INTO actividad_socio (id_actividad, dni) VALUES (4, '34567890M');
INSERT INTO actividad_socio (id_actividad, dni) VALUES (7, '34567890C');
INSERT INTO actividad_socio (id_actividad, dni) VALUES (2, '89012345H');