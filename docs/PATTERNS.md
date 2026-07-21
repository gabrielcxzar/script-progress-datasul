# PATTERNS.md — Padrões de Código e Boas Práticas

Este documento detalha os padrões de desenvolvimento identificados nos scripts Progress OpenEdge ABL / 4GL analisados no repositório.

---

## 🎨 1. Padrão de Exportação de Dados via Stream

### Estrutura Padrão
Para exportação de relatórios e arquivos de integração (CSV):

```progress
DEF STREAM arq.

OUTPUT STREAM arq TO "caminho_arquivo.csv" NO-CONVERT.

EXPORT STREAM arq DELIMITER ";"
    "CABECALHO_1"
    "CABECALHO_2"
    SKIP.

FOR EACH tabela NO-LOCK:
    EXPORT STREAM arq DELIMITER ";"
        tabela.campo1
        tabela.campo2.
END.

OUTPUT STREAM arq CLOSE.
```

* **Vantagens**: Performance alta em batch, ausência de conversão indevida de encoding (`NO-CONVERT`) e compatibilidade universal com Excel via delimitador `;`.

---

## 🔗 2. Padrão de Joins de Alta Performance

### Estrutura Padrão
Para vincular tabelas pai-filho ou de relacionamento em relatórios:

```progress
FOR EACH tabela_relacional NO-LOCK
    WHERE tabela_relacional.filtro = "valor",
    FIRST tabela_mestre NO-LOCK
        WHERE tabela_mestre.chave = tabela_relacional.chave,
    FIRST tabela_auxiliar NO-LOCK
        WHERE tabela_auxiliar.chave = tabela_mestre.chave
          AND tabela_auxiliar.status = NO
    BY tabela_relacional.ordenacao_1
    BY tabela_mestre.ordenacao_2:
```

* **Vantagens**: A cláusula `FIRST` combinada com `NO-LOCK` reduz o overhead de busca no banco de dados e impede travamentos de registros em tabelas transacionais.

---

## 🔒 3. Padrão de Locks e Concorrência

- **`NO-LOCK` (Obrigatório em Relatórios/Consultas)**: Impede locks desnecessários na base de dados do ERP Datasul.
- **`EXCLUSIVE-LOCK` (Apenas em Atualizações)**: Deve ser restrito ao menor bloco transacional possível para evitar deadlocks no ERP.
