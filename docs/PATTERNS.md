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

---

## 🛠️ 4. Padrão UPC (User Program Calls / Pontos de Entrada)

### Estrutura Padrão
O padrão **UPC** é o mecanismo oficial do TOTVS Datasul para estender ou alterar o comportamento de programas padrão do ERP sem modificar os fontes originais da TOTVS.

```progress
/* Exemplo de estrutura em upc/upc_nome_programa.p */
{include/i-epc200.i} /* Includes de infraestrutura EPC/UPC */

DEFINE INPUT PARAMETER p-ind-event AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER p-ind-object AS HANDLE    NO-UNDO.

IF p-ind-event = "AFTER-FIND" THEN DO:
    /* Lógica customizada executada imediatamente após o FIND do programa padrão */
END.
ELSE IF p-ind-event = "BEFORE-UPDATE" THEN DO:
    /* Lógica de validação customizada antes da gravação */
END.
```

* **Localização no repositório específico**: `upc/`
* **Vantagens**: Preserva a integridade dos fontes padrão do Datasul durante atualizações de versão (release) do ERP.

---

## ⚡ 5. Padrão de Triggers de Banco de Dados

### Estrutura Padrão
Executadas automaticamente pelo motor do Progress OpenEdge em eventos de tabela (`WRITE`, `DELETE`, `CREATE`, `FIND`):

```progress
TRIGGER PROCEDURE FOR WRITE OF nome-tabela.

/* Validações de regras de negócio antes de efetivar o registro no banco */
IF NEW nome-tabela.campo-valor < 0 THEN DO:
    MESSAGE "Valor inválido para o campo." VIEW-AS ALERT-BOX ERROR.
    RETURN ERROR.
END.
```

* **Localização no repositório específico**: `trigger/`
* **Boas Práticas**: Triggers devem ser extremamente rápidas, leves e nunca conter interfaces com o usuário bloqueantes não tratadas.

---

## 📄 6. Padrão de Relatórios Batch (`*rp.p`)

### Estrutura Padrão
Programas que executam consultas em segundo plano ou via menu batch do Datasul:

```progress
/* esxxxxrp.p */
{utp/ut-glob.i} /* Variáveis globais do sistema */

/* Definição de Temp-Table de Parâmetros */
DEFINE TEMP-TABLE tt-param NO-UNDO
    FIELD cod-estabel-ini AS CHARACTER
    FIELD cod-estabel-fim AS CHARACTER
    FIELD dt-trans-ini    AS DATE
    FIELD dt-trans-fim    AS DATE
    FIELD arquivo-saida   AS CHARACTER.

/* Execução principal */
RUN pi-processar.

PROCEDURE pi-processar:
    DEF STREAM st-out.
    OUTPUT STREAM st-out TO VALUE(tt-param.arquivo-saida) NO-CONVERT.
    
    /* Bloco de consulta e exportação */
    FOR EACH movto-estoq NO-LOCK
        WHERE movto-estoq.cod-estabel >= tt-param.cod-estabel-ini
          AND movto-estoq.cod-estabel <= tt-param.cod-estabel-fim:
        
        EXPORT STREAM st-out DELIMITER ";"
            movto-estoq.cod-estabel
            movto-estoq.it-codigo
            movto-estoq.dt-trans
            movto-estoq.quantidade.
    END.
    
    OUTPUT STREAM st-out CLOSE.
END PROCEDURE.
```

---

## 🌐 7. Padrão de Seleção Dinâmica de Ambiente (Produção vs. Teste)

### Estrutura Padrão
Para garantir que scripts executados manualmente pelos usuários ou consultores não gravadores arquivos de produção em pastas de teste e vice-versa:

```progress
DEFINE VARIABLE l-producao AS LOGICAL   NO-UNDO.
DEFINE VARIABLE c-caminho  AS CHARACTER NO-UNDO.

MESSAGE "Executar em Produção?"                      SKIP
        " "                                          SKIP
        "SIM  →  Produção  (Z:\Gnaritas\temp)"       SKIP
        "NÃO  →  Teste / Quality  (V:\temp)"
    VIEW-AS ALERT-BOX QUESTION
    BUTTONS YES-NO
    TITLE "Ambiente de Execução"
    UPDATE l-producao.

IF l-producao THEN
    ASSIGN c-caminho = "Z:\Gnaritas\temp\NOME_ARQUIVO.csv".
ELSE
    ASSIGN c-caminho = "V:\temp\NOME_ARQUIVO.csv".

OUTPUT STREAM arq TO VALUE(c-caminho) NO-CONVERT.
```

