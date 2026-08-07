/* GNARITAS

   AUTOR: ANDRE MORAES
   DATA : 12/2025
   DESCRICAO: UPC PARA CADASTRAR DIVISAO SAP.
   
*/

DEF INPUT PARAM p-ind-event  AS CHAR NO-UNDO.
DEF INPUT PARAM p-ind-object AS CHAR NO-UNDO.
DEF INPUT PARAM p-wgh-object AS handle NO-UNDO.
DEF INPUT PARAM p-wgh-frame  AS widget-handle NO-UNDO.
DEF INPUT PARAM p-cod-table  AS CHAR NO-UNDO.
DEF INPUT PARAM p-row-table  AS recid NO-UNDO.

DEF VAR wh-object AS WIDGET-HANDLE NO-UNDO.

define new global shared variable ghanIdDivisaoSap_011ca     as handle no-undo.
define new global shared variable ghanLblDivisaoSap_011ca    as handle no-undo.
define new global shared variable ghanDesDivisaoSap_011ca    as handle no-undo.
define new global shared variable ghanLblDesDivisaoSap_011ca as handle no-undo.
Define New Global Shared Variable gh_v_cod_unid_negoc_pai    As Handle No-undo.
Define New Global Shared Variable ghLcod_grp_div_sap_0ca     As Handle No-undo.
Define New Global Shared Variable ghcod_grp_div_sap_0ca      As Handle No-undo.

/*------------------------------------------------------------------------------
  Modificacao feita por: Gabriel Cezar
  Descricao: Adiciona o campo Fill-in 'EMG Code:' na janela de inclusao (utb011ca.p)
             com label proxima da caixa de texto.
------------------------------------------------------------------------------*/
Define New Global Shared Variable ghL_emg_code_011ca         As Handle No-undo.
Define New Global Shared Variable gh_emg_code_011ca          As Handle No-undo.

if valid-handle(ghanLblDivisaoSap_011ca) 
   then assign ghanLblDivisaoSap_011ca:screen-value = 'ID Divisao SAP:'.
if valid-handle(ghanLblDesDivisaoSap_011ca) 
   then assign ghanLblDesDivisaoSap_011ca:screen-value = 'Des Divisao SAP:'.

IF  p-ind-event = "initialize"
AND p-ind-object = "viewer" THEN DO:

    Assign p-wgh-frame:Height = p-wgh-frame:Height + 2
           wh-object = p-wgh-frame:FIRST-CHILD.
           wh-object = wh-object:FIRST-CHILD.

    BUSCA_BOTAO:
    DO WHILE wh-object <> ?:

         IF wh-object:TYPE <> "field-group" THEN DO:
 
             If wh-object:Type = "RECTANGLE" And wh-object:Name = "rt_cxcf" Then
                Assign wh-object:Row = wh-object:Row + 2.
             case wh-object:NAME:
                when "br_bap_segur_unid_negoc" then do:
                    assign wh-object:height = wh-object:height - 1
                           wh-object:row = wh-object:row + 1
                           .
                end.
                when "rt_mold" then do:
                    assign wh-object:height = wh-object:height + 1
                           .
                end.
                when "cdn_unid_negoc" then do:
                    create text ghanLblDivisaoSap_011ca
                    assign frame            = p-wgh-frame
                           data-type        = 'character'
                           format           = 'x(16)'
                           row              = wh-object:row 
                           col              = wh-object:col + 13.5
                           width            = 15
                           height           = 0.85
                           visible          = yes
                           screen-value     = "ID Divisao SAP:"
                           sensitive        = no
                           .
                    create fill-in ghanIdDivisaoSap_011ca
                    assign frame             = p-wgh-frame
                           data-type         = 'character'
                           format            = 'x(8)'
                           row               = wh-object:row 
                           col               = wh-object:col + 24.5
                           width             = 10
                           height            = 0.88
                           visible           = yes
                           screen-value      = ''
                           sensitive         = yes
                        .
                end.
                when "v_ind_espec_unid_negoc" then do:
                    create text ghanLblDesDivisaoSap_011ca
                    assign frame            = p-wgh-frame
                           data-type        = 'character'
                           format           = 'x(16)'
                           row              = wh-object:row 
                           col              = wh-object:col + 12
                           width            = 16
                           height           = 0.85
                           visible          = yes
                           screen-value     = "Des Divisao SAP:"
                           sensitive        = no
                           .
                    create fill-in ghanDesDivisaoSap_011ca
                    assign frame             = p-wgh-frame
                           data-type         = 'character'
                           format            = 'x(50)'
                           row               = wh-object:row 
                           col               = wh-object:col + 24.5
                           width             = 20
                           height            = 0.88
                           visible           = yes
                           screen-value      = ''
                           sensitive         = yes
                        .
                end.
                when "v_cod_unid_negoc_pai" then do:
                    assign gh_v_cod_unid_negoc_pai = wh-object:Handle. 

                    /* Modificacao Gabriel Cezar: EMG Code: proximo da caixa de texto (coluna + 15.00) */
                    if not valid-handle(gh_emg_code_011ca) then do:
                        Create Text ghL_emg_code_011ca
                               Assign Frame        = p-wgh-frame
                                      Row          = wh-object:Row
                                      Column       = wh-object:Column + 15.00
                                      Width        = 9.00
                                      Format       = "x(9)"
                                      Height       = 0.88
                                      Screen-value = "EMG Code:"
                                      Visible      = True 
                                      Sensitive    = False.

                        Create Fill-in gh_emg_code_011ca 
                               Assign Frame             = p-wgh-frame
                                      Data-type         = "character":U
                                      Format            = "x"
                                      Row               = wh-object:Row
                                      Column            = wh-object:Column + 24.50
                                      Side-label-handle = ghL_emg_code_011ca
                                      Name              = "gh_emg_code_011ca"
                                      Width             = 3.50
                                      Height            = 0.88
                                      Tooltip           = "EMG Code"
                                      Visible           = True
                                      Sensitive         = True.
                    end.
                end.
                When "bt_ok"                Then Assign wh-object:Row           = wh-object:Row + 2.
                When "bt_sav"               Then Assign wh-object:Row           = wh-object:Row + 2.
                When "bt_can"               Then Assign wh-object:Row           = wh-object:Row + 2.
                When "bt_pre2"              Then Assign wh-object:Row           = wh-object:Row + 2.
                When "bt_sea2"              Then Assign wh-object:Row           = wh-object:Row + 2.
                When "bt_nex2"              Then Assign wh-object:Row           = wh-object:Row + 2.
                When "bt_cop"               Then Assign wh-object:Row           = wh-object:Row + 2.
                When "bt_hel2"              Then Assign wh-object:Row           = wh-object:Row + 2.
             end case.

             ASSIGN wh-object=wh-object:NEXT-SIBLING.
         END.  
         ELSE
             ASSIGN wh-object = wh-object:FIRST-CHILD.
     END.

    If Valid-handle(gh_v_cod_unid_negoc_pai) = True Then Do: 
    
        Create Text ghLcod_grp_div_sap_0ca
               Assign  Frame        = p-wgh-frame
                       Row          = gh_v_cod_unid_negoc_pai:Row + 0.95
                       Column       = gh_v_cod_unid_negoc_pai:Column - 11.50
                       Width        = 15
                       Format       = "x(15)"
                       Height       = 0.88
                       Screen-value = "Cod Gr Div SAP:"
                       Visible      = True 
                       Sensitive    = False.     
                    
        Create Fill-in ghcod_grp_div_sap_0ca 
               Assign Frame             = p-wgh-frame
                      Data-type         = "character":U
                      Format            = "x(50)"
                      Row               = gh_v_cod_unid_negoc_pai:Row + 0.95
                      Column            = gh_v_cod_unid_negoc_pai:Column
                      Side-label-handle = gh_v_cod_unid_negoc_pai:Side-label-handle
                      Name              = "ghcod_grp_div_sap_0ca"
                      Width             = 45
                      Height            = 0.88
                      Tooltip           = "Codigo Devisao Sap"
                      Visible           = True
                      Sensitive         = True.
    End.
