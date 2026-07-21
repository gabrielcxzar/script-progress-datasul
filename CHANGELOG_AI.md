# CHANGELOG_AI (Histórico de Alterações por Agentes de IA)

Este arquivo registra todas as alterações, manutenções, refatorações e catalogações realizadas automaticamente por Agentes de IA neste repositório.

---

## [1.0.0] - 2026-07-20 (Antigravity Agent)

### Inicialização e Transformação da Base de Conhecimento
- **Estrutura de Pastas**: Criados diretórios `/docs`, `/.ai`, `/.meta`, `/scripts` (`consultas`, `auditoria`, `manutenção`, `migração`, `exemplos`, `testes`, `utilitários`), `/templates`, `/consultas`, `/tabelas`, `/exemplos`.
- **Análise e Classificação de Scripts**:
  - Catalogado [scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p) (Categorias: `consultas`, `auditoria`, `segurança`).
  - Catalogado [scripts/consultas/listar_usuarios_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_ativos_datasul.p) (Categorias: `consultas`, `auditoria`, `segurança`).
- **Documentação Criada**:
  - `README.md`, `CHANGELOG.md`, `CHANGELOG_AI.md`.
  - `docs/ARCHITECTURE.md`, `docs/SPEC.md`, `docs/ROADMAP.md`, `docs/DECISIONS.md`, `docs/PATTERNS.md`, `docs/EXAMPLES.md`, `docs/DATABASE.md`, `docs/TABLES.md`, `docs/QUERIES.md`, `docs/SNIPPETS.md`, `docs/KNOWLEDGE_MAP.md`.
  - `.ai/BOOTSTRAP_PROJECT.md`, `.ai/AGENTS.md`, `.ai/AI_CONVENTIONS.md`, `.ai/GOVERNANCE.md`, `.ai/CONTEXT.md`, `.ai/MEMORY.md`.
- **Mapeamento de Tabelas**: Documentadas tabelas `usuar_mestre`, `usuar_mestre_aux`, `segur_empres_usuar` com marcação de inferências para índices.

---

## [1.0.1] - 2026-07-20 (Antigravity Agent)

### Novo Script: Consulta de Usuários Ativos por Empresa 5
- **Contexto**: Solicitação de cruzamento de lista de usuários do Grupo MSP com acesso à empresa 5 no DataSul.
- **Script Criado**: [scripts/consultas/listar_usuarios_ativos_empresa_5.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_ativos_empresa_5.p) — Derivado de Q-002, filtrado especificamente para `cod_empresa = "5"`.
- **Documentos Atualizados**:
  - `docs/QUERIES.md` — Adicionada entrada Q-003.
  - `docs/EXAMPLES.md` — Adicionado Exemplo 3.
  - `docs/TABLES.md` — Adicionada referência do novo script na tabela `segur_empres_usuar`.

---

## [1.0.2] - 2026-07-20 (Antigravity Agent)

### Novo Script: Cruzamento Grupo MSP x Empresa 5
- **Contexto**: Solicitação de verificação de quais usuários do Grupo MSP (Email Solicitação Serviço PDO — 75 logins) possuem acesso ativo à empresa 5.
- **Script Criado**: [scripts/consultas/msp_usuarios_com_acesso_empresa_5.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/msp_usuarios_com_acesso_empresa_5.p) — Utiliza `TEMP-TABLE tt_msp` para pré-carga da lista do grupo e cruza com `segur_empres_usuar` (empresa 5) + `usuar_mestre_aux` (status ativo).
- **Novo Padrão Identificado**: `TEMP-TABLE` + `PROCEDURE incluir` para cruzamento de listas externas com tabelas do banco.
- **Documentos Atualizados**:
  - `docs/QUERIES.md` — Adicionada entrada Q-004.
  - `docs/SNIPPETS.md` — Adicionado Snippet 9: TEMP-TABLE Cruzamento de Lista.

---

## [1.0.3] - 2026-07-20 (Antigravity Agent)

