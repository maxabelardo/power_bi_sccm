# Utilizando o Power BI para criar painéis para o System Center Configuration Manager "SCCM".

Vamos definir o objetivo a ser alcançados com os nossos painéis:
 * Quantitativos:
  * Total de sevidores.
  * Total de estações de trabalho.
  * Poporção por sistema operacional.
  * Quantitativo por localide ou escritório.
  * Total de sistemas operacionais.
  * Total de aplicativos instalados nos servidores e estação de trabalho.
  * Quantitativo por tipo de maquina "Fisíca" ou "Virtual".
  * Total de servidores e estação de trabalho com atualização do "SO" pendente.
  * 





Antes de começar a desenvolver os painéis é preciso entender a estrutura de dados do SCCM. Para facilitar a extração dos dados por padrão existe diversas visões "VIEW" configuradas na base de dados do SCCM.

<p>Cada visão começa com uma siglas, para sua classificação:</p>

-------------------------------
| Sigla         | Descrição    |
|---------------|--------------|
| v_R_ ou v_RA  | Visualizações de classe de descoberta|
| v_GS          | Visualizações de classe de inventário de hardware|
| v_HS          | Visualizações de classe de inventário de hardware histórico|
| v_CH          | Saúde do cliente|
|_RES_COL_      | Informações específicas dos membros da coleção|
| v_            | Todos os outros |
-----------------------------------








## Referências 
* [Visualizações de gerenciamento de aplicativos no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/application-management-views-configuration-manager)
* [Visualizações de implantação de cliente no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/client-deployment-views-configuration-manager)
* [Visualizações de status do cliente no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/client-status-views-configuration-manager)
* [Visualizações de coleção no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/collection-views-configuration-manager)
* [Exibições de configurações de conformidade no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/compliance-settings-views-configuration-manager)
* [Visualizações de gerenciamento de conteúdo no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/content-management-views-configuration-manager)
* [Visualizações de descoberta no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/discovery-views-configuration-manager)
* [Visualizações de proteção de endpoint no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/endpoint-protection-views-configuration-manager)
* [Visualizações de inventário de hardware no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/hardware-inventory-views-configuration-manager)
* [Visualizações de inventário de software no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/software-inventory-views-configuration-manager)
* [Visualizações de inteligência de ativos no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/asset-intelligence-views-configuration-manager)
* [Visualizações de migração no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/migration-views-configuration-manager)
* [Visualizações de gerenciamento de dispositivos móveis no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/mobile-device-management-views-configuration-manager)
* [Visualizações de implantação do sistema operacional no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/operating-system-deployment-views-configuration-manager)
* [Visualizações de gerenciamento de energia no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/power-management-views-configuration-manager)
* [Visualizações de esquema no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/schema-views-configuration-manager)
* [Visualizações de segurança no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/security-views-configuration-manager)
* [Visualizações de administração do site no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/site-admin-views-configuration-manager)
* [Visualizações de medição de software no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/software-metering-views-configuration-manager)
* [Exibições de atualizações de software no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/software-updates-views-configuration-manager)
* [Visualizações de status e alerta no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/status-alert-views-configuration-manager)
* [Exibições Wake On LAN no Configuration Manager](https://docs.microsoft.com/en-us/mem/configmgr/develop/core/understand/sqlviews/wake-lan-views-configuration-manager)
