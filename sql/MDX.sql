/**
* Consulta 1
*/
SELECT
[Publisher].members ON COLUMNS,
[Genre].members ON ROWS
FROM [VG Sales]

/**
* Consulta 2
*/
SELECT
{[Publisher].[Publisher Name].members, [Publisher].[Region].members} ON COLUMNS,
[Genre].[PEGI].members ON ROWS
FROM [VG Sales]

/**
* Consulta 3
*/
SELECT
[Publisher].[Publisher Name].[THQ] ON COLUMNS,
[Genre].[PEGI].[7] ON ROWS
FROM [VG Sales]

/**
* Consulta 4
*/
SELECT
{[Genre].[Genre].members, [Publisher].[Publisher Name].[Nintendo]} ON COLUMNS,
[Platform].[Generation].[1] ON ROWS
FROM [VG Sales]
WHERE {[RegSales].[North America].members, [RegSales].[Japan].members}
-- Esta Consulta no arroja valores importantes

/**
* Consulta 5
*/
SELECT
{[RegSales].[Europe].members, [RegSales].[North America].members} ON COLUMNS,
[Genre].[PEGI].members ON ROWS
FROM [VG Sales]

/**
* Consulta 6
*/
SELECT
[Genre].[Genre].members ON COLUMNS,
[Publisher].[Region].members ON ROWS
FROM [VG Sales]
WHERE [Platform].[Platform].[PS]

/**
* Consulta 7
*/
SELECT
{[Genre].[Genre].[Adventure], [Genre].[Genre].[Role-Playing]} ON COLUMNS,
[Publisher].[Publisher Name].[Banpresto] ON ROWS
FROM [VG Sales]
WHERE [Platform].[Platform].[PS]
-- Tiene un error

/**
* Consulta 8
*/
SELECT
[Genre].[Genre].[Sports] ON COLUMNS,
[Publisher].[Publisher Name].[Banpresto] ON ROWS
FROM [VG Sales]
WHERE [Platform].[Platform].[PS]
-- Arroja error

/**
* Consulta 9
*/
SELECT
[Genre].[Genre].[Sports] ON COLUMNS,
[Publisher].[Publisher Name].[Nintendo] ON ROWS
FROM [VG Sales]

/**
* Consulta 10
*/
SELECT
{[Genre].[Genre].[Sports], [Genre].[Genre].[Adventure]} ON COLUMNS,
{[Publisher].[Publisher Name].[Pony Canyon], [Publisher].[Publisher Name].[Sunsoft]} ON ROWS
FROM [VG Sales]
