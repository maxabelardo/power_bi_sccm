# Criando o painel com o Power BI Desktop

No Power BI Desktop é possível fazer os relacionamentos e todos os tratamento dos dados das "View" visões necessária para a criação do painel, porem neste projeto vamos fazer o máximo de ralacionamento e tratamento dos dados dentro das "Query's" de extração dos dados.

### Lista das "View" utilizada no projeto.
* v_GS_COMPUTER_SYSTEM
* v_GS_SYSTEM_ENCLOSURE
* v_R_System
* v_GS_OPERATING_SYSTEM
* v_GS_DISK
* v_GS_PROCESSOR
* v_Add_Remove_Programs
* v_GS_NETWORK_ADAPTER
* v_GS_NETWORK_ADAPTER_CONFIGURATION
* v_GS_X86_PC_MEMORY

## Query's de extração de dados:


### Query Principal "Objetos"
Lista de servidores e estações de trabalho, com todas as informações unitária dos objetos.


Nestá "query" consulta serão utilizada as "View" visões.
* v_R_System
* v_GS_COMPUTER_SYSTEM
* v_GS_OPERATING_SYSTEM
* v_GS_X86_PC_MEMORY
* v_GS_SYSTEM_ENCLOSURE
* v_GS_PROCESSOR

#### "Query" consulta:
```
SELECT RS.[ResourceID]         
     , CS.[Manufacturer0]                AS 'Fabricante'
     , CS.[Model0]                       AS 'Modelo'
     , CS.[Name0]                        AS 'HostName'
     , CS.[Domain0]                      AS 'Dominio'
     , CS.[UserName0]                    AS 'UserName'
     , CASE
         WHEN (RS.Is_Virtual_Machine0 = '1') THEN 'Virtual'
         WHEN (RS.Is_Virtual_Machine0 = '0') THEN 'Physical'
        ELSE '_NI'
       END                               AS 'MachineType'

     , CASE
         WHEN SY.ChassisTypes0 IN ('3','4','6','15','16') THEN 'Desktop'
         WHEN SY.ChassisTypes0 IN ('7','17','23') THEN 'Physical Server'
         WHEN SY.ChassisTypes0 IN ('8','9','10') THEN 'Notebook'
         WHEN (SY.ChassisTypes0 = '1') AND (RS.Is_Virtual_Machine0 = '1')THEN 'Virtual Machine'
        ELSE 'Others'
       END                               AS 'Chassi' 
     , RS.Operating_System_Name_and0     AS 'OS'
     , OS.[CSDVersion0]                  AS 'OSPKVersao'
     , OS.[Version0]                     AS 'OSVersao'
     , OS.[SerialNumber0]                AS 'NSerie'
     , ME.[TotalPhysicalMemory0] / 1024  AS 'TotalPhysicalMemory'
     , CP.Manufacturer0                  AS 'CPUFabricante'
     , CP.NameCPU                        AS 'CPUModelo'
     , CP.Sockets                        AS 'CPUSockets'
     , CP.CoresPerSocket
     , CASE
         WHEN RS.Active0 = 1 THEN 'Active'
         WHEN RS.Active0 = 0 THEN 'Inactive'                     
       END                                AS 'Status'
     , CASE
         WHEN Client0 = 1 THEN 'Client Installed'
        ELSE 'No Client'
       END                                AS 'ClientSCCM'
  FROM [dbo].[v_R_System] AS RS
  LEFT JOIN [dbo].[v_GS_COMPUTER_SYSTEM]  AS CS ON RS.[ResourceID] = CS.[ResourceID]
  LEFT JOIN [dbo].[v_GS_OPERATING_SYSTEM] AS OS ON OS.[ResourceID] = CS.[ResourceID]
  LEFT JOIN [dbo].[v_GS_X86_PC_MEMORY]    AS ME ON RS.[ResourceID] = ME.[ResourceID]
  LEFT JOIN [dbo].[v_GS_SYSTEM_ENCLOSURE] AS SY ON RS.[ResourceID] = SY.[ResourceID]
  LEFT JOIN (SELECT DISTINCT 
				    CPU.[ResourceID]
				  , (CPU.SystemName0) AS [Hostname]
				  , CPU.Manufacturer0
				  , CPU.Name0 AS NameCPU
				  , COUNT(distinct CPU.SocketDesignation0) AS [Sockets]
				  , SUM(CPU.NumberOfCores0) AS [CoresPerSocket]
				FROM 
				[dbo].[v_GS_PROCESSOR] CPU
				INNER JOIN  v_GS_COMPUTER_SYSTEM CSYS on CPU.ResourceID = CSYS.ResourceID
				GROUP BY
					CPU.[ResourceID]
					,CPU.SystemName0
					,CPU.Manufacturer0
					,CPU.Name0
					,CPU.NumberOfCores0)   AS CP ON RS.[ResourceID] = CP.[ResourceID]
WHERE RS.Client0 IS NOT NULL 
  AND CS.[Name0] IS NOT NULL 
```

#### Valores retoranado pela query.

| Campos retornado        | Descrição                                                              |
|-------------------------|------------------------------------------------------------------------|
| ResourceID              | Id do objeto.  |
| Fabricante              | Fabricante do objeto. |
| Modelo                  | Modelo do objeto.   |
| HostName                | Nome do objeto. |
| Dominio                 | Domínio do AD que o objeto está vinculado. |
| UserName                | Usuário do objeto. |
| MachineType             | Retorna se o objeto é Virtual ou físico. |
| Chassi                  | Retorna o tipo do objeto. |
| OS                      | Sistema operacional instalado no objeto. |
| OSPKVersao              | Especifica qual service pack está instalado no objeto. |
| OSVersao                | Número da versão instada no objeto. |
| NSerie                  | Número de série do objeto. |
| TotalPhysicalMemory     | Total de mémoria RAM instalada no objeto. |
| CPUFabricante           | Fabricante do CPU instalado no objeto. |
| CPUModelo               | Modelo do CPU do objeto. |
| CPUSockets              | Número de sockets do objeto. |
| CoresPerSocket	  | Número de cores virtuais. |
| Status 		  | O status do objeto, se está ativo ou desativado. |
| ClientSCCM 		  | Se o cliente do SCCM está instalado no objeto. |


#### Explicação da "query" consulta:

Para iniciar a consulta utilizaremos a "view" "v_R_System" como tabela principal dentro do " FROM [dbo].[v_R_System] AS RS " nestá tabela estão todos os objetos cadastrado no SCCM, ativo ou inativos. Para está tabela vamos usar um "select case" no campo "Is_Virtual_Machine0" para identificar se o objeto é uma maquina virtual ou física. O campo "RS.[ResourceID]" será utilizado como cháve estrangeira para as outras tabelas.
```
FROM [dbo].[v_R_System] AS RS       

  CASE
    WHEN (RS.Is_Virtual_Machine0 = '1') THEN 'Virtual'
    WHEN (RS.Is_Virtual_Machine0 = '0') THEN 'Physical'
   ELSE '_NI'
  END  AS 'MachineType'  
```






