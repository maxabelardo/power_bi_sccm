SELECT A.ResourceID
     , A.Name0 AS [Computer Name]
     , S.CompanyName
     , S.ProductName
	 , F.FileName
	 , F.FileVersion
	 , F.FilePath
FROM V_R_System AS A
INNER JOIN v_GS_SoftwareProduct AS S ON S.ResourceID = A.ResourceID
INNER JOIN v_GS_SoftwareFile AS F ON F.ResourceID = S.ResourceID AND F.ProductId = S.ProductID
WHERE S.ProductName LIKE '%AutoDesk%'