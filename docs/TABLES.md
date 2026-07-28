# TABLES.md — Catálogo de Tabelas TOTVS Datasul

Este catálogo documenta as tabelas identificadas nos scripts do repositório. Informações extraídas diretamente do código são marcadas como **confirmadas**. Detalhes não explícitos nos scripts são marcados como **`(Inferência)`**.

---

## 🔄 Atualização

Este documento DEVE ser atualizado sempre que novos scripts forem adicionados e novas tabelas ou campos forem identificados.

---

## 📋 Índice de Tabelas

| Tabela | Módulo | Descrição | Fonte |
| :--- | :--- | :--- | :--- |
| [usuar_mestre](#usuar_mestre) | Framework / Segurança | Cadastro mestre de usuários do ERP | 2 scripts |
| [usuar_mestre_aux](#usuar_mestre_aux) | Framework / Segurança | Status e flags do usuário | 2 scripts |
| [segur_empres_usuar](#segur_empres_usuar) | Framework / Segurança | Vínculo usuário ↔ empresa (permissão) | 1 script |
| [usuar_grp_usuar](#usuar_grp_usuar) | Framework / Segurança | Vínculo grupo ↔ usuário ✅ | 1 script |
| [grp_usuar](#grp_usuar) | Framework / Segurança | Definição dos Grupos de Usuários (código + descrição) ✅ | API-001 |
| [distrib-emit-estab](#distrib-emit-estab) | Vendas / Distribuição | Configuração Distribuidor-Emitente-Estabelecimento ✅ | API-002 |
| [item](#item) | Manufatura / Estoque | Cadastro Mestre de Itens e Produtos ✅ | Específicos |
| [ord-prod](#ord-prod) | Produção / PCP | Ordens de Produção ✅ | Específicos |
| [emitente](#emitente) | Cadastros Globais | Cadastro de Clientes, Fornecedores e Transportadores ✅ | Específicos |
| [estabelec](#estabelec) | Cadastros Globais | Cadastro de Estabelecimentos e Filiais ✅ | Específicos |
| [saldo-estoq](#saldo-estoq) | Estoque / Materiais | Saldos de Estoque por Item, Depósito, Localização e Lote ✅ | Específicos |
| [ped-venda](#ped-venda) | Vendas / Faturamento | Cabeçalho dos Pedidos de Venda ✅ | Específicos |
| [ped-item](#ped-item) | Vendas / Faturamento | Itens dos Pedidos de Venda ✅ | Específicos |
| [nota-fiscal](#nota-fiscal) | Fiscal / Faturamento | Cabeçalho das Notas Fiscais ✅ | Específicos |
| [movto-estoq](#movto-estoq) | Estoque / Materiais | Movimentação Geral de Estoque ✅ | Específicos |
| [movto-mat](#movto-mat) | Produção / Estoque | Movimentação de Materiais na Produção ✅ | Específicos |
| [deposito](#deposito) | Estoque / Materiais | Cadastro de Depósitos ✅ | Específicos |
| [aut_op_param_processo](#aut_op_param_processo) | Automação / Ficha Prod. | Parâmetros de Processo por Ordem de Produção ✅ | Específicos |
| [aut_ficha_prod](#aut_ficha_prod) | Automação / Ficha Prod. | Cabeçalho da Ficha de Produção ✅ | Específicos |
| [aut_mapa_ensac](#aut_mapa_ensac) | Automação / Ficha Prod. | Mapa de Ensacamento de Produção ✅ | Específicos |
| [grup-estoque](#grup-estoque) | Estoque / Cadastros | Cadastro de Grupo de Estoque (`mgemp`) ✅ | `upc-cd0201.p` |

---

## <a name="usuar_mestre"></a>🗃️ usuar_mestre

### Descrição
Tabela mestre de cadastro de usuários do ERP TOTVS Datasul. Armazena os dados fundamentais de identificação e contato do usuário do sistema.

### Módulo
Framework / Segurança do Datasul (`emsfnd`) — `(Inferência)`

### Campos Identificados nos Scripts

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `cod_usuario` | Character | Código / Login do usuário no sistema (Chave de busca) |
| `nom_usuario` | Character | Nome completo do usuário |
| `cod_e_mail_local` | Character | Endereço de e-mail corporativo/local |
| `cod_e_mail_celular` | Character | Endereço de e-mail associado ao celular corporativo |

### Índices
- **Principal**: Provavelmente indexado por `cod_usuario` — `(Inferência — deduzido pelo padrão de busca com FIRST WHERE cod_usuario = ...)`

### Relacionamentos

| Tabela Relacionada | Via Campo | Tipo |
| :--- | :--- | :--- |
| `usuar_mestre_aux` | `cod_usuario` | 1-para-1 (registro mestre ↔ auxiliar) |
| `segur_empres_usuar` | `cod_usuario` | 1-para-N (um usuário em várias empresas) |

### Scripts que Utilizam Esta Tabela

- [scripts/consultas/listar_usuarios_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_ativos_datasul.p)
- [scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p)

---

## <a name="usuar_mestre_aux"></a>🗃️ usuar_mestre_aux

### Descrição
Tabela auxiliar complementar ao cadastro de usuários. Controla o status de ativação/inativação de cada usuário no ERP Datasul através do campo lógico `log_inativ`.

### Módulo
Framework / Segurança do Datasul (`emsfnd`) — `(Inferência)`

### Campos Identificados nos Scripts

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `cod_usuario` | Character | Código / Login do usuário (chave de vínculo com `usuar_mestre`) |
| `log_inativ` | Logical (YES/NO) | Indica se o usuário está INATIVO. `NO` = Usuário Ativo. `YES` = Usuário Inativo. |

### Índices
- **Principal**: Provavelmente indexado por `cod_usuario` — `(Inferência)`
- **Secundário**: Possível índice em `log_inativ` para facilitar filtros de status — `(Inferência)`

### Relacionamentos

| Tabela Relacionada | Via Campo | Tipo |
| :--- | :--- | :--- |
| `usuar_mestre` | `cod_usuario` | 1-para-1 |

### Scripts que Utilizam Esta Tabela

- [scripts/consultas/listar_usuarios_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_ativos_datasul.p) — **Ponto de entrada da consulta** (`FOR EACH usuar_mestre_aux WHERE log_inativ = NO`)
- [scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p) — Utilizada como filtro confirmatório de status após join por empresa

---

## <a name="segur_empres_usuar"></a>🗃️ segur_empres_usuar

### Descrição
Tabela de segurança que vincula usuários a empresas no contexto multi-empresa do ERP Datasul. Determina quais empresas cada usuário tem permissão para acessar.

### Módulo
Framework / Segurança do Datasul (`emsfnd`) — `(Inferência)`

### Campos Identificados nos Scripts

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `cod_empresa` | Character | Código da empresa no ERP (ex: "2", "5", "6") |
| `cod_usuario` | Character | Código / Login do usuário vinculado à empresa |

### Índices
- **Principal**: Provavelmente índice composto em `(cod_empresa, cod_usuario)` — `(Inferência — deduzido pelo padrão de filtragem e ordenação no script)`

### Relacionamentos

| Tabela Relacionada | Via Campo | Tipo |
| :--- | :--- | :--- |
| `usuar_mestre` | `cod_usuario` | N-para-1 (vários registros de empresa por usuário) |

### Scripts que Utilizam Esta Tabela

- [scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p) — **Ponto de entrada** da consulta filtrada por empresa
- [scripts/consultas/listar_usuarios_ativos_empresa_5.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_ativos_empresa_5.p) — Consulta específica para empresa 5

---

## <a name="usuar_grp_usuar"></a>🗃️ usuar_grp_usuar ✅

### Descrição
Tabela de vínculo entre Grupos de Usuários e os respectivos logins cadastrados em cada grupo. Permite consultar dinamicamente todos os membros de um grupo sem hardcodar a lista de logins.

> **Nome e campos 100% confirmados** via diagnósticos `_file` e `_field` no banco Progress.

### Módulo
Framework / Segurança do Datasul (`emsfnd`) — `(Inferência)`

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `cod_grp_usuar` | Character | Código do grupo de usuários (ex: `"MSP"`) ✅ |
| `cod_usuario` | Character | Login do usuário membro do grupo ✅ |
| `cod_livre_1` | Character | Campo livre 1 (uso customizado) |
| `cod_livre_2` | Character | Campo livre 2 (uso customizado) |
| `dat_livre_1` | Date | Data livre 1 (uso customizado) |
| `dat_livre_2` | Date | Data livre 2 (uso customizado) |
| `des_checksum` | Character | Checksum de integridade do registro (framework) |
| `fwk_created_at` | Datetime | Data/hora de criação do registro (framework) |
| `fwk_updated_at` | Datetime | Data/hora de última atualização (framework) |
| `log_livre_1` | Logical | Flag livre 1 (uso customizado) |
| `log_livre_2` | Logical | Flag livre 2 (uso customizado) |
| `num_livre_1` | Integer | Número livre 1 (uso customizado) |
| `num_livre_2` | Integer | Número livre 2 (uso customizado) |
| `val_livre_1` | Decimal | Valor livre 1 (uso customizado) |
| `val_livre_2` | Decimal | Valor livre 2 (uso customizado) |

### Índices
- **Principal**: Provavelmente composto em `(cod_grp_usuar, cod_usuario)` — `(Inferência)`

### Relacionamentos

| Tabela Relacionada | Via Campo | Tipo |
| :--- | :--- | :--- |
| `usuar_mestre` | `cod_usuario` | N-para-1 |
| `usuar_mestre_aux` | `cod_usuario` | N-para-1 |
| `segur_empres_usuar` | `cod_usuario` | N-para-N (via joins) |

### Scripts que Utilizam Esta Tabela

- [scripts/consultas/grupo_msp_ativos_empresa_5.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/grupo_msp_ativos_empresa_5.p) — Consulta grupo MSP ativo na empresa 5

### Observações
- Os campos `cod_livre_*`, `dat_livre_*`, `log_livre_*`, `num_livre_*`, `val_livre_*` são campos genéricos reservados pelo framework Datasul para extensão customizada. Não possuem uso fixo definido.
- Os campos `fwk_created_at` e `fwk_updated_at` são padrão do framework de auditoria do DataSul (presentes em todas as tabelas modernas do sistema).

---

## <a name="grp_usuar"></a>🗃️ grp_usuar ✅

### Descrição
Tabela de definição dos Grupos de Usuários no DataSul. Armazena o código e a descrição de cada grupo. **Diferente de `usuar_grp_usuar`** — esta é o cadastro do grupo em si; aquela armazena os membros do grupo.

> **Nome e campos confirmados** via leitura direta do fonte `api_grp_usuar.p`.

### Módulo
Framework / Segurança do Datasul (`emsfnd`) — `(Inferência)`

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `cod_grp_usuar` | Character | Código do grupo de usuários (ex: `"MSP"`) ✅ |
| `des_grp_usuar` | Character | Descrição do grupo (ex: `"Email Solicitação Serviço PDO"`) ✅ |

### Relacionamentos

| Tabela Relacionada | Via Campo | Tipo |
| :--- | :--- | :--- |
| `usuar_grp_usuar` | `cod_grp_usuar` | 1-para-N (um grupo tem vários membros) |

### APIs que Utilizam Esta Tabela

- [API-001: api_grp_usuar.p](file:///C:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/API%20-%20PO-UI/bas_grp_usuar/api_grp_usuar.p) — Retorna lista de grupos via GET `/api/v1/api_grp_usuar`

### Observações
- **Não confundir** `grp_usuar` (definição do grupo) com `usuar_grp_usuar` (vínculo grupo-usuário).
- A query desta tabela **não** filtra por empresa ou status — retorna todos os grupos cadastrados.

---

## <a name="distrib-emit-estab"></a>🗃️ distrib-emit-estab ✅

### Descrição
Tabela de configuração da relação Distribuidor ↔ Emitente ↔ Estabelecimento no módulo de Vendas/Distribuição do DataSul. Define parâmetros comerciais como canal de venda, condição de pagamento, tabela de preços e natureza de operação para cada combinação estabelecimento-emitente.

> **Nome e campos confirmados** via leitura direta do fonte `api_distrib_emit_estab.p`.
> **Observação de nomenclatura**: Esta tabela usa hífen (`-`) no nome e nos campos, padrão do módulo de vendas do Datasul (módulos mais antigos). Diferente das tabelas de segurança/framework que usam underscore (`_`).

### Módulo
Vendas / Distribuição — `(Inferência)`

### Campos Confirmados

| Campo (banco com `-`) | Tipo | Descrição |
| :--- | :--- | :--- |
| `cod-estabel` | Character | Código do estabelecimento ✅ |
| `cod-emitente` | Integer | Código do emitente/distribuidor ✅ |
| `cod-canal-venda` | Integer | Canal de venda ✅ |
| `cod-cond-pag` | Integer | Código da condição de pagamento ✅ |
| `cod-entrega` | Character | Código de entrega (ex: `"CIF"`, `"FOB"`) ✅ |
| `cod-rep` | Integer | Código do representante ✅ |
| `nat-operacao` | Character | Natureza de operação interna (ex: `"5101"`) ✅ |
| `nat-oper-ext` | Character | Natureza de operação externa ✅ |
| `nome-abrev` | Character | Nome abreviado do emitente/distribuidor ✅ |
| `nr-tabpre` | Character | Número da tabela de preços ✅ |
| `val-perc-desc-clien` | Decimal | Percentual de desconto para cliente ✅ |

### Índices
- **Ordenação confirmada**: `BY cod-estabel, BY cod-emitente`

### APIs que Utilizam Esta Tabela

- [API-002: api_distrib_emit_estab.p](file:///C:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/API%20-%20PO-UI/distrib_emit_estab/api_distrib_emit_estab.p) — Retorna configurações via GET `/api/v1/api_distrib_emit_estab`

### Observações
- Campos com hífen no banco são mapeados para underscore na TEMP-TABLE da API e para kebab-case no JSON de resposta.
- Esta tabela não possui filtros na API atual — retorna todos os registros ordenados por estabelecimento e emitente.

---

## <a name="item"></a>🗃️ item ✅

### Descrição
Tabela mestre de cadastro de Itens, Produtos, Matérias-Primas e Embalagens do ERP TOTVS Datasul. Centraliza parâmetros fiscais, de estoque, compras e controle de qualidade de cada item.

> **Nome e campos confirmados** via programas específicos (`cdp`, `esp`, `Automacao`).

### Módulo
Manufatura / Estoque / Engenharia (`cdp`)

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `it-codigo` | Character | Código único do item (Chave primária) ✅ |
| `descricao` | Character | Descrição completa do item ✅ |
| `desc-item` | Character | Descrição estendida/resumida do item ✅ |
| `un` | Character | Unidade de medida principal (ex: `"KG"`, `"UN"`, `"TON"`) ✅ |
| `grup-estoque` | Integer | Código do grupo de estoque do item ✅ |
| `fm-codigo` | Character | Código da família do item ✅ |
| `cod-estabel` | Character | Estabelecimento padrão do item ✅ |
| `cod-obsoleto` | Integer | Indicador de obsolescência (`1` = Ativo, `2` = Obsoleto Total, `3` = Obsoleto Ordens) ✅ |
| `compr-fabric` | Integer | Indicador Comprado/Fabricado (`1` = Comprado, `2` = Fabricado) ✅ |
| `class-fiscal` | Character | Classificação Fiscal / NCM ✅ |
| `cd-trib-icm` | Integer | Código de tributação de ICMS ✅ |
| `cd-trib-ipi` | Integer | Código de tributação de IPI ✅ |
| `aliquota-ipi` | Decimal | Alíquota de IPI (%) ✅ |
| `aliquota-iss` | Decimal | Alíquota de ISS (%) ✅ |
| `contr-qualid` | Logical | Requer controle de qualidade / CQ (`YES`/`NO`) ✅ |

---

## <a name="grup-estoque"></a>🗃️ grup-estoque ✅

### Descrição
Tabela de cadastro mestre de Grupos de Estoque do ERP TOTVS Datasul. Armazena o código do grupo, descrição e campos genéricos de extensão customizada.

> **Banco**: `mgemp`  
> **Programa Padrão Associado**: `CD0201`  
> **UPC Associada**: [upc/upc-cd0201.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/upc/upc-cd0201.p)

### Módulo
Estoque / Cadastros de Materiais (`cdp`)

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `cod-grupo` | Integer | Código único do Grupo de Estoque (Chave Primária) ✅ |
| `descricao` | Character | Descrição do Grupo de Estoque ✅ |
| `char-2` | Character | Campo genérico/livre livre uso. Posição 80 utilizada para armazenar o `EMG Code` (1 caractere) ✅ |

### UPCs / Scripts que Utilizam Esta Tabela
- [upc/upc-cd0201.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/upc/upc-cd0201.p) — Customização da tela do programa `CD0201` com `EMG Code` na posição 80 do `char-2`.

---

## <a name="ord-prod"></a>🗃️ ord-prod ✅

### Descrição
Tabela principal de Ordens de Produção (OPs) do ERP Datasul. Armazena o ciclo de vida, quantidade, datas de planejamento/início/término e status de cada ordem emitida.

> **Nome e campos confirmados** via programas específicos (`cpp`, `bcp`, `esp`, `Automacao`).

### Módulo
Controle da Produção / PCP (`cpp`, `bcp`)

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `nr-ord-produ` / `nr-ord-prod` | Integer | Número sequencial da Ordem de Produção (Chave) ✅ |
| `it-codigo` | Character | Código do item a ser produzido ✅ |
| `cod-estabel` | Character | Estabelecimento emissor da OP ✅ |
| `cod-depos` | Character | Depósito de entrada do produto acabado ✅ |
| `qt-planejada` | Decimal | Quantidade planejada da ordem ✅ |
| `qt-produzida` | Decimal | Quantidade já apontada/produzida ✅ |
| `estado` | Integer | Estado da Ordem (`1` = Não Planejada, `2` = Planejada, `3` = Liberada, `4` = Iniciada, `5` = Finalizada, `6` = Terminada) ✅ |
| `dt-emissao` | Date | Data de emissão da OP ✅ |
| `dt-inicio` | Date | Data de início planejado ✅ |
| `dt-termino` | Date | Data de término planejado ✅ |
| `nr-linha` | Integer | Número da linha de produção associada ✅ |
| `lote-serie` | Character | Número do Lote ou Série gerado pela OP ✅ |

---

## <a name="emitente"></a>🗃️ emitente ✅

### Descrição
Cadastro unificado de Entidades Externas (Clientes, Fornecedores, Transportadores, Representantes e Parceiros EDI) do ERP Datasul.

> **Nome e campos confirmados** via programas específicos (`cdp`, `ped`, `ft`).

### Módulo
Cadastros Globais / Financeiro / Vendas (`cdp`)

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `cod-emitente` | Integer | Código único do emitente (Chave primária) ✅ |
| `nome-emit` / `nome-abrev` | Character | Nome fantasia / Razão social do emitente ✅ |
| `cgc` | Character | CNPJ ou CPF do emitente ✅ |
| `ins-estadual` | Character | Inscrição Estadual ✅ |
| `cidade` | Character | Cidade do endereço principal ✅ |
| `estado` | Character | UF / Estado (ex: `"SP"`, `"RJ"`) ✅ |
| `cep` | Character | Código de Endereçamento Postal ✅ |
| `cod-gr-cli` | Integer | Grupo de clientes associado ✅ |
| `cod-gr-forn` | Integer | Grupo de fornecedores associado ✅ |
| `cod-cond-pag` | Integer | Condição de pagamento padrão ✅ |

---

## <a name="estabelec"></a>🗃️ estabelec ✅

### Descrição
Tabela de cadastro de Estabelecimentos (Filiais, Usinas, Unidades de Negócio) da empresa no Datasul.

> **Nome e campos confirmados** via programas específicos (`cdp`, `esp`).

### Módulo
Cadastros Globais (`cdp`)

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `cod-estabel` | Character | Código do estabelecimento (ex: `"101"`, `"001"`) ✅ |
| `nome` | Character | Razão Social / Nome do estabelecimento ✅ |
| `cgc` | Character | CNPJ do estabelecimento ✅ |
| `ins-estadual` | Character | Inscrição Estadual do estabelecimento ✅ |
| `cidade` | Character | Cidade onde se localiza o estabelecimento ✅ |
| `estado` | Character | UF do estabelecimento ✅ |
| `ep-codigo` | Character | Código da Empresa a que pertence o estabelecimento ✅ |

---

## <a name="saldo-estoq"></a>🗃️ saldo-estoq ✅

### Descrição
Tabela de saldos físicos e alocações de estoque por Item, Estabelecimento, Depósito, Localização e Lote.

> **Nome e campos confirmados** via programas específicos (`ce`, `esp`, `Automacao`).

### Módulo
Estoque / Materiais (`ce`)

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `it-codigo` | Character | Código do item ✅ |
| `cod-estabel` | Character | Código do estabelecimento ✅ |
| `cod-depos` | Character | Código do depósito ✅ |
| `cod-localiz` | Character | Código da localização física no depósito ✅ |
| `lote` | Character | Código do lote do material ✅ |
| `qtidade-atu` | Decimal | Quantidade atual física em estoque ✅ |
| `qt-alocada` | Decimal | Quantidade alocada para ordens/pedidos ✅ |
| `dt-vali-lote` | Date | Data de validade do lote ✅ |

---

## <a name="ped-venda"></a>🗃️ ped-venda ✅

### Descrição
Cabeçalho do Pedido de Venda no ERP Datasul. Contém dados do cliente, canal de venda, condição de pagamento, transporte e status do pedido.

> **Nome e campos confirmados** via programas específicos (`pd`, `esp`).

### Módulo
Vendas e Faturamento (`pd`)

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `nr-pedido` | Integer | Número do pedido de venda (Chave) ✅ |
| `nome-abrev` | Character | Nome abreviado do cliente/emitente ✅ |
| `cod-emitente` | Integer | Código do cliente (emitente) ✅ |
| `cod-estabel` | Character | Estabelecimento faturador do pedido ✅ |
| `cod-sit-ped` | Integer | Situação do pedido (`1` = Aberto, `2` = Atendido Parcial, `3` = Atendido Total, `4` = Cancelado) ✅ |
| `dt-emissao` | Date | Data de emissão do pedido ✅ |
| `dt-entrega` | Date | Data prevista de entrega ✅ |
| `cod-cond-pag` | Integer | Condição de pagamento do pedido ✅ |
| `cod-canal-venda` | Integer | Canal de venda empregado ✅ |

---

## <a name="ped-item"></a>🗃️ ped-item ✅

### Descrição
Itens do Pedido de Venda. Define os produtos solicitados, quantidades, preços unitários, descontos e datas de entrega de cada linha do pedido.

> **Nome e campos confirmados** via programas específicos (`pd`, `esp`).

### Módulo
Vendas e Faturamento (`pd`)

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `nr-pedido` | Integer | Número do pedido de venda pai ✅ |
| `nr-sequencia` | Integer | Número da sequência/linha do item no pedido ✅ |
| `it-codigo` | Character | Código do item vendido ✅ |
| `qt-pedida` | Decimal | Quantidade solicitada do item ✅ |
| `qt-atendida` | Decimal | Quantidade já faturada/entregue ✅ |
| `vl-preuni` | Decimal | Preço unitário líquido do item ✅ |
| `nat-operacao` | Character | Natureza de operação fiscal do item ✅ |
| `cod-sit-item` | Integer | Situação da linha (`1` = Aberto, `2` = Atendido, `3` = Cancelado) ✅ |

---

## <a name="nota-fiscal"></a>🗃️ nota-fiscal ✅

### Descrição
Cabeçalho das Notas Fiscais emitidas (Saída) e recebidas (Entrada) no faturamento do Datasul.

> **Nome e campos confirmados** via programas específicos (`ft`, `esp`).

### Módulo
Faturamento / Fiscal (`ft`)

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `nr-nota-fis` | Character | Número impresso da Nota Fiscal ✅ |
| `serie` | Character | Série da Nota Fiscal (ex: `"1"`, `"NFE"`) ✅ |
| `cod-estabel` | Character | Estabelecimento emissor da NF ✅ |
| `cod-emitente` | Integer | Cliente/Fornecedor destinatário ✅ |
| `dt-emis-nota` | Date | Data de emissão da Nota Fiscal ✅ |
| `vl-tot-nota` | Decimal | Valor total da Nota Fiscal ✅ |
| `cod-chave-aces-nf-eletro` | Character | Chave de Acesso de 44 dígitos da NF-e ✅ |

---

## <a name="movto-estoq"></a>🗃️ movto-estoq ✅

### Descrição
Tabela histórica de movimentações físicas e financeiras de estoque (Entradas, Saídas, Requisições, Devoluções e Inventário).

> **Nome e campos confirmados** via programas específicos (`ce`, `esp`).

### Módulo
Estoque / Materiais (`ce`)

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `it-codigo` | Character | Código do item movimentado ✅ |
| `cod-estabel` | Character | Estabelecimento da movimentação ✅ |
| `cod-depos` | Character | Depósito de origem/destino ✅ |
| `cod-localiz` | Character | Localização física no depósito ✅ |
| `lote` | Character | Lote do material movimentado ✅ |
| `dt-trans` | Date | Data da transação de estoque ✅ |
| `quantidade` | Decimal | Quantidade movimentada ✅ |
| `esp-doc` / `esp-docto` | Character | Espécie de documento (ex: `"REQ"`, `"DEV"`, `"NFE"`, `"NF"`) ✅ |

---

## <a name="movto-mat"></a>🗃️ movto-mat ✅

### Descrição
Movimentação de consumo e reporte de materiais associados às Ordens de Produção no chão de fábrica.

> **Nome e campos confirmados** via programas específicos (`cp`, `esp`).

### Módulo
Controle da Produção (`cp`)

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `nr-ord-produ` / `nr-ord-prod` | Integer | Ordem de produção relacionada ✅ |
| `it-codigo` | Character | Item consumido ou reportado ✅ |
| `cod-estabel` | Character | Estabelecimento produtivo ✅ |
| `cod-depos` | Character | Depósito de baixa/entrada ✅ |
| `dt-trans` | Date | Data da movimentação do material ✅ |
| `quantidade` | Decimal | Quantidade de material movimentada ✅ |
| `tipo-trans` | Integer | Tipo de transação (`1` = Consumo de Componente, `2` = Reporte de Acabado) ✅ |

---

## <a name="deposito"></a>🗃️ deposito ✅

### Descrição
Tabela de cadastro dos Depósitos de Armazenamento do ERP Datasul.

> **Nome e campos confirmados** via programas específicos (`cdp`, `ce`).

### Módulo
Estoque / Materiais (`cdp`)

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `cod-depos` | Character | Código identificador do depósito (ex: `"CQ"`, `"ALM"`, `"PA"`) ✅ |
| `nome` | Character | Descrição do depósito ✅ |
| `cons-saldo` | Logical | Considerar no saldo disponível de vendas (`YES`/`NO`) ✅ |
| `ind-dep-cq` | Logical | Depósito exclusivo de Controle de Qualidade (`YES`/`NO`) ✅ |
| `ind-processo` | Logical | Depósito de material em processo de fabricação (`YES`/`NO`) ✅ |

---

## <a name="aut_op_param_processo"></a>🗃️ aut_op_param_processo ✅

### Descrição
Tabela do módulo específico de Automação de Processos de Produção. Vincula parâmetros analíticos e receitas de fabricação a cada Ordem de Produção específica.

> **Nome e campos confirmados** via módulo `Automacao`.

### Módulo
Automação de Produção / Qualidade (`Automacao`)

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `nr-ord-produ` | Integer | Número da Ordem de Produção vinculada ✅ |
| `cod-param-processo` | Character | Código do parâmetro de processo analítico ✅ |
| `val-esperado` | Decimal | Valor esperado/alvo do parâmetro ✅ |
| `val-minimo` | Decimal | Tolerância mínima do parâmetro ✅ |
| `val-maximo` | Decimal | Tolerância máxima do parâmetro ✅ |

---

## <a name="aut_ficha_prod"></a>🗃️ aut_ficha_prod ✅

### Descrição
Cabeçalho das Fichas de Produção e Especificações Técnicas de Qualidade de Produtos do módulo de Automação.

> **Nome e campos confirmados** via módulo `Automacao`.

### Módulo
Automação de Produção / Qualidade (`Automacao`)

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `cod-ficha` | Integer | Código sequencial da Ficha de Produção ✅ |
| `it-codigo` | Character | Código do item de produto associado ✅ |
| `dt-validade-ini` | Date | Início da validade da especificação ✅ |
| `dt-validade-fim` | Date | Fim da validade da especificação ✅ |
| `log-ativo` | Logical | Status da ficha de produção (`YES`/`NO`) ✅ |

---

## <a name="aut_mapa_ensac"></a>🗃️ aut_mapa_ensac ✅

### Descrição
Mapa de Ensacamento e Embalagem Final de produtos acabados da linha de produção do módulo de Automação.

> **Nome e campos confirmados** via módulo `Automacao`.

### Módulo
Automação de Produção / Logística (`Automacao`)

### Campos Confirmados

| Campo | Tipo | Descrição |
| :--- | :--- | :--- |
| `nr-mapa` | Integer | Número do Mapa de Ensacamento ✅ |
| `nr-ord-produ` | Integer | Ordem de Produção origem ✅ |
| `it-codigo` | Character | Código do item ensacado ✅ |
| `qt-ensacada` | Decimal | Quantidade total de sacos/embalagens produzidas ✅ |
| `dt-ensacamento` | Date | Data e hora de execução do ensacamento ✅ |

