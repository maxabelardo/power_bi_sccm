# Vamos lista todas as "VIEW" visões necessária para alcançar os objetivos do projeto.

* Listar todos os servidores é estações de trabalho.
	* Query que retorna os servidores é estações de trabalho.
	* Query que identifica o tipo de objeto  	
* Proporção por sistema operacional
	* Query que retorna os sistema operacional do ambiente SCCM. 
* Volume dos discos "hd".
	* Query que retorna os hd instalados nos servidore e estações de trabalho.     


## Listar todos os servidores é estações de trabalho.

### Query que retorna os servidores é estações de trabalho.
#### v_GS_COMPUTER_SYSTEM
Lista informações sobre os clientes do Configuration Manager, incluindo domínio, nome do computador, funções do Configuration Manager, status, tipo de sistema e muito mais. A exibição pode ser unida a outras exibições usando a coluna ResourceID.
```
SELECT [ResourceID]         -- Código ID do objeto.
      ,[GroupID]            -- Código ID do grupo.
      ,[Manufacturer0]      -- Marca do objeto.
      ,[Model0]             -- Modelo do objeto.
      ,[Name0]              -- Nome do objeto.
      ,[Description0]       -- Descrição 
      ,[Domain0]            -- Domínio da infraestrutura.
      ,[DomainRole0]        -- Código do ID da regra de segurança.
      ,[UserName0]          -- Último usuário conectado no objeto.
      ,[SystemType0]        -- Tipo do sistema "OS" 64 ou 32 bits.
      ,[RevisionID]         -- ***************
      ,[AgentID]            -- ***************
      ,[TimeStamp]          -- ***************
  FROM [dbo].[v_GS_COMPUTER_SYSTEM]
```


### Query que identifica o tipo de objeto.
#### v_GS_SYSTEM_ENCLOSURE
Lista informações sobre o gabinete do sistema encontrado nos clientes do Configuration Manager, incluindo tipos de chassi, número de série, etiqueta de ativo SMBIOS e assim por diante. A exibição pode ser unida a outras exibições usando a coluna ResourceID.

```
SELECT a.resourceid,         -------------------------------------------- Código ID do objeto.
       a.revisionid,         -------------------------------------------- ***************
       a.chassistypes0,      -------------------------------------------- Número que representa o tipo do objeto.
       CASE                  -------------------------------------------- Tradução do campo "chassistypes0" para descrição do objeto. 
          WHEN a.ChassisTypes0 = 1 THEN 'Other'
          WHEN a.ChassisTypes0 = 2 THEN 'Unknown'
          WHEN a.ChassisTypes0 = 3 THEN 'Desktop'
          WHEN a.ChassisTypes0 = 4 THEN 'Low Profile Desktop'
          WHEN a.ChassisTypes0 = 5 THEN 'Pizza Box'
          WHEN a.ChassisTypes0 = 6 THEN 'Mini Tower'
          WHEN a.ChassisTypes0 = 7 THEN 'Tower'
          WHEN a.ChassisTypes0 = 8 THEN 'Portable'
          WHEN a.ChassisTypes0 = 9 THEN 'Laptop'
          WHEN a.ChassisTypes0 = 10 THEN 'Notebook'
          WHEN a.ChassisTypes0 = 11 THEN 'Hand Held'
          WHEN a.ChassisTypes0 = 12 THEN 'Docking Station'
          WHEN a.ChassisTypes0 = 13 THEN 'All in One'
          WHEN a.ChassisTypes0 = 14 THEN 'Sub Notebook'
          WHEN a.ChassisTypes0 = 15 THEN 'Space-Saving'
          WHEN a.ChassisTypes0 = 16 THEN 'Lunch-Box'
          WHEN a.ChassisTypes0 = 17 THEN 'Main System Chassis'
          WHEN a.ChassisTypes0 = 18 THEN 'Expansion Chassis'
          WHEN a.ChassisTypes0 = 19 THEN 'Sub Chassis'
          WHEN a.ChassisTypes0 = 20 THEN 'Bus Expansion Chassis'
          WHEN a.ChassisTypes0 = 21 THEN 'Peripheral Chassis'
          WHEN a.ChassisTypes0 = 22 THEN 'Storage Chassis'
          WHEN a.ChassisTypes0 = 23 THEN 'Rack Mount Chassis'
          WHEN a.ChassisTypes0 = 24 THEN 'Sealed-Case PC'
          WHEN a.ChassisTypes0 = 30 THEN 'Tablet'
          WHEN a.ChassisTypes0 = 31 THEN 'Convertible'
          WHEN a.ChassisTypes0 = 32 THEN 'Detachable'
          WHEN a.ChassisTypes0 = 35 THEN 'Desktop'
          WHEN a.ChassisTypes0 = 36 THEN 'Desktop'
        ELSE NULL
       END AS 'ChassisType', 
       a.serialnumber0,      -------------------------------------------- Número de serie do objeto.
       a.smbiosassettag0,    -------------------------------------------- Número de serie do objeto.
       a.groupid,            -------------------------------------------- Código ID do grupo.
       a.timestamp           -- ***************
FROM   v_gs_system_enclosure a
       INNER JOIN (SELECT resourceid,
                          Max(timestamp) rev
                   FROM   v_gs_system_enclosure
                   GROUP  BY resourceid) b
               ON a.resourceid = b.resourceid
                  AND a.timestamp = b.rev
WHERE  groupid = 1 
  
```
_Se repetem foi feito uma subconsulta para seleciona o último data do registro._

