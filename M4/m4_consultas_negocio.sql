-- Consulta 1 | Resumen ejecutivo mensual

SELECT * FROM ventas;

SELECT
MONTH(fecha_venta) as mes, -- En SQL Server, la equivalencia de EXTRACT(MONTH FROM fecha_venta) sería MONTH
SUM(cantidad * precio_unitario) as total_facturado, 
COUNT(*) as cantidad_pedidos,
AVG(cantidad * precio_unitario) as ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);

-- Consulta 2 | Ranking de productos

SELECT TOP 5 -- En SQL Server, la equivalencia de LIMIT es TOP en el SELECT
id_producto as producto,
SUM(cantidad) as unidades_vendidas,
SUM(cantidad * precio_unitario) as total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- Consulta 3 | Clientes recurrentes

SELECT
id_cliente as cliente,
COUNT(*) as cantidad_pedidos,
SUM(cantidad * precio_unitario) as total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;

-- Consulta 4 — Meses por encima/por debajo del promedio

WITH ventas_mensuales as ( -- WITH lo uso para 2 tablas temporales
    -- Calculo el total facturado por cada mes
    SELECT 
        MONTH(fecha_venta) as mes,
        SUM(cantidad * precio_unitario) as total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
),
    promedio_general as (
    -- Obtenego el promedio mensual general
    SELECT 
        AVG(total_facturado) as promedio_mensual
    FROM ventas_mensuales
)
-- Comparo cada mes con el promedio
SELECT 
    v.mes,
    v.total_facturado,
    ROUND(p.promedio_mensual, 2) as promedio_general,
    CASE 
        WHEN v.total_facturado >= p.promedio_mensual THEN 'Por encima'
        ELSE 'Por debajo'
    END as estado -- todo el CASE se va a calcular en una nueva columna y allí evalua la condición
FROM ventas_mensuales as v
CROSS JOIN promedio_general as p -- Une el total de cada mes con el promedio general para poder 
                                 -- compararlos en la misma fila.

-- INSIGHTS --

/* 1. Las ventas de los productos 1 y 3 representan más del 80% de total del mes de marzo
   2. El producto 2 a pesar de a verse vendido 13 veces solo representó un 6% de las ventas totales
   3. Cada uno de los 5 clientes realizó 2 pedidos durante el mes de marzo */
