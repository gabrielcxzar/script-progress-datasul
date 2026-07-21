# BOOTSTRAP_PROJECT.md — Guia de Inicialização para Agentes de IA

Este documento é o **ponto de entrada obrigatório** para qualquer Agente de Inteligência Artificial que for atuar nesta Base de Conhecimento Progress OpenEdge / TOTVS Datasul.

---

## 📚 1. Ordem de Leitura Obrigatória

Ao iniciar o atendimento ou a análise da base, siga rigorosamente esta sequência de leitura:

1. [README.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/README.md) — Visão geral da base e estrutura de pastas.
2. [.ai/CONTEXT.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/.ai/CONTEXT.md) — Contexto do repositório e estratégia de navegação.
3. [.ai/AI_CONVENTIONS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/.ai/AI_CONVENTIONS.md) — Regras inegociáveis de conduta e atualização de documentação.
4. [.ai/GOVERNANCE.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/.ai/GOVERNANCE.md) — Princípios de integridade de dados e marcação de `(Inferência)`.
5. [docs/KNOWLEDGE_MAP.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/KNOWLEDGE_MAP.md) — Mapa principal para localização por domínio de negócio.
6. [docs/TABLES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md) — Catálogo de tabelas Datasul e relacionamentos.

---

## 🗺️ 2. Mapeamento de Localização

| Conteúdo Desejado | Localização Principal | Arquivo de Documentação |
| :--- | :--- | :--- |
| **Scripts Prontos** | `scripts/` e subpastas | [docs/EXAMPLES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/EXAMPLES.md) |
| **Consultas Especificas** | `consultas/` e `scripts/consultas/` | [docs/QUERIES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/QUERIES.md) |
| **Documentação de Tabelas** | `tabelas/` | [docs/TABLES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md) |
| **Snippets / Trechos** | `docs/SNIPPETS.md` | [docs/SNIPPETS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/SNIPPETS.md) |
| **Padrões de Código** | `docs/PATTERNS.md` | [docs/PATTERNS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/PATTERNS.md) |
| **Boilerplates / Modelos** | `templates/` | [docs/SPEC.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/SPEC.md) |

---

## 🛠️ 3. Como Construir Novos Scripts Reutilizando Conhecimento

Quando o usuário solicitar a criação de um novo script ou modificação de um existente:

1. **Pesquisar Primeiro**: Verifique se já existe algo semelhante em `scripts/` ou em [docs/EXAMPLES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/EXAMPLES.md).
2. **Reutilizar Trechos**: Copie construções de `NO-LOCK`, `EXPORT STREAM`, declaração de streams e joins catalogadas em [docs/SNIPPETS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/SNIPPETS.md).
3. **Respeitar Convenções**: Siga a nomenclatura padrão Datasul e as boas práticas descritas em [docs/PATTERNS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/PATTERNS.md).
4. **Usar Modelo**: Baseie-se no template correspondente na pasta `templates/`.

---

## ✅ 4. Checklist Inicial (Antes de Iniciar Qualquer Tarefa)

- [ ] Verifiquei o objetivo solicitado pelo usuário.
- [ ] Consultei [docs/KNOWLEDGE_MAP.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/KNOWLEDGE_MAP.md) para identificar o domínio funcional.
- [ ] Pesquisei em `scripts/` se já existe script semelhante.
- [ ] Verifiquei em [docs/TABLES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md) os campos e relacionamentos das tabelas envolvidas.

---

## 🏁 5. Checklist Final (Antes de Encerrar a Tarefa)

- [ ] O script criado/modificado segue os padrões do repositório?
- [ ] Atualizei [docs/TABLES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md) caso novas tabelas/campos tenham sido identificados?
- [ ] Atualizei [docs/KNOWLEDGE_MAP.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/KNOWLEDGE_MAP.md) se um novo assunto foi coberto?
- [ ] Atualizei [docs/EXAMPLES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/EXAMPLES.md) se um novo exemplo importante foi criado?
- [ ] Marquei como `(Inferência)` qualquer informação não 100% comprovada pelos scripts?
- [ ] Registrei todas as mudanças efetuadas em [CHANGELOG_AI.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/CHANGELOG_AI.md)?
