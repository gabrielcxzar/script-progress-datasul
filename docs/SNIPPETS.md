# SNIPPETS.md — Biblioteca de Trechos Reutilizáveis (Progress OpenEdge ABL)

Esta biblioteca cataloga os trechos de código Progress ABL mais comuns e reutilizáveis, extraídos ou inspirados pelos scripts reais do repositório.

> **Regra**: Sempre consulte esta biblioteca antes de escrever um bloco de código do zero. Reutilize e adapte.

---

## 📑 Índice

1. [DEF STREAM + OUTPUT](#1-def-stream--output)
2. [EXPORT com Cabeçalho e Delimitador](#2-export-com-cabeçalho-e-delimitador)
3. [FOR EACH com NO-LOCK](#3-for-each-com-no-lock)
4. [FOR EACH com JOIN via FIRST](#4-for-each-com-join-via-first)
5. [FOR EACH com Múltiplos Filtros OR](#5-for-each-com-múltiplos-filtros-or)
6. [FOR EACH com Ordenação BY](#6-for-each-com-ordenação-by)
7. [FIND com NO-LOCK](#7-find-com-no-lock)
8. [Seleção de Ambiente (Produção / Teste)](#8-seleção-de-ambiente-produção--teste)
9. [TEMP-TABLE — Declaração e Uso](#9-temp-table--declaração-e-uso)
10. [TEMP-TABLE — Cruzamento de Lista com Tabela do Banco](#10-temp-table--cruzamento-de-lista-com-tabela-do-banco)
11. [PROCEDURE — Estrutura Básica](#11-procedure--estrutura-básica)
12. [FUNCTION — Estrutura Básica](#12-function--estrutura-básica)
13. [Tratamento de Erros](#13-tratamento-de-erros)

---

## 1. DEF STREAM + OUTPUT

Abertura e fechamento de arquivo de saída para geração de relatórios/CSV:

```progress
DEF STREAM arq.

OUTPUT STREAM arq TO "V:\temp\arquivo_saida.csv" NO-CONVERT.

/* ... lógica de exportação ... */

OUTPUT STREAM arq CLOSE.
```

**`NO-CONVERT`**: Previne conversões de encoding indesejadas em ambientes multi-plataforma.

*Extraído de*: [scripts/consultas/listar_usuarios_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_ativos_datasul.p)

---

## 2. EXPORT com Cabeçalho e Delimitador

Exportação de linha de cabeçalho e dados em formato CSV delimitado por `;`:

```progress
/* Cabeçalho */
EXPORT STREAM arq DELIMITER ";"
    "COLUNA_1"
    "COLUNA_2"
    "COLUNA_3"
    SKIP.

/* Dados (dentro do FOR EACH) */
EXPORT STREAM arq DELIMITER ";"
    tabela.campo1
    tabela.campo2
    tabela.campo3.
```

*Extraído de*: [scripts/consultas/listar_usuarios_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_ativos_datasul.p)

---

## 3. FOR EACH com NO-LOCK

Iteração básica sobre uma tabela sem bloqueio (padrão para relatórios):

```progress
FOR EACH nome_tabela NO-LOCK
    WHERE nome_tabela.campo_filtro = "valor":
    
    /* processamento */
    
END.
```

---

## 4. FOR EACH com JOIN via FIRST

Junção de tabelas em leitura de alta performance — padrão para relatórios multi-tabela:

```progress
FOR EACH tabela_principal NO-LOCK
    WHERE tabela_principal.filtro = "valor",
    FIRST tabela_relacionada NO-LOCK
        WHERE tabela_relacionada.chave = tabela_principal.chave:
    
    /* acesso a campos de ambas as tabelas */
    
END.
```

*Extraído de*: [scripts/consultas/listar_usuarios_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_ativos_datasul.p)

---

## 5. FOR EACH com Múltiplos Filtros OR

Filtragem de múltiplos valores usando operadores `OR` na cláusula `WHERE`:

```progress
FOR EACH tabela NO-LOCK
    WHERE tabela.campo = "valor_1"
       OR tabela.campo = "valor_2"
       OR tabela.campo = "valor_3":
    
    /* processamento */
    
END.
```

*Extraído de*: [scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p)

---

## 6. FOR EACH com Ordenação BY

Ordenação dos resultados com cláusula `BY`:

```progress
FOR EACH tabela_a NO-LOCK
    WHERE tabela_a.filtro = "valor",
    FIRST tabela_b NO-LOCK
        WHERE tabela_b.chave = tabela_a.chave
    BY tabela_a.campo_ordem_1
    BY tabela_b.campo_ordem_2:
    
    /* resultado ordenado */
    
END.
```

*Extraído de*: [scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p)

---

## 7. FIND com NO-LOCK

Localizar um único registro específico sem bloqueio:

```progress
FIND FIRST nome_tabela NO-LOCK
    WHERE nome_tabela.campo = "valor" NO-ERROR.

IF AVAILABLE nome_tabela THEN DO:
    /* use o registro encontrado */
END.
ELSE DO:
    MESSAGE "Registro não encontrado.".
END.
```

---

## 8. Seleção de Ambiente (Produção / Teste)

Padrão obrigatório para todos os scripts que geram arquivos de saída. Exibe um diálogo perguntando o ambiente e define o caminho correto automaticamente.

```progress
DEFINE VARIABLE l_producao AS LOGICAL   NO-UNDO.
DEFINE VARIABLE c_caminho  AS CHARACTER NO-UNDO.

MESSAGE "Executar em Produção?"                      SKIP
        " "                                          SKIP
        "SIM  →  Produção  (Z:\Gnaritas\temp)"       SKIP
        "NÃO  →  Teste / Quality  (V:\temp)"
    VIEW-AS ALERT-BOX QUESTION
    BUTTONS YES-NO
    TITLE "Ambiente de Execução"
    UPDATE l_producao.

IF l_producao THEN
    ASSIGN c_caminho = "Z:\Gnaritas\temp\NOME_DO_ARQUIVO.csv".
ELSE
    ASSIGN c_caminho = "V:\temp\NOME_DO_ARQUIVO.csv".

/* Usar VALUE() para passar a variável ao OUTPUT STREAM */
OUTPUT STREAM arq TO VALUE(c_caminho) NO-CONVERT.
```

**Caminhos padrão desta base:**
- **Produção**: `Z:\Gnaritas\temp\`
- **Teste / Quality**: `V:\temp\`

*Extraído de*: [scripts/consultas/grupo_msp_ativos_empresa_5.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/grupo_msp_ativos_empresa_5.p)

---

## 9. TEMP-TABLE — Declaração e Uso

Declaração de tabela temporária em memória para processamento intermediário:

```progress
DEFINE TEMP-TABLE tt_resultado
    FIELD tt_codigo     AS CHARACTER
    FIELD tt_descricao  AS CHARACTER
    FIELD tt_valor      AS DECIMAL
    INDEX idx_codigo IS PRIMARY tt_codigo.

/* Inserir registro */
CREATE tt_resultado.
ASSIGN
    tt_resultado.tt_codigo    = "001"
    tt_resultado.tt_descricao = "Descrição"
    tt_resultado.tt_valor     = 100.00.

/* Iterar */
FOR EACH tt_resultado NO-LOCK BY tt_resultado.tt_codigo:
    /* processamento */
END.
```

---

## 9. TEMP-TABLE — Cruzamento de Lista com Tabela do Banco

Padrão para verificar, dentro de uma lista pré-carregada (ex: usuários de um grupo), quais registros existem em uma tabela do banco. Ideal quando não há tabela de grupo consultável diretamente ou quando a lista vem de uma fonte externa.

```progress
/* 1. Definir TEMP-TABLE */
DEFINE TEMP-TABLE tt_lista NO-UNDO
    FIELD cod_chave AS CHARACTER
    INDEX idx_chave IS PRIMARY UNIQUE cod_chave.

/* 2. Pré-carga via PROCEDURE auxiliar */
RUN incluir (INPUT "valor_1").
RUN incluir (INPUT "valor_2").
RUN incluir (INPUT "valor_3").

/* 3. Consulta cruzada: tt_lista x tabela_banco x filtro adicional */
FOR EACH tt_lista NO-LOCK,
    FIRST tabela_banco NO-LOCK
        WHERE tabela_banco.chave      = tt_lista.cod_chave
          AND tabela_banco.cod_filtro = "valor_filtro",
    FIRST tabela_aux NO-LOCK
        WHERE tabela_aux.chave     = tt_lista.cod_chave
          AND tabela_aux.log_campo = NO
    BY tabela_banco.chave:

    /* processamento / exportação */

END.

/* 4. Procedure auxiliar de inserção */
PROCEDURE incluir:
    DEFINE INPUT PARAMETER p_chave AS CHARACTER NO-UNDO.
    CREATE tt_lista.
    ASSIGN tt_lista.cod_chave = p_chave.
END PROCEDURE.
```

*Extraído de*: [scripts/consultas/msp_usuarios_com_acesso_empresa_5.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/msp_usuarios_com_acesso_empresa_5.p)

---

## 10. PROCEDURE — Estrutura Básica

Esqueleto de um procedimento interno reutilizável:

```progress
PROCEDURE nome_procedure:
    DEFINE INPUT  PARAMETER p_param_entrada AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER p_param_saida   AS CHARACTER NO-UNDO.
    
    /* lógica */
    
    ASSIGN p_param_saida = "resultado".
    
END PROCEDURE.

/* Chamada */
RUN nome_procedure (INPUT "valor", OUTPUT cVar).
```

---

## 10. FUNCTION — Estrutura Básica

Esqueleto de uma função reutilizável:

```progress
FUNCTION nome_funcao RETURNS CHARACTER
    (INPUT p_param AS CHARACTER):
    
    /* lógica */
    
    RETURN "resultado".
    
END FUNCTION.

/* Chamada */
DEFINE VARIABLE cResultado AS CHARACTER NO-UNDO.
ASSIGN cResultado = nome_funcao("valor").
```

---

## 11. Tratamento de Erros

Estrutura de tratamento de erro e retorno com mensagem:

```progress
DO ON ERROR UNDO, RETURN ERROR:
    
    FIND FIRST tabela EXCLUSIVE-LOCK
        WHERE tabela.campo = "valor" NO-ERROR.
    
    IF NOT AVAILABLE tabela THEN
        RETURN ERROR "Registro não encontrado para o valor informado.".
    
    ASSIGN tabela.campo_alterado = "novo_valor".
    
END.

IF ERROR-STATUS:ERROR THEN DO:
    MESSAGE "Erro na operação: " + ERROR-STATUS:GET-MESSAGE(1).
END.
```
