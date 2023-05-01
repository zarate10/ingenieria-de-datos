--SQL Server Management Studio 19

CREATE DATABASE fulvo;

----------------------------------
-- modelos 
----------------------------------

CREATE TABLE equipo (
    id INT PRIMARY KEY,
    nombre VARCHAR(255),
    localidad VARCHAR(255),
    nombre_estadio VARCHAR(255),
    cantidad_hinchas INT
);

CREATE TABLE jugador (
    id INT PRIMARY KEY,
    nombre VARCHAR(255),
    dorsal INT,
    posicion VARCHAR(255),
    goles INT,
    asistencias INT,
    cantidad_regates INT,
    efectividad FLOAT,
    cantidad_amarillas INT,
    cantidad_rojas INT,
    pais_natal VARCHAR(255),
    equipo_id INT,
    FOREIGN KEY (equipo_id) REFERENCES equipo(id)
);

CREATE TABLE liga (
    id INT PRIMARY KEY,
    posicion INT,
    equipo_id INT,
    partidos_jugados INT,
    partidos_ganados INT,
    partidos_empatados INT,
    partidos_perdidos INT,
    goles_a_favor INT,
    goles_en_contra INT,
    diferencia_de_goles INT,
    puntos INT,
    FOREIGN KEY (equipo_id) REFERENCES equipo(id)
);

----------------------------------
-- datos 
----------------------------------

INSERT INTO equipo (id, nombre, localidad, nombre_estadio, cantidad_hinchas)
VALUES
(1, 'River Plate', 'Buenos Aires', 'Estadio Monumental Antonio Vespucio Liberti',10421),
(2, 'Boca Juniors', 'Buenos Aires', 'Estadio Alberto J. Armando (La Bombonera)',1212444),
(3, 'Racing Club', 'Avellaneda', 'Estadio Presidente Juan Domingo Perón (ElCilindro)', 4),
(4, 'Independiente', 'Avellaneda', 'Estadio Libertadores de América', 12415),
(5, 'San Lorenzo', 'Buenos Aires', 'Estadio Pedro Bidegain (Nuevo Gasómetro)', 342),
(6, 'Huracán', 'Buenos Aires', 'Estadio Tomás Adolfo Ducó', 2235),
(7, 'Vélez Sarsfield', 'Buenos Aires', 'Estadio José Amalfitani', 1235),
(8, 'Estudiantes de La Plata', 'La Plata', 'Estadio Jorge Luis Hirschi', 21244),
(9, 'Gimnasia y Esgrima La Plata', 'La Plata', 'Estadio Juan Carmelo Zerillo (ElBosque)', 1),
(10, 'Newell''s Old Boys', 'Rosario', 'Estadio Marcelo Bielsa', 112414),
(11, 'Rosario Central', 'Rosario', 'Estadio Gigante de Arroyito', 22),
(12, 'Talleres de Córdoba', 'Córdoba', 'Estadio Mario Alberto Kempes', 12451),
(13, 'Belgrano de Córdoba', 'Córdoba', 'Estadio Julio César Villagra', 41657),
(14, 'Colón de Santa Fe', 'Santa Fe', 'Estadio Brigadier General Estanislao López',1432),
(15, 'Unión de Santa Fe', 'Santa Fe', 'Estadio 15 de Abril', 2341),
(16, 'Atlético Tucumán', 'San Miguel de Tucumán', 'Estadio Monumental José Fierro',23551),
(17, 'San Martín de Tucumán', 'San Miguel de Tucumán', 'Estadio La Ciudadela',12355),
(18, 'Godoy Cruz', 'Mendoza', 'Estadio Malvinas Argentinas', 6431),
(19, 'Estudiantes de Río Cuarto', 'Río Cuarto', 'Estadio Antonio Candini', 134546),
(20, 'Aldosivi', 'Mar del Plata', 'Estadio José María Minella', 134);

