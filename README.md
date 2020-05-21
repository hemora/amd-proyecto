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
