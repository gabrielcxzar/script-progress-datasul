# SPEC.md — Especificações Técnicas e Convenções

Este documento define as especificações técnicas da linguagem Progress OpenEdge ABL/4GL e dos padrões adotados no ecossistema TOTVS Datasul aplicados a esta Base de Conhecimento.

---

## 🛠️ 1. Ambiente e Linguagem

- **Linguagem**: Progress OpenEdge Advanced Business Language (ABL) / 4GL.
- **Plataforma ERP**: TOTVS Datasul (Framework Datasul 11 / Datasul 12).
- **Formatos de Arquivo**:
  - `.p`: Procedimentos principais e scripts executáveis.
  - `.i`: Arquivos de inclusão (includes/header).
  - `.md`: Documentação e metadados.

---

## 📋 2. Padronização de Cabeçalho dos Scripts

Todo script `.p` inserido no repositório DEVE conter o seguinte bloco de instrução/cabeçalho:

```progress
/*
======================================================================
OBJETIVO: [Descrição clara e concisa do objetivo do script]
CATEGORIA: [consultas / auditoria / manutenção / etc.]
TABELAS: [Lista de tabelas principais utilizadas]
======================================================================
*/
```

---

## 🔒 3. Diretrizes de Performance e Leitura

- **Leitura Sem Bloqueio (`NO-LOCK`)**: Todas as consultas que apenas leem dados devem obrigatoriamente utilizar `NO-LOCK`.
- **Joins com `FIRST`**: Ao associar tabelas 1-para-1 ou obter o registro mestre correspondente, utilizar `FIRST <tabela> WHERE ... NO-LOCK`.
- **Streams e Delimitadores**: Utilizar `DEF STREAM` e `OUTPUT STREAM arq TO <caminho> NO-CONVERT` para relatórios em formato delimitado (CSV).
