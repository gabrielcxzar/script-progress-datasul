# Base de Conhecimento Progress OpenEdge / TOTVS Datasul

> **AVISO IMPORTANTE**: Este repositório **NÃO representa uma aplicação executável**. Ele é uma **Base de Conhecimento Técnica permanente**, estruturada como biblioteca técnica reutilizável para consultas, exemplos, documentação de esquemas/tabelas, trechos de código (snippets) e suporte continuado a desenvolvedores e agentes de IA.

---

## 🎯 Objetivo da Base de Conhecimento

Este repositório foi construído para permitir que qualquer desenvolvedor ou agente de IA consiga:

1. **Localizar rapidamente scripts existentes** sem perder tempo reescrevendo soluções prontas.
2. **Reutilizar código** com padrões consolidados (`NO-LOCK`, tratamento de streams, exportação CSV, joins performáticos).
3. **Consultar tabelas e relacionamentos** do ERP TOTVS Datasul com mapeamento funcional detalhado.
4. **Encontrar trechos de código (snippets)** e padrões de arquitetura 4GL/ABL.
5. **Preservar conhecimento técnico** acumulado ao longo de anos de desenvolvimento e sustentação.

---

## 📂 Estrutura do Repositório

```text
/
├── README.md                 # Apresentação e guia principal de uso
├── CHANGELOG.md              # Histórico de alterações mantido por humanos
├── CHANGELOG_AI.md           # Registro automático de atualizações por Agentes de IA
│
├── docs/                     # Documentação Técnica e Arquitetural
│   ├── ARCHITECTURE.md       # Princípios e arquitetura da Base de Conhecimento
│   ├── SPEC.md               # Especificação técnica e padrões OpenEdge / Datasul
│   ├── ROADMAP.md            # Plano de evolução contínua da base
│   ├── DECISIONS.md          # Registros de decisões de arquitetura (ADRs)
│   ├── PATTERNS.md           # Padrões de código 4GL/ABL identificados
│   ├── EXAMPLES.md           # Catálogo de exemplos práticos apontando para scripts reais
│   ├── DATABASE.md           # Visão geral do banco de dados e convenções
│   ├── TABLES.md             # Catálogo de tabelas, campos, índices e scripts relacionados
│   ├── QUERIES.md            # Consultas úteis catalogadas por assunto
│   ├── SNIPPETS.md           # Biblioteca de trechos reutilizáveis (FOR EACH, STREAM, etc.)
│   └── KNOWLEDGE_MAP.md      # Mapa Master de Conhecimento por domínio funcional
│
├── .ai/                      # Governança e Instruções para Agentes de IA
│   ├── BOOTSTRAP_PROJECT.md  # Manual de integração e onboarding para IA
│   ├── AGENTS.md             # Definição de papéis e subagentes
│   ├── AI_CONVENTIONS.md     # Regras obrigatórias de atualização para IA
│   ├── GOVERNANCE.md         # Diretrizes de integridade e não-alucinação (Inferência)
│   ├── CONTEXT.md            # Contexto detalhado do projeto e navegação
│   └── MEMORY.md             # Memória técnica permanente da base
│
├── .meta/                    # Metadados e índices do repositório
│
├── scripts/                  # Repositório principal de scripts Progress (.p / .i)
│   ├── consultas/            # Scripts de extração e consulta de dados
│   ├── auditoria/            # Scripts de conferência, segurança e auditoria
│   ├── manutenção/           # Scripts de correção e carga (preparado)
│   ├── migração/             # Scripts de migração e conversão (preparado)
│   ├── exemplos/             # Scripts didáticos e demonstrativos (preparado)
│   ├── testes/               # Scripts de validação técnica (preparado)
│   └── utilitários/          # Tools e utilitários genéricos (preparado)
│
├── templates/                # Esqueletos e boilerplates para novos scripts
├── consultas/                # Ponto de acesso rápido para consultas
├── tabelas/                  # Ponto de acesso rápido para documentação de tabelas
└── exemplos/                 # Ponto de acesso rápido para scripts de exemplo
```

---

## 🚀 Como Utilizar

### Para Desenvolvedores
1. **Navegação Inicial**: Comece pelo [docs/KNOWLEDGE_MAP.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/KNOWLEDGE_MAP.md) para localizar a área funcional desejada (ex: Segurança, Framework, Financeiro, Fiscal).
2. **Consultar Tabelas**: Veja em [docs/TABLES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md) os detalhes dos campos e relacionamentos das tabelas Datasul.
3. **Buscar Snippets**: Acesse [docs/SNIPPETS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/SNIPPETS.md) para copiar trechos otimizados.
4. **Criar Novo Script**: Utilize os modelos em `templates/` e registre o novo script no repositório.

### Para Agentes de IA
1. Leia primeiramente [.ai/BOOTSTRAP_PROJECT.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/.ai/BOOTSTRAP_PROJECT.md).
2. Siga rigorosamente as convenções em [.ai/AI_CONVENTIONS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/.ai/AI_CONVENTIONS.md).
3. Ao identificar ou criar novos scripts/tabelas, atualize imediatamente `docs/TABLES.md`, `docs/KNOWLEDGE_MAP.md`, `docs/EXAMPLES.md` e `CHANGELOG_AI.md`.

---

## 📊 Regra de Ouro (Integridade das Informações)

Nenhuma informação é inventada. Detalhes técnicos não explícitos nos scripts (ex: nomes exatos de índices de banco ou relacionamentos não documentados no código) são marcados obrigatoriamente com a etiqueta **`(Inferência)`**.

---

## 📄 Licença e Uso

Este repositório é de uso técnico interno para desenvolvimento e inteligência sobre Progress OpenEdge / TOTVS Datasul.
