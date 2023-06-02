create database club;

use club;

create table socio (
	dni varchar(250) not null primary key,
	nombre varchar(250) not null,
	edad integer not null,
	estado bit not null,
	dni_responsable varchar(250) not null,
	foreign key (dni_responsable) references socio(dni)
);

create table actividad (
	id integer not null primary key,
	nombre varchar(250) not null,
	valor float not null,
	cupo integer not null
);

create table elemento (
	id integer not null primary key,
	nombre varchar(250) not null,
	valor float not null
);

create table cuota (
	id integer not null primary key,
	valor_n float not null,
	valor_a float not null,
	vencimiento integer not null
);

create table actividad_socio (
	id_actividad integer not null,
	dni varchar(250) not null,
	primary key (id_actividad, dni),
	foreign key (id_actividad) references actividad(id),
	foreign key (dni) references socio(dni)
);

create table elemento_socio (
	id_elemento integer not null,
	dni varchar(250) not null,
    fecha_alq date not null,
    fecha_devol date,
	primary key (id_elemento, dni),
	foreign key (id_elemento) references elemento(id),
	foreign key (dni) references socio(dni)
);

create table cuota_socio (
	id_cuota integer not null,
	dni varchar(250) not null,
	primary key (id_cuota, dni),
	foreign key (id_cuota) references cuota(id),
	foreign key (dni) references socio(dni)
);