END. 

IF  p-ind-event = "display"
AND p-ind-object = "viewer" THEN DO:
    ASSIGN wh-object = p-wgh-frame:FIRST-CHILD.
           wh-object = wh-object:FIRST-CHILD.

    BUSCA_BOTAO:
    DO WHILE wh-object <> ?:

         IF wh-object:TYPE <> "field-group" THEN DO:

             case wh-object:NAME:
                when "cod_unid_negoc" then do:
                    if valid-handle(ghanIdDivisaoSap_011ca) then do:
                        assign ghanIdDivisaoSap_011ca:screen-value = ""
                               ghanDesDivisaoSap_011ca:screen-value = ""
                               .
                        if valid-handle(gh_emg_code_011ca) then
                            assign gh_emg_code_011ca:screen-value = "".

                        find first es_unid_negoc
                            where es_unid_negoc.cod_unid_negoc = wh-object:screen-value
                            no-lock no-error.
                        if available es_unid_negoc then do:
                            assign ghanIdDivisaoSap_011ca :Screen-value = es_unid_negoc.id_divisao_sap
                                   ghanDesDivisaoSap_011ca:screen-value = es_unid_negoc.desc_divisao_sap
                                   ghcod_grp_div_sap_0ca  :Screen-value = es_unid_negoc.cod_grp_div_sap.
                            if valid-handle(gh_emg_code_011ca) then
                                assign gh_emg_code_011ca:screen-value = es_unid_negoc.emg_code.
                        end.
                    end.
                end.
             end case.

             ASSIGN wh-object=wh-object:NEXT-SIBLING.
         END.
         ELSE
             ASSIGN wh-object = wh-object:FIRST-CHILD.
     END.
end.

IF  p-ind-event = "assign"
AND p-ind-object = "viewer" THEN DO:

    find first ems5.unid_negoc
        where recid(ems5.unid_negoc) = p-row-table
        no-lock no-error.
    if available unid_negoc then do:
        if valid-handle(ghanIdDivisaoSap_011ca) or valid-handle(gh_emg_code_011ca) then do:
                
            find first es_unid_negoc
                where es_unid_negoc.cod_unid_negoc = unid_negoc.cod_unid_negoc
                exclusive-lock no-error.
            if not available es_unid_negoc then do:
                create es_unid_negoc.
                assign es_unid_negoc.cod_unid_negoc = unid_negoc.cod_unid_negoc.
            end.
            if valid-handle(ghanIdDivisaoSap_011ca) then
                assign es_unid_negoc.id_divisao_sap     = ghanIdDivisaoSap_011ca :screen-value
                       es_unid_negoc.desc_divisao_sap   = ghanDesDivisaoSap_011ca:screen-value
                       es_unid_negoc.cod_grp_div_sap    = ghcod_grp_div_sap_0ca  :Screen-value.

            if valid-handle(gh_emg_code_011ca) then
                assign es_unid_negoc.emg_code = gh_emg_code_011ca:screen-value.

            release es_unid_negoc.       
        end.
    end.
end.
