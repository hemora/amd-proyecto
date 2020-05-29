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
-- Files must be in /tmp/
COPY genres_dim FROM '/tmp/genres-dim.csv' DELIMITER ',' CSV header;
--

-- Platform dimension
CREATE TABLE platform_dim (
  id serial PRIMARY KEY,
  platform character varying(10) NOT NULL,
  generation integer NOT NULL
);
COMMENT ON TABLE platform_dim IS
  'Dimension for platforms related stuff';
-- Files must be in /tmp/
COPY platform_dim FROM '/tmp/platform-dim.csv' DELIMITER ',' CSV header;
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
-- Files must be in /tmp/
COPY publisher_dim FROM '/tmp/publisher-dim.csv' DELIMITER ',' CSV header;
--

/**
* Tabla de hechos auxiliar
*/
CREATE TABLE vgsales_aux (
  vgrank integer NOT NULL,
  vgname character varying(200) NOT NULl,
  vgplat character varying(10) NOT NULL,
  vgyear character varying(10) NOT NULL,
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
-- Files must be in /tmp/
COPY vgsales_aux FROM '/tmp/vgsales.csv' DELIMITER ',' CSV header;
-- Pero había registros con 'N/A'
ALTER TABLE vgsales_aux
  ALTER COLUMN vgyear TYPE character varying(10);
-- On psql shell
COPY vgsales_aux FROM '/tmp/vgsales.csv' DELIMITER ',' CSV header;
--

/**
* Construcción de tabla de hechos final
*/
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
-- Asignación primary key
ALTER TABLE vgsales_fact
RENAME COLUMN vgrank TO id_pk;
ALTER TABLE vgsales_fact
ADD CONSTRAINT vgsales_pk PRIMARY KEY (id_pk);
-- ETL para quitar N/A's de vgyear
ALTER TABLE vgsales_fact ADD COLUMN vgyear_integer numeric(4,0);
UPDATE vgsales_fact
SET vgyear_integer = CASE WHEN vgyear = 'N/A' then NULL else vgyear:: integer end ;
ALTER TABLE vgsales_fact
DROP COLUMN vgyear;
ALTER TABLE vgsales_fact
RENAME COLUMN vgyear_integer TO vgyear;
--------------------------------------------------------------------------------------------------------------------------------
/**
* Tabla de dimensiones para ventas
*/
SELECT ROW_NUMBER() OVER (ORDER BY 1) as sales_id,
global_sales, na_sales, eu_sales, jp_sales, other_sales
INTO TABLE sales_dim
FROM vgsales_fact ORDER BY vgsales_fact.id_pk asc;
-- Agregar llave subrogada
ALTER TABLE sales_dim
ADD CONSTRAINT sales_pk PRIMARY KEY (sales_id);
--------------------------------------------------------------------------------------------------------------------------------
/**
* Creación de una definitiva tabla de hechos
*/
SELECT id_pk, vgname, vgyear, 
platid AS plat_id, genreid AS genre_id, publiid AS publi_id, 
sales_dim.sales_id, vgsales_fact.global_sales
INTO TABLE vgsales_facts_prueba
FROM vgsales_fact INNER JOIN sales_dim
ON vgsales_fact.id_pk = sales_dim.sales_id
ORDER BY id_pk asc;
--------------------------------------------------------------------------------------------------------------------------------
/**
* Renombre y eliminación de tablas
*/
DROP TABLE vgsales_aux CASCADE;
DROP TABLE vgsales_fact CASCADE;
ALTER TABLE vgsales_facts_prueba
RENAME TO vgsales_facts;
--------------------------------------------------------------------------------------------------------------------------------
/**
* Definición de llaves foráneas
*/
-- vgsales_facts ===> platform_dim
ALTER TABLE vgsales_facts
ADD CONSTRAINT plat_dim_fk FOREIGN KEY
(plat_id) REFERENCES platform_dim (id);
-- vgsales_facts ===> genre_dim
ALTER TABLE vgsales_facts
ADD CONSTRAINT gen_dim_fk FOREIGN KEY
(genre_id) REFERENCES genres_dim (id);
-- vgsales ===> publisher_dim
ALTER TABLE vgsales_facts
ADD CONSTRAINT publi_dim_fk FOREIGN KEY
(publi_id) REFERENCES publisher_dim (id);
-- vgsales ===> sales_dim
ALTER TABLE vgsales_facts
ADD CONSTRAINT sales_dim_fk FOREIGN KEY
(sales_id) REFERENCES sales_dim (sales_id);