### Novo Script: Consulta por Grupo Diretamente (sem hardcode de lista)
- **Contexto**: Evolução da abordagem anterior — em vez de hardcodar 75 logins, o script consulta diretamente a tabela de vínculo grupo-usuário do DataSul.
- **Script Criado**: [scripts/consultas/grupo_msp_ativos_empresa_5.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/grupo_msp_ativos_empresa_5.p)
- **Nova Tabela Inferida**: `usuar_grupo_usuar` — marcada como `(Inferência)`. Nome deduzido pelo padrão de nomenclatura do DataSul. Incluído snippet de diagnóstico via `_file` para confirmar o nome real no banco.
- **Documentos Atualizados**:
  - `docs/TABLES.md` — Adicionada entrada completa para `usuar_grp_usuar` com aviso de inferência e snippet de diagnóstico.
  - `docs/QUERIES.md` — Adicionada entrada Q-005.

---

## [1.0.4] - 2026-07-20 (Antigravity Agent)

### Confirmação Real da Tabela usuar_grp_usuar
- **Contexto**: Execução de diagnóstico `_field OF _file` no banco Progress confirmou todos os campos reais da tabela.
- **Campos Confirmados**: `cod_grp_usuar` (character) = código do grupo; `cod_usuario` (character) = login do usuário. Campos `livre_*` e `fwk_*` catalogados e explicados.
- **Script Corrigido**: [scripts/consultas/grupo_msp_ativos_empresa_5.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/grupo_msp_ativos_empresa_5.p) — Substituídas inferências pelos nomes reais `cod_grp_usuar` e `cod_usuario`. Todos os `(Inferência)` de campos removidos.
- **Documentos Atualizados**:
  - `docs/TABLES.md` — Entrada `usuar_grp_usuar` marcada como ✅ com todos os 15 campos confirmados.

---

## [1.0.5] - 2026-07-20 (Antigravity Agent)

### Limpeza de Scripts Obsoletos + Padrão de Seleção de Ambiente
- **Scripts Removidos** (intermediários / superados):
  - `scripts/consultas/msp_usuarios_com_acesso_empresa_5.p` (abordagem hardcoded, superada)
  - `scripts/consultas/listar_usuarios_ativos_empresa_5.p` (passo intermediário, superado)
  - `scripts/auditoria/listar_usuarios_ativos_datasul.p` (duplicata)
  - `scripts/auditoria/listar_usuarios_por_empresa_ativos_datasul.p` (duplicata)
  - `consultas/listar_usuarios_ativos_datasul.p` (duplicata)
  - `consultas/listar_usuarios_por_empresa_ativos_datasul.p` (duplicata)
- **Script Final Atualizado**: [scripts/consultas/grupo_msp_ativos_empresa_5.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/grupo_msp_ativos_empresa_5.p) — Adicionada seleção de ambiente via `MESSAGE ALERT-BOX` (Produção: `Z:\Gnaritas\temp` / Teste: `V:\temp`). Adicionada mensagem de confirmação ao final.
- **Template Atualizado**: `templates/template_consulta_csv.p` — Inclui agora o bloco de seleção de ambiente como padrão obrigatório.
- **Documentos Atualizados**:
  - `docs/QUERIES.md` — Reconstruído com apenas 3 entradas limpas (Q-001, Q-002, Q-003).
  - `docs/EXAMPLES.md` — Reconstruído com apenas 3 exemplos apontando para scripts existentes.
  - `docs/SNIPPETS.md` — Adicionado Snippet 8: Seleção de Ambiente (Produção / Teste).
  - `.ai/MEMORY.md` — Registrados: nome real da tabela `usuar_grp_usuar`, campos confirmados, caminhos de ambiente.

---

## [1.0.6] - 2026-07-20 (Antigravity Agent)

### Ingestão do Conhecimento de APIs Progress (PO-UI / THF)
- **Origem**: Análise e leitura da pasta `API - PO-UI` (sem alteração nos fontes externos).
- **Novo Documento**: [docs/APIS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/APIS.md) — Documentação completa do padrão REST ABL PO-UI, contratos JSON, includes obrigatórios e esteira de deploy no Tomcat/THF.
- **APIs Catalogadas**:
  - `API-001: api_grp_usuar.p` (leitura da tabela `grp_usuar`)
  - `API-002: api_distrib_emit_estab.p` (leitura da tabela `distrib-emit-estab`)
- **Tabelas Catalogadas em TABLES.md**:
  - `grp_usuar` (definição de grupos de usuários)
  - `distrib-emit-estab` (relações de distribuidor/emitente/estabelecimento)
- **Documentos Atualizados**: `docs/TABLES.md`, `docs/APIS.md`, `docs/KNOWLEDGE_MAP.md`, `CHANGELOG_AI.md`.
