/**
* Repositorio de consultas MDX para poner en Resultados
*/

-- 1
SELECT
	[Genre].[Genre].members ON COLUMNS,
	[Measures].[NAUnit]ON ROWS
FROM [VG Sales]
--

-- 2
SELECT
	[Games].[GameName].[Super Mario Bros. 3] ON COLUMNS,
	{[Measures].[NAUnit], [Measures].[JPUnit], [Measures].[GlobalUnit]} ON ROWS
FROM [VG Sales]
--

-- 3
SELECT
	CROSSJOIN(
		[Publisher].[Region].members,
		[Platform].[Platform].[GB]
	) ON COLUMNS,
	{[Measures].[NAUnit], [Measures].[JPUnit], [Measures].[GlobalUnit]} ON ROWS
FROM [VG Sales]
--
