# CONTEXT.md — Contexto Geral e Estratégia de Navegação

---

## 🎯 1. Objetivo do Repositório

O repositório **Script Progress** é uma **Base de Conhecimento permanente e centralizada** dedicada à linguagem **Progress OpenEdge (4GL / ABL)** no contexto do ERP **TOTVS Datasul**.

Ele **NÃO é uma aplicação funcional individual**, mas sim um hub de inteligência técnica onde trechos de código, tabelas de banco de dados, regras de negócio, consultas e scripts de suporte são armazenados, catalogados e interconectados.

---

## 📁 2. Organização das Pastas e Fluxo de Navegação

### Visão Geral da Árvore de Diretórios
- `docs/`: O coração documentacional da base. Contém índices, catálogos de tabelas, snippets e especificações.
- `.ai/`: Instruções e regras para agentes autônomos e assistentes de IA.
- `scripts/`: Onde residem os arquivos `.p` / `.i` organizados por finalidade funcional (`consultas/`, `auditoria/`, `manutenção/`, `migração/`, `exemplos/`, `testes/`, `utilitários/`).
- `templates/`: Modelos pré-formatados para acelerar a criação de novos scripts.
- `consultas/`, `tabelas/`, `exemplos/`: Pontos de acesso rápido para consulta direta.

---

## 🔄 3. Como os Documentos se Relacionam

Os documentos formam uma **Rede Navegável de Conhecimento**:

- [README.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/README.md) aponta para [docs/KNOWLEDGE_MAP.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/KNOWLEDGE_MAP.md) e [.ai/BOOTSTRAP_PROJECT.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/.ai/BOOTSTRAP_PROJECT.md).
- [docs/KNOWLEDGE_MAP.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/KNOWLEDGE_MAP.md) mapeia Domínios Funcionais (Segurança, Cadastros, Financeiro, Fiscal, etc.) apontando diretamente para scripts e tabelas.
- [docs/TABLES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md) documenta cada tabela e especifica quais scripts em `scripts/` a utilizam.
- [docs/EXAMPLES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/EXAMPLES.md) lista cenários práticos vinculando aos scripts reais.
- [docs/SNIPPETS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/SNIPPETS.md) isola pequenos blocos reutilizáveis de código 4GL.

---

## 📈 4. Estratégia de Crescimento da Base de Conhecimento

1. **Adição Gradual de Módulos Datasul**: Conforme novos scripts forem inseridos para áreas como Manufatura, Faturamento, Contabilidade e Estoque, novos domínios serão ativados em `KNOWLEDGE_MAP.md`.
2. **Refinamento de Tabelas**: Conforme novos scripts utilizarem tabelas já catalogadas, suas referências serão expandidas em `TABLES.md`.
3. **Preservação Contínua**: Nenhuma alteração apaga histórico; o conhecimento acumula-se e consolida-se.
