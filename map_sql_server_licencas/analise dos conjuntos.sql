USE [SCCM_view]
GO

SELECT DISTINCT COUNT(*) 'Exist no SCCM e no AD.'
       /*LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
      ,[Computer Name]
	  ,[HostName] AS 'SCCM'
	  ,A.[Name]  AS 'ActiveDirectory'*/
  FROM [dbo].[DatabaseInstances] AS S
  LEFT JOIN [dbo].[VW_ServerHost] AS H ON H.[HostName] COLLATE DATABASE_DEFAULT  = LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
 LEFT JOIN [DBActiveDirectory].[AD].[STGADComputer] AS A ON A.[Name] COLLATE DATABASE_DEFAULT  = LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
WHERE [HostName] IS NOT NULL AND A.[Name] IS NOT NULL

SELECT DISTINCT COUNT(*) AS 'Não existe nem no SCCM nem no AD.' /*
       LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
      ,[Computer Name]
	  ,[HostName] AS 'SCCM'
	  ,A.[Name]  AS 'ActiveDirectory'*/
  FROM [dbo].[DatabaseInstances] AS S
  LEFT JOIN [dbo].[VW_ServerHost] AS H ON H.[HostName] COLLATE DATABASE_DEFAULT  = LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
  LEFT JOIN [DBActiveDirectory].[AD].[STGADComputer] AS A ON A.[Name] COLLATE DATABASE_DEFAULT  = LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
WHERE [HostName] IS NULL AND A.[Name] IS NULL

--------------------------------

SELECT DISTINCT COUNT(*) AS 'Existe apenas no SCCM'
       /*LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
      ,[Computer Name]
	  ,[HostName] AS 'SCCM'
	  ,A.[Name]  AS 'ActiveDirectory'*/
  FROM [dbo].[DatabaseInstances] AS S
  LEFT JOIN [dbo].[VW_ServerHost] AS H ON H.[HostName] COLLATE DATABASE_DEFAULT  = LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
 LEFT JOIN [DBActiveDirectory].[AD].[STGADComputer] AS A ON A.[Name] COLLATE DATABASE_DEFAULT  = LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
WHERE [HostName] IS NOT NULL AND A.[Name] IS NULL

SELECT DISTINCT COUNT(*) AS 'Existe apenas no AD.'/*
       LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
      ,[Computer Name]
	  ,[HostName] AS 'SCCM'
	  ,A.[Name]  AS 'ActiveDirectory'*/
  FROM [dbo].[DatabaseInstances] AS S
  LEFT JOIN [dbo].[VW_ServerHost] AS H ON H.[HostName] COLLATE DATABASE_DEFAULT  = LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
  LEFT JOIN [DBActiveDirectory].[AD].[STGADComputer] AS A ON A.[Name] COLLATE DATABASE_DEFAULT  = LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
WHERE [HostName] IS NULL AND A.[Name] IS NOT NULL


