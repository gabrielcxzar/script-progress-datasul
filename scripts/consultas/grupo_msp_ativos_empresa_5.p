/*
======================================================================
OBJETIVO: Listar todos os usuários do Grupo MSP que estão ATIVOS
          e possuem acesso à empresa 5 no DataSul.
          Pergunta o ambiente de execução (Produção ou Teste/Quality)
          e define automaticamente o caminho de saída do arquivo.
CATEGORIA: consultas / auditoria / segurança
TABELAS:
  - usuar_grp_usuar    (vínculo grupo x usuário — CONFIRMADO)
  - usuar_mestre_aux   (status ativo/inativo do usuário — CONFIRMADO)
  - segur_empres_usuar (vínculo usuário x empresa — CONFIRMADO)
  - usuar_mestre       (dados do usuário: nome, e-mail — CONFIRMADO)
CAMPOS CHAVE:
  - usuar_grp_usuar.cod_grp_usuar = código do grupo (ex: "MSP")
  - usuar_grp_usuar.cod_usuario   = login do usuário
  - usuar_mestre_aux.log_inativ   = NO (apenas ativos)
  - segur_empres_usuar.cod_empresa = "5"
SAÍDA PRODUÇÃO:  Z:\Gnaritas\temp\MSP_ATIVOS_EMPRESA_5.csv
SAÍDA TESTE:     V:\temp\MSP_ATIVOS_EMPRESA_5.csv
AUTOR: Base de Conhecimento Progress / TOTVS Datasul
DATA: 2026-07-20
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
    ASSIGN c_caminho = "Z:\Gnaritas\temp\MSP_ATIVOS_EMPRESA_5.csv".
ELSE
    ASSIGN c_caminho = "V:\temp\MSP_ATIVOS_EMPRESA_5.csv".

/* --- Stream de Saída --- */
DEF STREAM arq.

OUTPUT STREAM arq TO VALUE(c_caminho) NO-CONVERT.

EXPORT STREAM arq DELIMITER ";"
    "EMPRESA"
    "LOGIN"
    "NOME"
    "EMAIL LOCAL"
    "EMAIL CELULAR"
    SKIP.

/* --- Consulta: Grupo MSP x Ativo x Empresa 5 --- */
FOR EACH usuar_grp_usuar NO-LOCK
    WHERE usuar_grp_usuar.cod_grp_usuar = "MSP",
    FIRST usuar_mestre_aux NO-LOCK
        WHERE usuar_mestre_aux.cod_usuario = usuar_grp_usuar.cod_usuario
          AND usuar_mestre_aux.log_inativ  = NO,
    FIRST segur_empres_usuar NO-LOCK
        WHERE segur_empres_usuar.cod_usuario = usuar_grp_usuar.cod_usuario
          AND segur_empres_usuar.cod_empresa  = "5",
    FIRST usuar_mestre NO-LOCK
        WHERE usuar_mestre.cod_usuario = usuar_grp_usuar.cod_usuario
    BY usuar_mestre.cod_usuario:

    EXPORT STREAM arq DELIMITER ";"
        segur_empres_usuar.cod_empresa
        usuar_mestre.cod_usuario
        usuar_mestre.nom_usuario
        usuar_mestre.cod_e_mail_local
        usuar_mestre.cod_e_mail_celular.

END.

OUTPUT STREAM arq CLOSE.

MESSAGE "Arquivo gerado com sucesso!" SKIP
        c_caminho
    VIEW-AS ALERT-BOX INFORMATION
    TITLE "Concluído".
