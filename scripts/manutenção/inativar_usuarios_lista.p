/*
======================================================================
OBJETIVO: Inativar lista de 82 usuários no ERP Datasul e limpar e-mail local.
CATEGORIA: manutenção / segurança / usuários
TABELAS: usuar_mestre, usuar_mestre_aux
======================================================================
DESCRICAO:
Este script carrega uma lista de 82 logins de usuários em uma TEMP-TABLE:
  - Para usuários ATIVOS (log_inativ = NO): Limpa o e-mail local, inativa (log_inativ = YES),
    define dat_fim_valid = TODAY e atualiza a data/hora de inativação (dtm_ult_atualiz_usuar = NOW).
  - Para usuários JÁ INATIVOS (log_inativ = YES): Limpa o e-mail local preservando a data
    de inativação histórica original (não sobrescreve dtm_ult_atualiz_usuar nem dat_fim_valid).
Gera log CSV detalhando SUCESSO (inativados hoje), ALERTA (já inativos) e ERRO (não encontrados).
======================================================================
*/

DEFINE TEMP-TABLE tt_usuario NO-UNDO
    FIELD cod_usuario AS CHARACTER FORMAT "x(20)".

DEFINE STREAM st-log.
DEFINE VARIABLE l-producao    AS LOGICAL   NO-UNDO.
DEFINE VARIABLE c-caminho-log AS CHARACTER NO-UNDO.
DEFINE VARIABLE i-inativados  AS INTEGER   NO-UNDO INITIAL 0.
DEFINE VARIABLE i-ja-inativos AS INTEGER   NO-UNDO INITIAL 0.
DEFINE VARIABLE i-nao-encont  AS INTEGER   NO-UNDO INITIAL 0.

/* Pergunta o ambiente de execução */
MESSAGE "Executar em Produção?"                      SKIP
        " "                                          SKIP
        "SIM  →  Produção  (Z:\Gnaritas\temp)"       SKIP
        "NÃO  →  Teste / Quality  (V:\temp)"
    VIEW-AS ALERT-BOX QUESTION
    BUTTONS YES-NO
    TITLE "Ambiente de Execução"
    UPDATE l-producao.

IF l-producao THEN
    ASSIGN c-caminho-log = "Z:\Gnaritas\temp\LOG_INATIVACAO_USUARIOS.csv".
ELSE
    ASSIGN c-caminho-log = "V:\temp\LOG_INATIVACAO_USUARIOS.csv".

/* Popula a temp-table com a lista de logins */
RUN pi_carregar_lista.

OUTPUT STREAM st-log TO VALUE(c-caminho-log) NO-CONVERT.
EXPORT STREAM st-log DELIMITER ";"
    "LOGIN"
    "STATUS"
    "MENSAGEM"
    SKIP.

FOR EACH tt_usuario NO-LOCK:
    FIND FIRST usuar_mestre EXCLUSIVE-LOCK
         WHERE usuar_mestre.cod_usuario = tt_usuario.cod_usuario NO-ERROR.
    
    FIND FIRST usuar_mestre_aux EXCLUSIVE-LOCK
         WHERE usuar_mestre_aux.cod_usuario = tt_usuario.cod_usuario NO-ERROR.

    IF AVAILABLE usuar_mestre AND AVAILABLE usuar_mestre_aux THEN DO:
        IF usuar_mestre_aux.log_inativ = NO THEN DO:
            /* Usuário ATIVO: Inativa agora e atualiza data/hora de inativação */
            ASSIGN usuar_mestre.cod_e_mail_local          = ""
                   usuar_mestre.dat_fim_valid             = TODAY
                   usuar_mestre_aux.log_inativ            = YES
                   usuar_mestre_aux.dtm_ult_atualiz_usuar = NOW.

            ASSIGN i-inativados = i-inativados + 1.

            EXPORT STREAM st-log DELIMITER ";"
                tt_usuario.cod_usuario
                "SUCESSO"
                "Usuario inativado hoje e e-mail limpo"
                SKIP.
        END.
        ELSE DO:
            /* Usuário JÁ INATIVO: Limpa e-mail preservando a data de inativação histórica */
            ASSIGN usuar_mestre.cod_e_mail_local = "".

            ASSIGN i-ja-inativos = i-ja-inativos + 1.

            EXPORT STREAM st-log DELIMITER ";"
                tt_usuario.cod_usuario
                "ALERTA"
                "Usuario ja estava inativo. E-mail limpo preservando a data de inativacao original"
                SKIP.
        END.
    END.
    ELSE DO:
        ASSIGN i-nao-encont = i-nao-encont + 1.

        EXPORT STREAM st-log DELIMITER ";"
            tt_usuario.cod_usuario
            "ERRO"
            "Usuario nao encontrado em usuar_mestre ou usuar_mestre_aux"
            SKIP.
    END.
