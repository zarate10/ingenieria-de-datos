DROP DATABASE IF EXISTS biblioteca; 
GO
CREATE DATABASE biblioteca; 
GO
USE biblioteca; 
GO
DROP TABLE IF EXISTS autor; 
CREATE TABLE autor (
	id INT NOT NULL IDENTITY,
	nombre VARCHAR(50) NOT NULL, 
	fecha_nac DATE, 
	CONSTRAINT pk_autor PRIMARY KEY (id), 

)
GO
DROP TABLE IF EXISTS genero; 
CREATE TABLE genero (
	id INT NOT NULL IDENTITY, 
	nombre VARCHAR(50) NOT NULL,
	CONSTRAINT pk_genero PRIMARY KEY (id)
)
GO
DROP TABLE IF EXISTS libro; 
CREATE TABLE libro (
	id INT NOT NULL IDENTITY, 
	titulo VARCHAR(40) NOT NULL, 
	id_autor INT NOT NULL,
	id_genero INT NOT NULL,
	anio_publicacion DATE,
	CONSTRAINT pk_libro PRIMARY KEY (id), 
	CONSTRAINT fk_autor FOREIGN KEY (id_autor) REFERENCES autor(id), 
	CONSTRAINT fk_genero FOREIGN KEY (id_genero) REFERENCES genero(id)
)
GO
DROP TABLE IF EXISTS nacionalidad; 
CREATE TABLE nacionalidad (
	id INT NOT NULL IDENTITY,
	nac VARCHAR(5) NOT NULL,
	CONSTRAINT pk_nacionalidad PRIMARY KEY (id)
)
GO
DROP TABLE IF EXISTS usuario; 
CREATE TABLE usuario (
	id INT NOT NULL IDENTITY,
	nombre VARCHAR(50) NOT NULL,
	genero BIT NOT NULL, -- 0femenino --1masculino 
	id_nacionalidad INT NOT NULL, 
	edad INT NOT NULL, 
	CONSTRAINT pk_usuario PRIMARY KEY (id), 
	CONSTRAINT fk_nacionalidad FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad(id)
) 
GO
DROP TABLE IF EXISTS prestamo; 
CREATE TABLE prestamo (
	id INT NOT NULL IDENTITY,
	fecha_prestamo DATE NOT NULL, 
	fecha_devolucion DATE NOT NULL, 
	devuelto BIT NOT NULL, 
	id_libro INT NOT NULL, 
	id_usuario INT NOT NULL, 
	CONSTRAINT pk_prestamo PRIMARY KEY (id),
	CONSTRAINT fk_libro FOREIGN KEY (id_libro) REFERENCES libro(id),
	CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id)
)
GO
EXEC sp_MSforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"