/*
Este script foi utilizado para extrair uma relação de maquinas que foram instalado uma aplicação especifica.

neste caso a aplciação AUTODESK


*/


SELECT DISTINCT 
       DP.Regiao
	 , DP.Dep
	 , DP.ADSite
     , PC.Netbios_Name0 AS 'Comoputador'
     , SO.Caption0      AS 'Sistema Operacional'
/*	 , SF.Publisher0
	 , SF.DisplayName0
	 , SF.Version0*/
	 , S.CompanyName, S.ProductName, F.FileName, F.FileVersion, F.FilePath
FROM V_R_System AS PC 
INNER JOIN V_GS_OPERATING_SYSTEM AS SO ON SO.ResourceID = PC.ResourceID
INNER JOIN v_GS_Mapped_Add_Remove_Programs AS SF ON SF.ResourceID = PC.ResourceID
INNER JOIN (SELECT DISTINCT
	Hostname,
	'Regiao' = CASE
		WHEN Dep in ('SEDE','SEDE-PR') THEN 'SEDE'
		WHEN Dep in ('SBGR','SBBR','TADN','SBMT','SBSP','SBKP','TABU','SBCG','SBCR','SBSJ','SBPP','TARP','SBGO','SBCY','TAAT','SBPJ','TABW','TAPN') THEN 'CSSP'
		WHEN Dep in ('SBGL','SBJR','SBRJ','TASF','SBCP','SBCF','SBME','CSRJ','SBPR','SBVO','SBVT','SBBH','SBMK','CSBH','SBPC','SBUL','SBUR') THEN 'CSRJ'
		WHEN Dep in ('SBRF','SBPL','SBJU','SBFZ','SBMS','SBKG','SBPB','SBTE','SBJP','SBSV','SBMO','TALP','SBAR','SBIL','SBUF') THEN 'CSRF'
		WHEN Dep in ('SBPA','SBCM','SBCT','SBLO','SBJV','SBNF','SBFL','SBBI','SBFI','SBUG','SBPK','SBBG') THEN 'CSPA'
		WHEN Dep in ('SBEG','SBRB','SBTT','SBBV','SBTF','SBPV','SBCZ','TAIC','TAMY','TATK','SBBE','SBSN','TACI','SBSL','TAEK','SBMQ','TAIH','SBHT','SBMD','SBMA','SBTU','TAAA','SBCJ','SBJC','SBIZ') THEN 'CSMN'
		ELSE '_NI'
		END,
	ADSite,
	Dep
FROM
(
SELECT DISTINCT
	SYS.Name0 as 'Hostname',
	SYS.AD_Site_Name0 as 'ADSite',
	'Dep' = CASE
		-- SEDE 
		WHEN (IP.IP_Subnets0 like '10.0.%') or (IP.IP_Subnets0 like '10.9.%') THEN 'SEDE'
		WHEN (IP.IP_Subnets0 like '10.8.%') THEN 'SEDE-PR'

		-- CSRJ
		WHEN (IP.IP_Subnets0 like '10.1.%') or (IP.IP_Subnets0 like '10.143.%') THEN 'SBGL'
		WHEN (IP.IP_Subnets0 like '10.30.%') THEN 'SBJR'
		WHEN (IP.IP_Subnets0 like '10.31.%') THEN 'SBRJ'
		WHEN (IP.IP_Subnets0 like '10.32.128.%') THEN 'TASF'
		WHEN (IP.IP_Subnets0 like '10.32.%') THEN 'SBCP'
		WHEN (IP.IP_Subnets0 like '10.33.%') THEN 'SBME'
		WHEN (IP.IP_Subnets0 like '10.36.%') THEN 'CSRJ'
		WHEN (IP.IP_Subnets0 like '10.30.128.%') THEN 'SBPR'
		WHEN (IP.IP_Subnets0 like '10.34.128.%') THEN 'SBVO'
		WHEN (IP.IP_Subnets0 like '10.34.%') THEN 'SBVT'
		WHEN (IP.IP_Subnets0 like '10.35.%') THEN 'SBBH'
		WHEN (IP.IP_Subnets0 like '10.37.%') THEN 'SBMK'
		WHEN (IP.IP_Subnets0 like '10.38.%') THEN 'SBCF'
		WHEN (IP.IP_Subnets0 like '10.39.%') THEN 'CSBH'
		WHEN (IP.IP_Subnets0 like '10.49.%') THEN 'SBPC'
		WHEN (IP.IP_Subnets0 like '10.82.%') THEN 'SBUL'
		WHEN (IP.IP_Subnets0 like '10.83.%') THEN 'SBUR'

		-- CSSP
		WHEN (IP.IP_Subnets0 like '10.2.%') THEN 'SBGR'
		WHEN (IP.IP_Subnets0 like '10.6.%') THEN 'SBBR'
		WHEN (IP.IP_Subnets0 like '10.40.128.%') THEN 'TADN'
		WHEN (IP.IP_Subnets0 like '10.40.%') THEN 'SBMT'
		WHEN (IP.IP_Subnets0 like '10.41.%') THEN 'SBSP'
		WHEN (IP.IP_Subnets0 like '10.42.%') or (IP.IP_Subnets0 like '10.11.44.%')  THEN 'SBKP'
		WHEN (IP.IP_Subnets0 like '10.43.%') THEN 'TABU'
		WHEN (IP.IP_Subnets0 like '10.44.%') THEN 'SBCG'
		WHEN (IP.IP_Subnets0 like '10.45.%') THEN 'SBCR'
		WHEN (IP.IP_Subnets0 like '10.46.%') THEN 'SBSJ'
		WHEN (IP.IP_Subnets0 like '10.47.%') THEN 'SBPP'
		WHEN (IP.IP_Subnets0 like '10.48.%') THEN 'TARP'
		WHEN (IP.IP_Subnets0 like '10.80.%') THEN 'SBGO'
		WHEN (IP.IP_Subnets0 like '10.81.%') THEN 'SBCY'
		WHEN (IP.IP_Subnets0 like '10.84.%') THEN 'TAAT'
		WHEN (IP.IP_Subnets0 like '10.85.%') THEN 'SBPJ'
		WHEN (IP.IP_Subnets0 like '10.86.%') THEN 'TABW'
		WHEN (IP.IP_Subnets0 like '10.87.%') THEN 'TAPN'
			
		-- CSMN
		WHEN (IP.IP_Subnets0 like '10.3.%') THEN 'SBEG'
		WHEN (IP.IP_Subnets0 like '10.50.%') THEN 'SBRB'
		WHEN (IP.IP_Subnets0 like '10.51.%') THEN 'SBTT'
		WHEN (IP.IP_Subnets0 like '10.52.%') THEN 'SBBV'
		WHEN (IP.IP_Subnets0 like '10.53.%') THEN 'SBTF'
		WHEN (IP.IP_Subnets0 like '10.54.%') THEN 'SBPV'
		WHEN (IP.IP_Subnets0 like '10.55.%') THEN 'SBCZ'
		WHEN (IP.IP_Subnets0 like '10.56.%') THEN 'TAIC'
		WHEN (IP.IP_Subnets0 like '10.57.%') THEN 'TAMY'
		WHEN (IP.IP_Subnets0 like '10.58.%') THEN 'TATK'
		WHEN (IP.IP_Subnets0 like '10.7.%') THEN 'SBBE'
		WHEN (IP.IP_Subnets0 like '10.90.%') THEN 'SBSN'
		WHEN (IP.IP_Subnets0 like '10.91.128.%') THEN 'TACI'
		WHEN (IP.IP_Subnets0 like '10.91.%') THEN 'SBSL'
		WHEN (IP.IP_Subnets0 like '10.92.128.%') THEN 'TAEK'
		WHEN (IP.IP_Subnets0 like '10.92.%') THEN 'SBMQ'
		WHEN (IP.IP_Subnets0 like '10.93.128.%') THEN 'TAIH'
		WHEN (IP.IP_Subnets0 like '10.93.%') THEN 'SBHT'
		WHEN (IP.IP_Subnets0 like '10.94.128.%') THEN 'SBMD'
		WHEN (IP.IP_Subnets0 like '10.94.%') THEN 'SBMA'
		WHEN (IP.IP_Subnets0 like '10.95.128.%') THEN 'SBTU'
		WHEN (IP.IP_Subnets0 like '10.95.%') THEN 'TAAA'
		WHEN (IP.IP_Subnets0 like '10.96.%') THEN 'SBCJ'
		WHEN (IP.IP_Subnets0 like '10.97.%') THEN 'SBJC'
		WHEN (IP.IP_Subnets0 like '10.99.%') THEN 'SBIZ'

		-- CSPA
		WHEN (IP.IP_Subnets0 like '10.4.%') THEN 'SBPA'
		WHEN (IP.IP_Subnets0 like '10.60.128.%') THEN 'SBCM'
		WHEN (IP.IP_Subnets0 like '10.60.%') THEN 'SBCT'
		WHEN (IP.IP_Subnets0 like '10.61.%') THEN 'SBLO'
		WHEN (IP.IP_Subnets0 like '10.62.%') THEN 'SBJV'
		WHEN (IP.IP_Subnets0 like '10.63.%') THEN 'SBNF'
		WHEN (IP.IP_Subnets0 like '10.64.%') THEN 'SBFL'
		WHEN (IP.IP_Subnets0 like '10.65.%') THEN 'SBBI'
		WHEN (IP.IP_Subnets0 like '10.66.%') THEN 'SBFI'
		WHEN (IP.IP_Subnets0 like '10.67.%') THEN 'SBUG'
		WHEN (IP.IP_Subnets0 like '10.68.%') THEN 'SBPK'
		WHEN (IP.IP_Subnets0 like '10.69.%') THEN 'SBBG'
			
		-- CSRF
		WHEN (IP.IP_Subnets0 like '10.5.%') THEN 'SBRF'
		WHEN (IP.IP_Subnets0 like '10.70.128.0') or (IP.IP_Subnets0 like '10.70.147.0') or (IP.IP_Subnets0 like '10.70.156.0') THEN 'SBPL'
		WHEN (IP.IP_Subnets0 like '10.70.%') THEN 'SBSV'
		WHEN (IP.IP_Subnets0 like '10.71.128.%') THEN 'SBJU'
		WHEN (IP.IP_Subnets0 like '10.71.%') THEN 'SBFZ'
		WHEN (IP.IP_Subnets0 like '10.73.%') THEN 'SBMS'
		WHEN (IP.IP_Subnets0 like '10.75.%') THEN 'SBKG'
		WHEN (IP.IP_Subnets0 like '10.76.128.%') THEN 'SBPB'
		WHEN (IP.IP_Subnets0 like '10.76.%') THEN 'SBTE'
		WHEN (IP.IP_Subnets0 like '10.78.%') THEN 'SBJP'
		WHEN (IP.IP_Subnets0 like '10.72.%') THEN 'SBMO'
		WHEN (IP.IP_Subnets0 like '10.74.128.%') THEN 'TALP'
		WHEN (IP.IP_Subnets0 like '10.74.%') THEN 'SBAR'
		WHEN (IP.IP_Subnets0 like '10.77.%') THEN 'SBIL'
		WHEN (IP.IP_Subnets0 like '10.79.%') THEN 'SBUF'
			
		-- Não Identificado
		ELSE '_NI'
		END
	
FROM
	v_R_System SYS
	LEFT JOIN v_RA_System_IPSubnets IP ON SYS.ResourceID = IP.ResourceID
WHERE
	(IP.IP_Subnets0 like '10.%'
	and IP.IP_Subnets0 not like '%.0.0')
	or (SYS.Client0 is null)
) as Temp
) AS DP ON DP.Hostname = PC.Netbios_Name0
INNER JOIN v_GS_SoftwareProduct AS S ON S.ResourceID = PC.ResourceID
INNER JOIN v_GS_SoftwareFile AS F ON F.ResourceID = S.ResourceID AND F.ProductId = S.ProductID

WHERE --SO.Caption0 LIKE '%SERVER%' AND 
S.ProductName LIKE '%AutoDesk%'