INSERT INTO jugador (id, nombre, dorsal, posicion, goles,
asistencias, cantidad_regates, efectividad, cantidad_amarillas,
cantidad_rojas, pais_natal, equipo_id) VALUES
(1, 'Lionel Messi', 10, 'Delantero', 35, 12, 150, 85.3, 3, 0,'Argentina', 1),
(2, 'Sergio Agüero', 19, 'Delantero', 15, 8, 60, 77.2, 2, 1,'Argentina', 1),
(3, 'Ángel Di María', 11, 'Extremo', 8, 15, 80, 72.1, 5, 0,'Argentina', 1),
(4, 'Javier Mascherano', 14, 'Centrocampista', 1, 3, 40, 89.6,6, 1, 'Argentina', 4),
(5, 'Diego Maradona', 10, 'Delantero', 34, 14, 200, 92.5, 2, 1, 'Argentina', 12),
(6, 'Juan Román Riquelme', 10, 'Centrocampista', 16, 22, 110, 79.8, 4, 0, 'Argentina', 6),
(7, 'Gabriel Batistuta', 9, 'Delantero', 54, 8, 90, 85.6, 2, 0, 'Argentina', 7),
(8, 'Carlos Tevez', 10, 'Delantero', 23, 10, 70, 75.2, 3, 0, 'Argentina', 8),
(9, 'Javier Zanetti', 4, 'Defensa', 3, 5, 30, 93.1, 4, 0, 'Argentina', 20),
(10, 'Pablo Aimar', 10, 'Centrocampista', 9, 17, 100, 82.4, 2, 0, 'Argentina', 10),
(11, 'Juan Pablo Sorín', 3, 'Defensa', 1, 8, 60, 88.2, 3, 0, 'Argentina', 11),
(12, 'Riqui Puig', 12, 'Centrocampista', 3, 5, 50, 74.5, 1, 0, 'España', 12),
(13, 'Marcelo Martins', 9, 'Delantero', 18, 5, 40, 76.2, 2, 0,'Bolivia', 13),
(15, 'Neymar Jr.', 10, 'Delantero', 20, 15, 120, 80.1, 2, 1, 'Brasil', 15),
(16, 'Radamel Falcao', 9, 'Delantero', 12, 3, 30, 78.9, 1, 0, 'Colombia', 16),
(17, 'James Rodríguez', 10, 'Centrocampista', 7, 11, 90, 75.8, 3, 0, 'Colombia', 17),
(18, 'Arturo Vidal', 8, 'Centrocampista', 5, 4, 70, 81.2, 4, 1, 'Chile', 18),
(19, 'Enner Valencia', 13, 'Delantero', 17, 7, 60, 72.5, 3, 0, 'Ecuador', 19),
(20, 'Jorge Carrascal', 11, 'Centrocampista', 4, 2, 40, 68.9, 1, 0, 'Colombia', 20),
(21, 'Paolo Guerrero', 9, 'Delantero', 23, 11, 80, 79.5, 2, 0, 'Perú', 5),
(22, 'Renato Tapia', 17, 'Centrocampista', 1, 6, 50, 85.6, 5, 0, 'Perú', 7),
(23, 'Eduardo Vargas', 11, 'Delantero', 12, 4, 50, 74.9, 2, 0, 'Chile', 15),
(24, 'Giovani Lo Celso', 20, 'Centrocampista', 4, 6, 60, 78.3, 2, 1, 'Argentina', 14),
(25, 'Vinícius Júnior', 20, 'Delantero', 8, 3, 30, 67.5, 1, 0, 'Brasil', 12);

INSERT INTO liga (id, posicion, equipo_id, partidos_jugados, partidos_ganados, partidos_empatados, 
    partidos_perdidos, goles_a_favor, goles_en_contra, diferencia_de_goles, puntos)
    VALUES
    (1, 1, 1, 23, 14, 6, 3, 35, 15, 20, 48),
    (2, 2, 3, 23, 13, 5, 5, 30, 18, 12, 44),
    (3, 3, 4, 23, 10, 9, 4, 35, 24, 11, 39),
    (4, 4, 9, 23, 9, 10, 4, 27, 19, 8, 37),
    (5, 5, 13, 23, 8, 10, 5, 28, 22, 6, 34),
    (6, 6, 5, 23, 9, 6, 8, 29, 23, 6, 33),
    (7, 7, 10, 23, 8, 8, 7, 26, 22, 4, 32),
    (8, 8, 7, 23, 8, 7, 8, 27, 29, -2, 31),
    (9, 9, 6, 23, 7, 9, 7, 26, 23, 3, 30),
    (10, 10, 8, 23, 7, 8, 8, 28, 29, -1, 29),
    (11, 11, 16, 23, 7, 6, 10, 27, 28, -1, 27),
    (12, 12, 19, 23, 6, 8, 9, 21, 29, -8, 26),
    (13, 13, 11, 23, 6, 7, 10, 17, 30, -13, 25),
    (14, 14, 20, 23, 5, 8, 10, 24, 35, -11, 23),
    (15, 15, 15, 23, 4, 10, 9, 22, 28, -6, 22);

----------------------------------
-- nombre de jugadores que marcaron más de diez goles 
-- temporada 19-20
----------------------------------

SELECT nombre, goles FROM jugador WHERE goles >= 10; 

----------------------------------
-- tarjetas amarillas y rojas que recibieron
-- los equipos por temporada
----------------------------------

SELECT e.nombre, SUM(j.cantidad_amarillas), SUM(j.cantidad_rojas)
FROM jugador j
LEFT JOIN equipo e ON e.id = j.equipo_id
WHERE j.cantidad_amarillas >= 1 OR j.cantidad_rojas >= 1
GROUP BY e.nombre;

----------------------------------
-- consultar clasificación de los equipos
-- en una temporada
----------------------------------

SELECT t.posicion, e.nombre, t.puntos
FROM liga t
LEFT JOIN equipo e on e.id = t.equipo_id;

----------------------------------
-- equipo que marcó más goles 
-- en una temporada
----------------------------------

SELECT e.nombre, t.goles_a_favor goles
FROM liga t
LEFT JOIN equipo e ON t.equipo_id = e.id
WHERE t.goles_a_favor >= (SELECT MAX(goles_a_favor) FROM liga); 

----------------------------------
-- cantidad de partidos ganados
-- en una temporada por equipo
----------------------------------

SELECT e.nombre, t.partidos_ganados
FROM equipo e 
RIGHT JOIN liga t ON e.id = t.equipo_id; 

----------------------------------
-- nombre de jugador con más goles
----------------------------------

SELECT nombre, goles FROM jugador WHERE goles = (SELECT MAX(goles) FROM jugador);

----------------------------------
-- promedio de goles por partido
-- en la liga
----------------------------------

SELECT e.nombre, (l.goles_a_favor / l.partidos_jugados) as goles_promedio_x_partido
FROM liga l 
LEFT JOIN equipo e ON l.equipo_id = e.id;

----------------------------------
-- equipo con más hinchas
----------------------------------

SELECT nombre, cantidad_hinchas FROM equipo WHERE cantidad_hinchas = (SELECT MAX(cantidad_hinchas) FROM equipo); 