/*
======================================================================
OBJETIVO: Exportar lista de usuários ativos no DataSul filtrando por empresa.
CATEGORIA: consultas / auditoria / segurança
TABELAS: segur_empres_usuar, usuar_mestre, usuar_mestre_aux
======================================================================
*/
DEF STREAM arq.

OUTPUT STREAM arq TO "V:\temp\USUARIO_ATIVO_POR_EMPRESA_EMAIL.csv" NO-CONVERT.

EXPORT STREAM arq DELIMITER ";"
    "EMPRESA"
    "LOGIN"
    "NOME"
    "EMAIL LOCAL"
    "EMAIL CELULAR"
    "LOG INATIVO"
    SKIP.

FOR EACH segur_empres_usuar NO-LOCK
    WHERE segur_empres_usuar.cod_empresa = "2"
       OR segur_empres_usuar.cod_empresa = "5"
       OR segur_empres_usuar.cod_empresa = "6",
    FIRST usuar_mestre NO-LOCK
        WHERE usuar_mestre.cod_usuario = segur_empres_usuar.cod_usuario,
    FIRST usuar_mestre_aux NO-LOCK
        WHERE usuar_mestre_aux.cod_usuario = usuar_mestre.cod_usuario
          AND usuar_mestre_aux.log_inativ = NO
    BY segur_empres_usuar.cod_empresa
    BY usuar_mestre.cod_usuario:

    EXPORT STREAM arq DELIMITER ";"
        segur_empres_usuar.cod_empresa
        usuar_mestre.cod_usuario
        usuar_mestre.nom_usuario
        usuar_mestre.cod_e_mail_local
        usuar_mestre.cod_e_mail_celular.

END.

OUTPUT STREAM arq CLOSE.
