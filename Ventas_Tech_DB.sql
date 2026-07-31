-- creo  database 
CREATE DATABASE Ventas_Tech_DB; 
USE Ventas_Tech_DB;

--elimino tablas si es que ya existen respetando el orden inverso 
--de las dependencias para no violar las foreign key, primero las que tienen FKs
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

--creo las tablas

CREATE TABLE categorias(
id_categoria int NOT NULL IDENTITY (1,1) PRIMARY KEY,
nombre_categoria varchar(50) NOT NULL,
descripcion varchar(200) NOT NULL,
);

CREATE TABLE clientes(
id_cliente int NOT NULL IDENTITY(1,1) PRIMARY KEY,
nombre varchar(100) NOT NULL, 
email varchar(100) UNIQUE,
ciudad varchar(50),
segmento varchar(50), --va a ser corporativo o particular
fecha_registro DATE NOT NULL,
);

CREATE TABLE productos(
id_producto int NOT NULL IDENTITY(1,1) PRIMARY KEY,
nombre_producto varchar(100) NOT NULL, 
id_categoria int NOT NULL FOREIGN KEY REFERENCES categorias(id_categoria),
precio decimal(10,2) NOT NULL,
stock int DEFAULT 0,
activo tinyint DEFAULT 1,
);

CREATE TABLE ventas(
id_ventas int NOT NULL IDENTITY(1,1) PRIMARY KEY,
id_cliente int NOT NULL FOREIGN KEY REFERENCES clientes(id_cliente),
id_producto int NOT NULL FOREIGN KEY REFERENCES productos(id_producto),
cantidad int NOT NULL,
precio_unitario decimal(10,2) NOT NULL,
fecha_venta date NOT NULL
);


--inserto data, primero las tablas sin dependencias

INSERT INTO categorias VALUES ('Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias VALUES ('Accesorios', 'Periféricos y complementos');
INSERT INTO categorias VALUES ('Audio', 'Auriculares y parlantes');
INSERT INTO categorias VALUES ('Almacenamiento', 'Discos y memorias');

INSERT INTO clientes VALUES ('María López', 'maria@mail.com', 'Buenos Aires', 'Particular', '2024-01-05');
INSERT INTO clientes VALUES ('Carlos Ruiz', 'carlos@mail.com', 'Córdoba', 'Particular', '2024-01-10');
INSERT INTO clientes VALUES ('Ana Gómez', 'ana@mail.com', 'Rosario', 'Particular', '2024-02-01');
INSERT INTO clientes VALUES ('Pedro Sanz', 'pedro@mail.com', 'Mendoza', 'Particular', '2024-02-15');
INSERT INTO clientes VALUES ('Laura Torres', 'laura@mail.com',  'Tucumán', 'Particular', '2024-03-01');

INSERT INTO productos VALUES ('Laptop Pro 15', 1, 1200.00, 15, 1);
INSERT INTO productos VALUES ('Mouse Inalámbrico', 2, 28.00, 80, 1);
INSERT INTO productos VALUES ('Monitor 4K 27"', 1, 450.00, 12, 1);
INSERT INTO productos VALUES ('Auriculares BT Pro', 3, 120.00, 35, 1);
INSERT INTO productos VALUES ('SSD Externo 1TB', 4, 130.00, 18, 1);
INSERT INTO productos VALUES ('Teclado Mecánico', 2, 95.00, 40, 1);

INSERT INTO ventas VALUES (1, 1, 2, 1200.00, '2024-03-05');
INSERT INTO ventas VALUES (2, 2, 5,   28.00, '2024-03-06');
INSERT INTO ventas VALUES (3, 3, 1,  450.00, '2024-03-07');
INSERT INTO ventas VALUES (1, 4, 2,  120.00, '2024-03-08');
INSERT INTO ventas VALUES (4, 5, 3,  130.00, '2024-03-10');
INSERT INTO ventas VALUES (2, 6, 4,   95.00, '2024-03-11');
INSERT INTO ventas VALUES (5, 1, 1, 1200.00, '2024-03-12');
INSERT INTO ventas VALUES (3, 2, 8,   28.00, '2024-03-13');
INSERT INTO ventas VALUES (4, 4, 1,  120.00, '2024-03-14');
INSERT INTO ventas VALUES (5, 3, 2,  450.00, '2024-03-15');

SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;