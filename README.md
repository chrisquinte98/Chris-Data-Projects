# RetailPro | Análisis de ventas y dashboard ejecutivo

## Descripción del proyecto

RetailPro es un proyecto de análisis de datos para una empresa distribuidora de tecnología. El objetivo es explorar y organizar la información comercial, transformar los datos de ventas en indicadores útiles y construir un dashboard ejecutivo que facilite la toma de decisiones.

El proyecto integra ejercicios y entregas de **SQL** y **Power BI**. La base de datos relacional contiene información de ventas, clientes, productos y categorías, lo que permite analizar el rendimiento comercial desde distintas perspectivas.

## Objetivos

- Analizar la estructura y la calidad de los datos de RetailPro.
- Relacionar ventas con clientes, productos y categorías.
- Calcular indicadores comerciales mediante consultas SQL.
- Identificar productos y clientes con mayor contribución a los ingresos.
- Evaluar recurrencia de clientes y comportamiento mensual de las ventas.
- Preparar una fuente de datos adecuada para un dashboard ejecutivo en Power BI.

## Herramientas utilizadas

- **SQL Server:** almacenamiento y consulta de la base de datos relacional.
- **SQL Server Management Studio (SSMS):** creación, ejecución y validación de scripts T-SQL.
- **T-SQL:** consultas, agregaciones, `JOIN`, CTE, filtros y cálculos comerciales.
- **Power BI:** modelado, visualización y construcción del dashboard ejecutivo.
- **Git y GitHub:** control de versiones y publicación de las entregas del proyecto.

## Estructura del repositorio

```text
Chris-Data-Projects/
├── Módulos SQL/          # Entregas, scripts y consultas de SQL
├── Módulos Power BI/     # Entregas y recursos del dashboard
├── .gitattributes
└── README.md
```

> La estructura puede evolucionar a medida que se incorporen nuevos módulos, scripts y archivos del dashboard.

## Modelo de datos

El análisis utiliza como tabla principal `ventas` y la complementa con tablas descriptivas:

- `ventas`: fecha, cliente, producto, cantidad y precio unitario.
- `clientes`: datos descriptivos y ubicación del cliente.
- `productos`: nombre del producto y categoría asociada.
- `categorias`: descripción de las categorías de producto.

La relación entre estas tablas permite construir una vista analítica con una fila por registro de venta y calcular el importe mediante:

```sql
total_venta = cantidad * precio_unitario
```

## Análisis incluidos

Entre las consultas desarrolladas se encuentran:

- Resumen ejecutivo mensual.
- Total facturado y cantidad de registros de venta.
- Ticket promedio.
- Ranking de productos por facturación y unidades vendidas.
- Identificación de clientes recurrentes.
- Comparación de cada mes frente al promedio mensual general.
- Integración de ventas con clientes, productos y categorías mediante `JOIN`.

## Requisitos

Antes de ejecutar los scripts, instala o prepara:

1. SQL Server.
2. SQL Server Management Studio (SSMS) u otro cliente compatible con SQL Server.
3. Acceso con permisos para crear y consultar bases de datos.
4. Power BI Desktop, si deseas abrir o ampliar las entregas de visualización.

## Cómo ejecutar los scripts SQL

### 1. Clonar el repositorio

```bash
git clone https://github.com/chrisquinte98/Chris-Data-Projects.git
cd Chris-Data-Projects
```

### 2. Abrir SQL Server Management Studio

Conecta SSMS a la instancia local o remota de SQL Server en la que ejecutarás el proyecto.

### 3. Crear y cargar la base de datos

Localiza el script de creación o carga correspondiente dentro de `Módulos SQL`. Ábrelo en SSMS y ejecútalo completo.

Si el repositorio incluye el archivo `Ventas_Tech_DB.sql`, ejecútalo primero cuando dicho archivo contenga la creación de la base de datos, las tablas o la carga inicial de datos.

### 4. Seleccionar la base de datos

Antes de ejecutar las consultas analíticas, comprueba que el contexto sea el correcto:

```sql
USE Ventas_Tech_DB;
GO
```

### 5. Ejecutar las consultas en orden

Ejecuta primero los scripts de estructura y carga, y después los scripts de análisis. Un orden recomendado es:

1. Creación de la base de datos.
2. Creación de tablas y relaciones.
3. Inserción o carga de datos.
4. Validaciones de calidad.
5. Consultas de análisis.
6. Vista consolidada para Power BI.

### 6. Validar la carga

Puedes comprobar que las tablas contienen datos con:

```sql
SELECT COUNT(*) AS total_ventas FROM dbo.ventas;
SELECT COUNT(*) AS total_clientes FROM dbo.clientes;
SELECT COUNT(*) AS total_productos FROM dbo.productos;
SELECT COUNT(*) AS total_categorias FROM dbo.categorias;
```

### 7. Ejecutar una consulta consolidada

```sql
SELECT
    v.fecha_venta,
    c.nombre AS nombre_cliente,
    c.ciudad AS ciudad_cliente,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    CAST(v.cantidad * v.precio_unitario AS decimal(18, 2)) AS total_venta
FROM dbo.ventas AS v
LEFT JOIN dbo.clientes AS c
    ON c.id_cliente = v.id_cliente
LEFT JOIN dbo.productos AS p
    ON p.id_producto = v.id_producto
LEFT JOIN dbo.categorias AS cat
    ON cat.id_categoria = p.id_categoria;
```

> Si los nombres de columnas del script original son diferentes, ajusta `nombre`, `nombre_producto` o `nombre_categoria` según el esquema de la base de datos.

## Indicadores sugeridos para el dashboard

- Facturación total.
- Unidades vendidas.
- Número de pedidos o ventas.
- Ticket promedio.
- Clientes únicos y recurrentes.
- Facturación por producto y categoría.
- Facturación por ciudad o región.
- Evolución mensual de las ventas.
- Participación de los principales clientes y productos.

## Consideraciones de análisis

- Verifica la granularidad de la tabla `ventas`. Si una venta contiene varias líneas, utiliza `COUNT(DISTINCT id_venta)` para calcular pedidos reales.
- Incluye el año junto con el mes al agrupar periodos, para evitar combinar el mismo mes de años diferentes.
- Conserva todas las ventas con `LEFT JOIN` cuando el objetivo sea detectar registros sin correspondencia en tablas descriptivas.
- Valida claves duplicadas antes de sumar importes después de un `JOIN`.
- Evita `SELECT *` en las consultas finales y selecciona únicamente los campos necesarios.

## Próximos pasos

- Completar el análisis histórico con varios meses de ventas.
- Crear una vista analítica estable para Power BI.
- Incorporar métricas de margen si existe información de costes.
- Añadir segmentación de clientes, productos y zonas geográficas.
- Documentar las medidas DAX y las decisiones de diseño del dashboard.

## Autor

**Chris Quinte**  
Repositorio: [Chris-Data-Projects](https://github.com/chrisquinte98/Chris-Data-Projects)

## Estado del proyecto

Proyecto en desarrollo como parte de un proceso de formación y construcción de portafolio en análisis de datos.
