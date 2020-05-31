# Almacenes y Minería de Datos
## Proyecto
### Gómez Mora Héctor Eduardo (312296414) *312296414@ciencias.unam.mx*

# Bitácora.

# 14/05/2020
Se obtuvieron datos concernientes a la venta de videojuegos en diferentes mercados a través de la plataforma [Kaggle](https://www.kaggle.com/gregorut/videogamesales).

Dicho dataset cuenta con 11 atributos:
- **Rank**: El ranking sobre las ventas totales
- **Name**: El nombre del videojuego
- **Platform**: El nombre de la plataforma de lanzamiento.
- **Year**: Año de lanzamiento
- **Genre**: Género del juego
- **Publisher**: Empresa distribuidora del juego
- **NA_Sales**: Ventas en Norte América (en millones)
- **EU_Sales**: Ventas de Europa (en millones)
- **JP_Sales**: Ventas en Japón (en millones)
- **Other_Sales**: Ventas de los sitios restantes (en millones)
- **Global_Sales**: Ventas en el mundo (en millones)

y 16598 registros.

# 20/05/2020
El dataset entero servirá como tabla de hechos y a partir de sus atributos se proponen las siguientes dimensiones:

- Year
- PlatformId -> Generation -> Platform
- GenreId -> PEGI -> Genre
- PubliId -> Publisher -> PubliCountry

También se puede apreciar en el siguiente [diagrama](figures/snowflake.dia)

Con python comenzaron a realizarse procesos ETL que permiten generar las correspondientes tablas de dimensiones.

En particular hoy se terminó de generar la dimensión Publisher mediante el script `sql/etl/Publisher-ETL.py` y el dataset generado se guardó en el archivo `data/publisher-dim.csv`.

# 21/05/2020
Se crearon los datasets correspondientes a las dimensiones de *Genre* y *Platform*. Para la primera se le asocio a cada género una etiqueta **PEGI**(Pan European Game Information) de forma aleatoria, mientras que a cada plataforma se le asoció una generación igualmente aleatoria.

# 25/05/2020

- [x] Construir las tablas de dimensiones y una tabla de hechos auxiliar en Postgres

Se descubrió que había **271** registros con el año marcado como 'N/A' para la tabla de hechos auxiliar.

- [x] Construir la tabla de hechos final mediante joins y proyecciones con las tablas de dimensiones

# 28/05/2020

- [x] Setear los atributos de vgsales_fact a no nulos
- [x] Asignar foreign keys

# 31/05/2020

- [x] Creación de una tabla de dimensiones para las ventas por países
- [x] A partir de la anterior sustitución se creo una tabla de hechos definitiva
- [x] Eliminación de tablas sin utilizar
- [x] Asignación de foreign keys
