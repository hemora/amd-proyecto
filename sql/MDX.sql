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
