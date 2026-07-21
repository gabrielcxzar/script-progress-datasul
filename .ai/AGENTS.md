# AGENTS.md — Papéis e Especializações de Agentes de IA

Este documento define os papéis, responsabilidades e especializações esperadas dos Agentes de IA operando nesta Base de Conhecimento.

---

## 🤖 Papéis de Agentes

### 1. Architect / Maintainer Agent
* **Escopo**: Manutenção da estrutura de diretórios, atualização da documentação máster (`KNOWLEDGE_MAP.md`, `TABLES.md`, `DATABASE.md`), validação da rastreabilidade e governança.
* **Foco**: Garantir a longo prazo que a base continue limpa, organizada e sem duplicações.

### 2. Code Analyst & Curator Agent
* **Escopo**: Análise detalhada dos scripts Progress `.p` e `.i`.
* **Foco**: Identificar tabelas, relacionamentos, campos chaves, comandos 4GL reutilizáveis e catalogar snippets em [docs/SNIPPETS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/SNIPPETS.md).

### 3. Developer Support Agent
* **Escopo**: Auxiliar desenvolvedores humanos a montar consultas, relatórios e scripts de manutenção em Progress OpenEdge / Datasul.
* **Foco**: Reutilizar scripts existentes em `scripts/` e indicar boas práticas de performance (`NO-LOCK`, filtros indexados).

---

## 🔄 Protocolo de Colaboração
- Todos os agentes leem [.ai/BOOTSTRAP_PROJECT.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/.ai/BOOTSTRAP_PROJECT.md) antes de agir.
- Qualquer alteração na estrutura documental é espelhada no [CHANGELOG_AI.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/CHANGELOG_AI.md).
