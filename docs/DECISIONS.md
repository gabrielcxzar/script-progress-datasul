# DECISIONS.md — Registros de Decisões de Arquitetura (ADRs)

Este documento registra as decisões estratégicas e arquiteturais adotadas no projeto para garantir coerência técnica ao longo do tempo.

---

## ADR 001: Definição do Repositório como Base de Conhecimento Não-Executável
* **Data**: 2026-07-20
* **Status**: Aprovado
* **Contexto**: O repositório continha scripts isolados de consulta. Era necessário transformar o espaço em uma fonte permanente de pesquisa para desenvolvedores e agentes de IA.
* **Decisão**: Tratar o repositório como biblioteca técnica reutilizável e catálogo, e não como uma aplicação executável.

---

## ADR 002: Protocolo de Não-Alucinação e Tagging `(Inferência)`
* **Data**: 2026-07-20
* **Status**: Aprovado
* **Contexto**: Agentes de IA podem tentar completar índices de banco de dados ou metadados de tabelas ausentes no código-fonte.
* **Decisão**: Fica proibido inventar metadados. Qualquer detalhe não comprovado diretamente pelo código deve ser explicitamente etiquetado como `(Inferência)`.

---

## ADR 003: Organização Modular por Categorias Funcionais
* **Data**: 2026-07-20
* **Status**: Aprovado
* **Contexto**: Scripts em Progress ABL tendem a se acumular sem classificação.
* **Decisão**: Adotar a subestrutura em `scripts/` (`consultas/`, `auditoria/`, `manutenção/`, `migração/`, `exemplos/`, `testes/`, `utilitários/`) e criar pontos de acesso rápido na raiz (`consultas/`, `tabelas/`, `exemplos/`).
