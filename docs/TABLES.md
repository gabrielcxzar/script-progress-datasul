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
