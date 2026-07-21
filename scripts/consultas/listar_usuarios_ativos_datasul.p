/*
======================================================================
OBJETIVO: Exportar lista geral de usuários ativos no DataSul.
CATEGORIA: consultas / auditoria / segurança
TABELAS: usuar_mestre_aux, usuar_mestre
======================================================================
*/
DEF STREAM arq.

OUTPUT STREAM arq TO "V:\temp\USUARIO_ATIVO_GERAL_EMAIL.csv" NO-CONVERT.

EXPORT STREAM arq DELIMITER ";"
    "LOGIN"
    "NOME"
    "EMAIL LOCAL"
    "EMAIL CELULAR"
    "LOG INATIVO"
    SKIP.

FOR EACH usuar_mestre_aux NO-LOCK
    WHERE usuar_mestre_aux.log_inativ = NO,
    FIRST usuar_mestre NO-LOCK
        WHERE usuar_mestre.cod_usuario = usuar_mestre_aux.cod_usuario
    BY usuar_mestre.cod_usuario:

    EXPORT STREAM arq DELIMITER ";"
        usuar_mestre.cod_usuario
        usuar_mestre.nom_usuario
        usuar_mestre.cod_e_mail_local
        usuar_mestre.cod_e_mail_celular
        usuar_mestre_aux.log_inativ.

END.

OUTPUT STREAM arq CLOSE.
