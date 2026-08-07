# KNOWLEDGE_MAP.md — Mapa Mestre de Conhecimento

Este é o **índice principal** da Base de Conhecimento Progress OpenEdge / TOTVS Datasul. Organize por aqui toda a navegação entre domínios funcionais, documentos, scripts, tabelas e exemplos.

> **Para qualquer agente ou desenvolvedor**: comece aqui para localizar rapidamente o que precisa.

---

## 🗺️ Domínios Funcionais Mapeados

| Domínio | Status | Documentos | Scripts / Programas | Tabelas Principais |
| :--- | :--- | :--- | :--- | :--- |
| [🔐 Segurança / Framework](#-segurança--framework) | ✅ Ativo | 5 | 3 | `usuar_mestre`, `usuar_mestre_aux`, `segur_empres_usuar`, `usuar_grp_usuar` |
| [🏢 Cadastros Globais](#-cadastros-globais) | ✅ Ativo | 2 | Específicos (`cdp`) | `item`, `emitente`, `estabelec` |
| [🏭 Produção](#-produção) | ✅ Ativo | 3 | Específicos (`cpp`, `bcp`, `esp`) | `ord-prod`, `movto-mat`, `lin-prod`, `estrutura` |
| [📦 Estoque](#-estoque) | ✅ Ativo | 3 | Específicos (`ce`, `esp`) | `saldo-estoq`, `movto-estoq`, `deposito`, `grup-estoque` |
| [🏪 Vendas / Faturamento](#-vendas--faturamento) | ✅ Ativo | 3 | Específicos (`pd`, `ft`) | `ped-venda`, `ped-item`, `nota-fiscal`, `natur-oper` |
| [🤖 Automação de Processos](#-automação-de-processos) | ✅ Ativo | 2 | Específicos (`Automacao`) | `aut_op_param_processo`, `aut_ficha_prod`, `aut_mapa_ensac` |
| [📧 Envio de E-mails / Notificações](#-envio-de-e-mails--notificações) | ✅ Ativo | 2 | 84 Programas | `utp/ut-mail.p`, `atpmailsock.p`, Triggers, UPCs |
| [🔌 APIs e Integrações](#-apis-e-integrações) | ✅ Ativo | 2 | APIs (`PO-UI`) | `grp_usuar`, `distrib-emit-estab` |
| [🔍 Consultas Gerais](#-consultas-gerais) | ✅ Ativo | 2 | 3 | `usuar_grp_usuar`, `segur_empres_usuar` |

---

## 🔐 Segurança / Framework

**Descrição**: Módulo central do Framework TOTVS Datasul responsável pela gestão de usuários, permissões de acesso, empresas e segurança do sistema.

### Documentos Relacionados
- [docs/DATABASE.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/DATABASE.md) — Convenções de banco e relacionamentos
- [docs/TABLES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md) — Catálogo completo das tabelas deste módulo
- [docs/QUERIES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/QUERIES.md) — Q-001, Q-002, Q-003, M-001, M-002
- [docs/APIS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/APIS.md) — Catálogo de APIs PO-UI / THF (API-001, API-002)

### Scripts Relacionados
- [scripts/consultas/listar_usuarios_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_ativos_datasul.p) — Lista geral de usuários ativos
- [scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p) — Lista filtrada por empresa
- [scripts/consultas/grupo_msp_ativos_empresa_5.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/grupo_msp_ativos_empresa_5.p) — Usuários do grupo MSP ativos na empresa 5
- [scripts/manutenção/reativar_usuario_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/manuten%C3%A7%C3%A3o/reativar_usuario_datasul.p) — Script interativo de reativação de usuário e ajuste de validade
- [scripts/manutenção/inativar_usuarios_lista.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/manuten%C3%A7%C3%A3o/inativar_usuarios_lista.p) — Script batch de inativação em lote (82 usuários) e limpeza de e-mail local



---

## 🏢 Cadastros Globais

**Descrição**: Tabelas de cadastros básicos e parâmetros mestres do ERP Datasul (Clientes, Fornecedores, Itens, Estabelecimentos).

### Tabelas Mapeadas
- [`item`](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md#item) — Cadastro Mestre de Produtos e Materiais
- [`emitente`](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md#emitente) — Cadastro de Clientes, Fornecedores e Transportadores
- [`estabelec`](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md#estabelec) — Cadastro de Filiais e Estabelecimentos

---

## 🏭 Produção

**Descrição**: Módulos de Ordens de Produção, PCP, Escalonamento e Chão de Fábrica (`cpp`, `bcp`, `esp`).

### Consultas & Tabelas
- [`ord-prod`](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md#ord-prod) — Ordens de Produção
- [`movto-mat`](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md#movto-mat) — Movimentação de Materiais na Produção
- [Q-004 — Consultar Ordens de Produção Abertas](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/QUERIES.md#q-004)

---

## 📦 Estoque

**Descrição**: Módulos de Gestão de Estoque, Saldos, Depósitos e Movimentações (`ce`, `esp`).

### Consultas & Tabelas
- [`saldo-estoq`](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md#saldo-estoq) — Saldos por Item, Depósito, Localização e Lote
- [`movto-estoq`](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md#movto-estoq) — Movimentações Históricas de Estoque
- [`deposito`](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md#deposito) — Depósitos de Armazenamento
- [Q-005 — Consultar Saldo Físico e Alocado](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/QUERIES.md#q-005)
- [Q-006 — Histórico de Movimentações por Período](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/QUERIES.md#q-006)

---

## 🏪 Vendas / Faturamento

**Descrição**: Módulos de Pedidos de Venda, Faturamento, Notas Fiscais (`pd`, `ft`, `esp`).

### Consultas & Tabelas
- [`ped-venda`](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md#ped-venda) — Pedidos de Venda
- [`ped-item`](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md#ped-item) — Itens do Pedido de Venda
- [`nota-fiscal`](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md#nota-fiscal) — Notas Fiscais
- [Q-007 — Carteira de Pedidos de Venda Abertos](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/QUERIES.md#q-007)

---

## 🤖 Automação de Processos

**Descrição**: Módulo específico de Automação industrial, Fichas de Produção e Mapas de Ensacamento (`Automacao`).

### Tabelas Mapeadas
- [`aut_op_param_processo`](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md#aut_op_param_processo) — Parâmetros de Processo da OP
- [`aut_ficha_prod`](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md#aut_ficha_prod) — Ficha Técnica de Produção
- [`aut_mapa_ensac`](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md#aut_mapa_ensac) — Mapa de Ensacamento Final


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

## 📧 Envio de E-mails / Notificações

**Descrição**: Catálogo completo dos 84 programas específicos que realizam envios automatizados de e-mail (alertas de qualidade, aprovações, relatórios fiscais, pendências de compras e laudos).

### Documentos & Trechos
- [docs/EMAILS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/EMAILS.md) — Catálogo completo dos 84 programas com filtros por módulo e técnica
- [Snippet 14 — Envio de E-mail via utp/ut-mail.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/SNIPPETS.md#14-envio-de-e-mail-via-api-datasul-utput-mailp)

---

## 🛠️ Utilitários

**Descrição**: Ferramentas, scripts auxiliares e rotinas de suporte técnico geral.

> 🔄 **Domínio preparado para expansão.**

