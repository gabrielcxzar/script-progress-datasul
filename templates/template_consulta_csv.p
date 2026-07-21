/*
======================================================================
TEMPLATE: Script de Consulta / Relatório Progress OpenEdge ABL
VERSÃO: 1.1
======================================================================

INSTRUÇÕES DE USO:
1. Copie este arquivo para o diretório correto em scripts/
2. Renomeie seguindo o padrão: [acao]_[objeto]_[contexto].p
   Exemplo: listar_pedidos_abertos.p | exportar_notas_fiscais_mes.p
3. Preencha o cabeçalho abaixo com as informações do script.
4. Atualize docs/TABLES.md e docs/KNOWLEDGE_MAP.md após criar o script.
5. Registre a adição em CHANGELOG_AI.md (se for agente) ou CHANGELOG.md.
======================================================================
*/

/*
======================================================================
OBJETIVO: [Descreva aqui o objetivo completo do script]
CATEGORIA: [consultas | auditoria | manutenção | migração | utilitários | testes]
TABELAS: [Lista de tabelas Progress utilizadas]
SAÍDA PRODUÇÃO:  Z:\Gnaritas\temp\[NOME_DO_ARQUIVO.csv]
SAÍDA TESTE:     V:\temp\[NOME_DO_ARQUIVO.csv]
AUTOR: [Nome / Agente]
DATA: [AAAA-MM-DD]
======================================================================
*/

/* --- Seleção de Ambiente --- */
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

/* --- Stream de Saída --- */
DEF STREAM arq.

OUTPUT STREAM arq TO VALUE(c_caminho) NO-CONVERT.

/* --- Cabeçalho do CSV --- */
EXPORT STREAM arq DELIMITER ";"
    "COLUNA_1"
    "COLUNA_2"
    "COLUNA_3"
    SKIP.

/* --- Consulta Principal --- */
FOR EACH nome_tabela NO-LOCK
    WHERE nome_tabela.campo_filtro = "valor":

    EXPORT STREAM arq DELIMITER ";"
        nome_tabela.campo1
        nome_tabela.campo2
        nome_tabela.campo3.

END.

/* --- Fechamento e Confirmação --- */
OUTPUT STREAM arq CLOSE.

MESSAGE "Arquivo gerado com sucesso!" SKIP
        c_caminho
    VIEW-AS ALERT-BOX INFORMATION
    TITLE "Concluído".
