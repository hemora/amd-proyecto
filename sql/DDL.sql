/**
* Definición de tablas de dimensiones
*/

-- Genres dimension
CREATE TABLE genres_dim (
  id serial PRIMARY KEY,
  genre character varying(100) NOT NULL,
  pegi integer NOT NULL
);
COMMENT ON TABLE genres_dim IS
  'Dimension for genres related stuff';
-- On psql shell
\COPY genres_dim FROM '~/Desktop/amd-proyecto/data/genres-dim.csv' DELIMITER ',' CSV header;
--

-- Platform dimension
CREATE TABLE platform_dim (
  id serial PRIMARY KEY,
  platform character varying(10) NOT NULL,
  generation integer NOT NULL
);
COMMENT ON TABLE platform_dim IS
  'Dimension for platforms related stuff';
-- On psql shell
\COPY platform_dim FROM '~/Desktop/amd-proyecto/data/platform-dim.csv' DELIMITER ',' CSV header;
--

-- Publisher dimension
CREATE TABLE publisher_dim (
  id serial PRIMARY KEY,
  name character varying(150) NOT NULL,
  country character varying(150) NOT NULL,
  region character varying(150) NOT NULL
);
COMMENT ON TABLE publisher_dim IS
  'Dimension for publishers related stuff';
-- On psql shell
\COPY publisher_dim FROM '~/Desktop/amd-proyecto/data/publisher-dim.csv' DELIMITER ',' CSV header;
--

/**
* Tabla de hechos auxiliar
*/
CREATE TABLE vgsales_aux (
  vgrank integer NOT NULL,
  vgname character varying(200) NOT NULl,
  vgplat character varying(10) NOT NULL,
  vgyear integer NOT NULL,
  vggenre character varying(100) NOT NULL,
  vgpubli character varying(150) NOT NULL,
  na_sales real NOT NULL,
  eu_sales real NOT NULL,
  jp_sales real NOT NULL,
  other_sales real NOT NULL,
  global_sales real NOT NULL
);
COMMENT ON TABLE vgsales_aux IS
  'Dont deserve a comment';
-- On psql shell
\COPY vgsales_aux FROM '~/Desktop/amd-proyecto/data/vgsales.csv' DELIMITER ',' CSV header;
-- Pero había registros con 'N/A'
ALTER TABLE vgsales_aux
  ALTER COLUMN vgyear TYPE character varying(10);
-- On psql shell
\COPY vgsales_aux FROM '~/Desktop/amd-proyecto/data/vgsales.csv' DELIMITER ',' CSV header;
--

/**
* Construcción de tabla de hechos final
*/
-- Primero se crea la tabla
CREATE TABLE vgsales_fact(
  vgrank integer NOT NULL,
  vgname character varying(200) NOT NULl,
  platid integer NOT NULL,
  vgyear integer NOT NULL,
  genreid integer NOT NULL,
  publiid integer NOT NULL,
  na_sales real NOT NULL,
  eu_sales real NOT NULL,
  jp_sales real NOT NULL,
  other_sales real NOT NULL,
  global_sales real NOT NULL
);
-- Luego
SELECT vgrank,vgname,
platform_dim.id as platid,
vgyear,
genres_dim.id as genreid,
publisher_dim.id as publiid,
na_sales,eu_sales,jp_sales,other_sales,global_sales
INTO TABLE vgsales_fact
FROM ((vgsales_aux INNER JOIN genres_dim
ON vgsales_aux.vggenre = genres_dim.genre) INNER JOIN publisher_dim
ON vgsales_aux.vgpubli = publisher_dim.name) INNER JOIN platform_dim
ON vgsales_aux.vgplat = platform_dim.platform
ORDER BY vgrank asc;
--
