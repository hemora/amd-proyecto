-- Nueva dimensión para Años y el nombre de los juegos
SELECT 
ROW_NUMBER() OVER (ORDER BY 1) as games_id, 
vgname, vgyear
INTO TABLE games_dim
FROM vgsales_facts ORDER BY vgsales_facts.id_pk asc;
COMMENT ON TABLE games_dim IS
  'Tabla de dimensiones para los juegos y el año';
ALTER TABLE games_dim
ADD CONSTRAINT games_pk PRIMARY KEY (games_id);
-------------------------------------------------------
-- Nueva tabla de hechos
SELECT 
id_pk, games_id, plat_id, genre_id, publi_id,
vgsales_facts.global_sales, na_sales, eu_sales, jp_sales, other_sales
INTO TABLE aux_facts
FROM 
(vgsales_facts INNER JOIN sales_dim 
ON vgsales_facts.sales_id = sales_dim.sales_id ) INNER JOIN games_dim
ON vgsales_facts.id_pk = games_dim.games_id;
--
DROP TABLE sales_dim CASCADE;
DROP TABLE vgsales_facts CASCADE;
ALTER TABLE aux_facts
RENAME TO vgsales_facts;
--------------------------------------------------------------------
-- Unificar nombre de llaves
ALTER TABLE genres_dim 
RENAME COLUMN id TO genre_id;
--
ALTER TABLE platform_dim 
RENAME COLUMN id TO plat_id;
--
ALTER TABLE publisher_dim
RENAME COLUMN id TO publi_id;
--------------------------------------------------------------------
