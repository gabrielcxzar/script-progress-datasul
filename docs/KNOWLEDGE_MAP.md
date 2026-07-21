# KNOWLEDGE_MAP.md — Mapa Mestre de Conhecimento

Este é o **índice principal** da Base de Conhecimento Progress OpenEdge / TOTVS Datasul. Organize por aqui toda a navegação entre domínios funcionais, documentos, scripts, tabelas e exemplos.

> **Para qualquer agente ou desenvolvedor**: comece aqui para localizar rapidamente o que precisa.

---

## 🗺️ Domínios Funcionais Mapeados

| Domínio | Status | Documentos | Scripts | Tabelas |
| :--- | :--- | :--- | :--- | :--- |
| [🔐 Segurança / Framework](#-segurança--framework) | ✅ Ativo | 5 | 2 | 3 |
| [🏢 Cadastros Globais](#-cadastros-globais) | 🔄 Preparado | — | — | — |
| [💰 Financeiro](#-financeiro) | 🔄 Preparado | — | — | — |
| [📋 Fiscal](#-fiscal) | 🔄 Preparado | — | — | — |
| [🏭 Produção](#-produção) | 🔄 Preparado | — | — | — |
| [📦 Estoque](#-estoque) | 🔄 Preparado | — | — | — |
| [🛒 Compras](#-compras) | 🔄 Preparado | — | — | — |
| [🏪 Vendas / Faturamento](#-vendas--faturamento) | 🔄 Preparado | — | — | — |
| [🔌 APIs e Integrações](#-apis-e-integrações) | 🔄 Preparado | — | — | — |
| [📊 Relatórios](#-relatórios) | 🔄 Preparado | — | — | — |
| [🔍 Consultas Gerais](#-consultas-gerais) | ✅ Ativo | 1 | 2 | 3 |
| [🛠️ Utilitários](#️-utilitários) | 🔄 Preparado | — | — | — |

---

## 🔐 Segurança / Framework

**Descrição**: Módulo central do Framework TOTVS Datasul responsável pela gestão de usuários, permissões de acesso, empresas e segurança do sistema.

### Documentos Relacionados
- [docs/DATABASE.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/DATABASE.md) — Convenções de banco e relacionamentos
- [docs/TABLES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md) — Catálogo completo das tabelas deste módulo
- [docs/QUERIES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/QUERIES.md) — Q-001, Q-002, Q-003
- [docs/APIS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/APIS.md) — Catálogo de APIs PO-UI / THF (API-001, API-002)

### Scripts Relacionados
- [scripts/consultas/listar_usuarios_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_ativos_datasul.p) — Lista geral de usuários ativos
- [scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p) — Lista filtrada por empresa
- [scripts/consultas/grupo_msp_ativos_empresa_5.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/grupo_msp_ativos_empresa_5.p) — Usuários do grupo MSP ativos na empresa 5

### Tabelas
| Tabela | Descrição |
| :--- | :--- |
| `usuar_mestre` | Cadastro mestre de usuários |
| `usuar_mestre_aux` | Status de ativação de usuários |
| `segur_empres_usuar` | Vínculo usuário ↔ empresa |
| `usuar_grp_usuar` | Vínculo grupo ↔ usuário |
| `grp_usuar` | Cadastro/definição de grupos de usuários |
| `distrib-emit-estab` | Configuração Distribuidor ↔ Emitente ↔ Estabelecimento |

### Exemplos
- [docs/EXAMPLES.md — Exemplo 1](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/EXAMPLES.md) — Exportação de usuários ativos por empresa (CSV)
- [docs/EXAMPLES.md — Exemplo 2](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/EXAMPLES.md) — Exportação geral de usuários ativos (CSV)

### Snippets Aplicáveis
- [FOR EACH com JOIN via FIRST](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/SNIPPETS.md) — Padrão de junção das tabelas `usuar_mestre` e `usuar_mestre_aux`
- [FOR EACH com Múltiplos Filtros OR](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/SNIPPETS.md) — Filtragem por múltiplas empresas em `segur_empres_usuar`

### Observações
- Os usuários são controlados por `usuar_mestre_aux.log_inativ`. `NO` = Ativo, `YES` = Inativo.
- O modelo de segurança é multi-empresa: um usuário pode ter acesso a N empresas via `segur_empres_usuar`.

---

## 🏢 Cadastros Globais

**Descrição**: Tabelas de cadastros básicos do Datasul (clientes, fornecedores, produtos, estabelecimentos, etc.).

> 🔄 **Domínio preparado para expansão.** Adicione scripts e tabelas conforme forem incorporados ao repositório.

---

## 💰 Financeiro

**Descrição**: Módulos de Contas a Pagar (APB), Contas a Receber (ACR), Caixa e Bancos (CMG).

> 🔄 **Domínio preparado para expansão.**

---

## 📋 Fiscal

**Descrição**: Módulos de Movimentação Fiscal (MOF), Notas Fiscais (FT), SPED, GIA, etc.

> 🔄 **Domínio preparado para expansão.**

---

## 🏭 Produção

**Descrição**: Módulos de Ordens de Produção, PCP, Apontamentos e Chão de Fábrica.

> 🔄 **Domínio preparado para expansão.**

---

## 📦 Estoque

**Descrição**: Módulos de Gestão de Estoque, Transferências, Inventário, Almoxarifado e WMS.

> 🔄 **Domínio preparado para expansão.**

---

## 🛒 Compras

**Descrição**: Módulos de Solicitação, Cotação, Pedido de Compra e Recebimento de Mercadorias.

> 🔄 **Domínio preparado para expansão.**

---

## 🏪 Vendas / Faturamento

**Descrição**: Módulos de Pedidos de Venda, Faturamento, Expedição e Comissões.

> 🔄 **Domínio preparado para expansão.**

---

## 🔌 APIs e Integrações

**Descrição**: Exemplos de consumo e exposição de APIs REST ABL, Procedures Persistentes, DYNAMIC FUNCTION e integrações externas.

> 🔄 **Domínio preparado para expansão.**

---

## 📊 Relatórios

**Descrição**: Scripts de geração de relatórios gerenciais e operacionais.

> 🔄 **Domínio preparado para expansão.**

---

## 🔍 Consultas Gerais

**Descrição**: Scripts de extração e consulta de dados de múltiplos módulos.

### Scripts
- [scripts/consultas/listar_usuarios_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_ativos_datasul.p)
- [scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p)

### Consultas Catalogadas
- [docs/QUERIES.md — Q-001](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/QUERIES.md)
- [docs/QUERIES.md — Q-002](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/QUERIES.md)

---

## 🛠️ Utilitários

**Descrição**: Ferramentas, scripts auxiliares e rotinas de suporte técnico geral.

> 🔄 **Domínio preparado para expansão.**
