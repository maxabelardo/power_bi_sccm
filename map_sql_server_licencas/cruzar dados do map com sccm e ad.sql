USE [SCCM_view]
GO

SELECT DISTINCT
       LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
      ,[Computer Name]
	  ,[HostName] AS 'SCCM'
	  ,A.[Name]  AS 'ActiveDirectory'
      ,[SQL Server Instance Name]
      ,[SQL Server Product Name]
      ,[SQL Server Version]
      ,[SQL Server Service Pack]
      ,[SQL Server Edition]
      ,[Clustered?]
      ,[SQL Server Cluster Network Name]
      ,[SQL Service State]
      ,[SQL Service Start Mode]
      ,[Language]
      ,[SQL Server Sub-Directory]
      ,[Current Operating System]
      ,[Operating System Service Pack Level]
      ,[Operating System Architecture Type]
      ,[Number of Processors]
      ,[Number of Total Cores]
      ,[Number of Logical Processors]
      ,[CPU]
      ,[System Memory (MB)]
      ,[Logical Disk Drive Name]
      ,[Logical Disk Size (GB)]
      ,[Logical Disk Free Space (GB)]
      ,[Machine Type]
      ,[Number of Host Processors]
      ,[WMI Status]
  FROM [dbo].[DatabaseInstances] AS S
  LEFT JOIN [dbo].[VW_ServerHost] AS H ON H.[HostName] COLLATE DATABASE_DEFAULT  = LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
 LEFT JOIN [DBActiveDirectory].[AD].[STGADComputer] AS A ON A.[Name] COLLATE DATABASE_DEFAULT  = LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
WHERE [HostName] IS NOT NULL
 
GO


USE [SCCM_view]
GO

SELECT DISTINCT
       LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
      ,[Computer Name]
	  ,[HostName] AS 'SCCM'
	  ,A.[Name]  AS 'ActiveDirectory'
      ,[SQL Server Instance Name]
      ,[SQL Server Product Name]
      ,[SQL Server Version]
      ,[SQL Server Service Pack]
      ,[SQL Server Edition]
      ,[Clustered?]
      ,[SQL Server Cluster Network Name]
      ,[SQL Service State]
      ,[SQL Service Start Mode]
      ,[Language]
      ,[SQL Server Sub-Directory]
      ,[Current Operating System]
      ,[Operating System Service Pack Level]
      ,[Operating System Architecture Type]
      ,[Number of Processors]
      ,[Number of Total Cores]
      ,[Number of Logical Processors]
      ,[CPU]
      ,[System Memory (MB)]
      ,[Logical Disk Drive Name]
      ,[Logical Disk Size (GB)]
      ,[Logical Disk Free Space (GB)]
      ,[Machine Type]
      ,[Number of Host Processors]
      ,[WMI Status]
  FROM [dbo].[DatabaseInstances] AS S
  LEFT JOIN [dbo].[VW_ServerHost] AS H ON H.[HostName] COLLATE DATABASE_DEFAULT  = LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
  LEFT JOIN [DBActiveDirectory].[AD].[STGADComputer] AS A ON A.[Name] COLLATE DATABASE_DEFAULT  = LEFT([Computer Name], (CHARINDEX('.',[Computer Name])-1) )
WHERE [HostName] IS NULL
GO