END.

OUTPUT STREAM st-log CLOSE.

MESSAGE "Processo concluído com sucesso!" SKIP(1)
        "Inativados hoje: " STRING(i-inativados) SKIP
        "Já estavam inativos (mantida data original): " STRING(i-ja-inativos) SKIP
        "Não encontrados: " STRING(i-nao-encont) SKIP(1)
        "Log de execução salvo em:" SKIP
        c-caminho-log
    VIEW-AS ALERT-BOX INFORMATION TITLE "Inativação de Usuários".

PROCEDURE pi_incluir:
    DEFINE INPUT PARAMETER p-cod-usuario AS CHARACTER NO-UNDO.

    CREATE tt_usuario.
    ASSIGN tt_usuario.cod_usuario = p-cod-usuario.
END PROCEDURE.

PROCEDURE pi_carregar_lista:
    RUN pi_incluir("axdutra").
    RUN pi_incluir("axsouza4").
    RUN pi_incluir("axgarc79").
    RUN pi_incluir("151-sp").
    RUN pi_incluir("axmaciel").
    RUN pi_incluir("axscalab").
    RUN pi_incluir("axpolenc").
    RUN pi_incluir("axcarva1").
    RUN pi_incluir("axsilv23").
    RUN pi_incluir("axnunes").
    RUN pi_incluir("bxschul2").
    RUN pi_incluir("cxdomin3").
    RUN pi_incluir("35").
    RUN pi_incluir("cxlourei").
    RUN pi_incluir("dxolivei").
    RUN pi_incluir("dxnasci2").
    RUN pi_incluir("dxribeir").
    RUN pi_incluir("exolivei").
    RUN pi_incluir("exmiran2").
    RUN pi_incluir("exolive1").
    RUN pi_incluir("excolor").
    RUN pi_incluir("exvallej").
    RUN pi_incluir("fxcordei").
    RUN pi_incluir("fxbrito").
    RUN pi_incluir("fxarias").
    RUN pi_incluir("fxsilva5").
    RUN pi_incluir("gxmacedo").
    RUN pi_incluir("gxsimoes").
    RUN pi_incluir("gxalves").
    RUN pi_incluir("gxsanto3").
    RUN pi_incluir("hxribei1").
    RUN pi_incluir("hxgarc10").
    RUN pi_incluir("jxpenuel").
    RUN pi_incluir("jxfrick").
    RUN pi_incluir("jxrodr92").
    RUN pi_incluir("jxgama").
    RUN pi_incluir("jxbatis5").
    RUN pi_incluir("jxmachad").
    RUN pi_incluir("jxsilv17").
    RUN pi_incluir("lxolive1").
    RUN pi_incluir("lxgomes").
    RUN pi_incluir("lxhansem").
    RUN pi_incluir("lxqueiro").
    RUN pi_incluir("149-sp").
    RUN pi_incluir("lxsouza").
    RUN pi_incluir("lxolive2").
    RUN pi_incluir("lxtarall").
    RUN pi_incluir("lxhenke1").
    RUN pi_incluir("lxmarcon").
    RUN pi_incluir("mxfritol").
    RUN pi_incluir("mxassis").
    RUN pi_incluir("mxsartor").
    RUN pi_incluir("mxdacost").
    RUN pi_incluir("mxandra2").
    RUN pi_incluir("mxribeir").
    RUN pi_incluir("mxfern15").
    RUN pi_incluir("mxjunio1").
    RUN pi_incluir("manorris").
    RUN pi_incluir("oxbarros").
    RUN pi_incluir("137-sp").
    RUN pi_incluir("pxazeved").
    RUN pi_incluir("pxcosta").
    RUN pi_incluir("pxsouza").
    RUN pi_incluir("rxrebela").
    RUN pi_incluir("rxclause").
    RUN pi_incluir("rxumemur").
    RUN pi_incluir("rxsilv16").
    RUN pi_incluir("rxolive8").
    RUN pi_incluir("sxgoncal").
    RUN pi_incluir("sxbatist").
    RUN pi_incluir("stmoraes").
    RUN pi_incluir("sxcosta2").
    RUN pi_incluir("txlevy").
    RUN pi_incluir("txcamargo").
    RUN pi_incluir("txbrabo").
    RUN pi_incluir("vxdossa1").
    RUN pi_incluir("vxpichin").
    RUN pi_incluir("wxsilves").
    RUN pi_incluir("wxfiguei").
    RUN pi_incluir("wxandra1").
    RUN pi_incluir("zxfranco").
    RUN pi_incluir("dxnascim").
END PROCEDURE.