Os valores possíveis de ChassisTypes são fornecidos na tabela no comando "CASE".
Assim, os seguintes tipos de chassis são típicos para:
* Desktop e notebooks: 8, 9, 10, 11, 12, 14, 18, 21, 30, 31, 32
* áreas de trabalho: 3, 4, 5, 6, 7, 15, 16
* servidores: 17,23


## Sistemas Operacionais.

### Query que retorna os sistema operacional do ambiente SCCM.
#### v_R_System
Lista todos os recursos do sistema descobertos por ID de recurso, tipo de recurso, se o recurso é um cliente, que tipo de cliente, versão do cliente, nome NetBIOS, nome de usuário, sistema operacional, identificador exclusivo e muito mais. A exibição pode ser associada a outras exibições usando as colunas ResourceID , ResourceType , Netbios_Name0 e SMS_Unique_Identifier0 .
```
SELECT 
    SYS.ResourceID,
    SYS.Name0 as 'Hostname',
    SYS.AD_Site_Name0 as 'ADSite',
    SYS.User_Name0 as 'Username',
    'MachineType' = CASE
        WHEN (SYS.Is_Virtual_Machine0 = '1') THEN 'Virtual'
        WHEN (SYS.Is_Virtual_Machine0 = '0') THEN 'Physical'
        ELSE '_NI'
        END,
    SYS.Operating_System_Name_and0 as 'OS',
    'Client Status' = CASE
                WHEN SYS.Active0 = 1 THEN 'Active'
                ELSE 'Inactive'
            END
    ,SYS.operatingSystem0
    ,SYS.operatingSystemVersion0	    
FROM v_R_System SYS
WHERE SYS.Client0 is null
```

## Volume dos discos "hd"
### Query que retorna os hd instalados nos servidore e estações de trabalho.

#### v_GS_DISK
Lista informações sobre as unidades de disco encontradas nos clientes do Configuration Manager. A exibição pode ser unida a outras exibições usando a coluna ResourceID .
```
SELECT DISTINCT 
       A.[ResourceID]				-------------------------------------------- Código ID do objeto.      
      ,[GroupID]				-------------------------------------------- Código ID do grupo.
      ,[RevisionID]				-------------------------------------------- ***************
      ,[AgentID]				-------------------------------------------- ***************
      ,A.[TimeStamp]				-------------------------------------------- Data e hora da criação da informação.
      ,[Caption0]				-------------------------------------------- Nome do driver do disco.
      ,[Description0]				-------------------------------------------- Descrição.
      ,[DeviceID0]				-------------------------------------------- ************
      ,A.[Index0]				-------------------------------------------- Ordernação dos disco.
      ,[InterfaceType0]				-------------------------------------------- Tipo de disco, IDE, SCSI ou USB.
      ,[Manufacturer0]				-------------------------------------------- ***************
      ,[MediaType0]				-------------------------------------------- ***************
      ,[Model0]					-------------------------------------------- ***************
      ,[Name0]					-------------------------------------------- ***************
      ,[Partitions0]				-------------------------------------------- ***************
      ,[PNPDeviceID0]				-------------------------------------------- ***************
      ,[SCSIBus0]				-------------------------------------------- ***************
      ,[SCSILogicalUnit0]			-------------------------------------------- ***************
      ,[SCSIPort0]				-------------------------------------------- ***************
      ,[SCSITargetId0]				-------------------------------------------- ***************
      ,[Size0]					-------------------------------------------- Tamanho do disco em MB.
      ,[SystemName0]				-------------------------------------------- ***************
  FROM [dbo].[v_GS_DISK] AS A
  INNER JOIN (SELECT [ResourceID],[Index0], MAX([TimeStamp]) AS 'TimeStamp'
				FROM [dbo].[v_GS_DISK]
				GROUP BY [ResourceID],[Index0] ) AS B ON B.ResourceID = A.ResourceID AND B.TimeStamp = A.TimeStamp 
ORDER BY A.[ResourceID], A.[Index0]
```



## Referências
* [jbolduan/Devices - Win 10 Servicing.sql/](https://gist.github.com/jbolduan/292687ec88257507e4ee0184b2a118fa)
* [Win32_SystemEnclosure class](https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-systemenclosure)
* [Consulta SCCM e WMI para encontrar todos os laptops e desktops](http://woshub.com/sccm-and-wmi-query-to-find-all-laptops-and-desktops/)
* [SCCM collection to list all the Laptop computers](https://eskonr.com/2010/11/sccm-collection-to-list-all-the-laptop-computers-2/)
* [Visualizações de descoberta no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/discovery-views-configuration-manager)
* [Visualizações de inventário de hardware no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/hardware-inventory-views-configuration-manager)
