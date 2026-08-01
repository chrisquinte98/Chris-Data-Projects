-- Consulta 1  | Vista base del proyecto (INNER JOIN)

USE Ventas_Tech_DB;
SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;

SELECT
v.fecha_venta,
c.nombre as nombre_cliente,
c.ciudad as region,
p.nombre_producto as nombre_producto,
p.id_categoria as categoria,
v.cantidad,
v.precio_unitario,
v.cantidad * v.precio_unitario as total_venta
FROM ventas as v
INNER JOIN clientes as c
	ON v.id_cliente = c.id_cliente
INNER JOIN productos as p
	ON v.id_producto = p.id_producto;

-- Consulta 2 | Clientes sin ventas (LEFT JOIN)

SELECT
c.nombre,
c.email,
c.fecha_registro
FROM clientes as c
LEFT JOIN ventas as v
	ON c.id_cliente = v.id_cliente
	WHERE v.id_cliente IS NULL; -- Esta consulta me indica que todos han comprado y por eso no hay registros

-- Consulta 3 | Productos sin ventas

SELECT
p.nombre_producto,
p.id_categoria as categoria,
p.precio
FROM productos as p
LEFT JOIN ventas as v
	ON p.id_producto = v.id_producto
	WHERE v.id_cliente IS NULL; -- Esta consulta me indica que todos los productos han tenido venta
								-- y por eso no hay registros cuando la ejecuto con IS NULL

-- Consulta 4 | Consolidado por canal (UNION ALL)

-- En la data original no traía información de canal, así que agrego info ficticia 
ALTER TABLE ventas
ADD canal varchar(20);

UPDATE ventas
SET canal = CASE
	WHEN id_ventas % 2 = 0 THEN 'Online'
	ELSE 'Presencial'
END;

SELECT * FROM ventas;

-- Ahora si ejecuto con UNION ALL 
SELECT
	canal,
	SUM(total_venta) AS total_por_canal
FROM (
	SELECT
		'Online' AS canal,
		cantidad * precio_unitario AS total_venta
	FROM ventas
	WHERE canal = 'Online'

	UNION ALL

	SELECT
		'Presencial' AS canal,
		cantidad * precio_unitario AS total_venta
	FROM ventas
	WHERE canal = 'Presencial'
) AS consolidado
GROUP BY canal;
