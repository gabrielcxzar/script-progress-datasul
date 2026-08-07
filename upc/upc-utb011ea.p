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
Def Var c-objeto  As Char           No-undo.

define new global shared variable ghanIdDivisaoSap_011ea   as handle no-undo.
define new global shared variable ghanLblDivisaoSap_011ea  as handle no-undo.
define new global shared variable ghanDesDivisaoSap_011ea  as handle no-undo.
define new global shared variable ghanLblDesDivisaoSap_011ea as handle no-undo.
Define New Global Shared Variable ghLcod_grp_div_sap_0ea  As Handle No-undo.
Define New Global Shared Variable ghcod_grp_div_sap_0ea   As Handle No-undo.
Define New Global Shared Variable gh_v_cod_unid_negoc_pai As Handle No-undo.

/*------------------------------------------------------------------------------
  Modificacao feita por: Gabriel Cezar
  Descricao: Adiciona o campo Fill-in 'EMG Code' na edicao/alteracao (utb011ea.p / mod_unic_negoc)
             ao lado da caixa de texto ID Divisao SAP.
------------------------------------------------------------------------------*/
Define New Global Shared Variable ghL_emg_code_011ea       As Handle No-undo.
Define New Global Shared Variable gh_emg_code_011ea        As Handle No-undo.

Assign c-objeto = Entry(Num-entries(p-wgh-object:Private-data, "~/"), p-wgh-object:Private-data, "~/").

IF  p-ind-event = "initialize"
AND p-ind-object = "viewer" THEN DO:

    Assign p-wgh-frame:Height = p-wgh-frame:Height + 2
           wh-object = p-wgh-frame:First-child 
           wh-object = wh-object:First-child .

    BUSCA_BOTAO:
    DO WHILE wh-object <> ?:

         IF wh-object:TYPE <> "field-group" THEN DO:

             If wh-object:Type = "RECTANGLE" And wh-object:Name = "rt_cxcf" Then
                Assign wh-object:Row = wh-object:Row + 1.50.

             case wh-object:NAME:
                when "br_bap_segur_unid_negoc" then do:
                    assign wh-object:height = wh-object:height - 1.50
                           wh-object:row = wh-object:row + 1.50
                           .
                end.
                when "rt_mold" then do:
                    assign wh-object:height = wh-object:height + 1.50
                           .
                end.
                when "cdn_unid_negoc" then do:
                    create text ghanLblDivisaoSap_011ea
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
                    create fill-in ghanIdDivisaoSap_011ea
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

                    /* Modificacao Gabriel Cezar: EMG Code na edicao/alteracao ao lado da caixa ID Divisao SAP */
                    if not valid-handle(gh_emg_code_011ea) then do:
                        Create Text ghL_emg_code_011ea
                               Assign Frame        = p-wgh-frame
                                      Row          = wh-object:Row
                                      Column       = wh-object:Column + 37.00
                                      Width        = 9.00
                                      Format       = "x(9)"
                                      Height       = 0.88
                                      Screen-value = "EMG Code:"
                                      Visible      = True 
                                      Sensitive    = False.

                        Create Fill-in gh_emg_code_011ea 
                               Assign Frame             = p-wgh-frame
                                      Data-type         = "character":U
                                      Format            = "x"
                                      Row               = wh-object:Row
                                      Column            = ghL_emg_code_011ea:Column + 9.20
                                      Side-label-handle = ghL_emg_code_011ea
                                      Name              = "gh_emg_code_011ea"
                                      Width             = 3.50
                                      Height            = 0.88
                                      Tooltip           = "EMG Code"
                                      Visible           = True
                                      Sensitive         = True.
                    end.
                end.
                when "v_ind_espec_unid_negoc" then do:
                    create text ghanLblDesDivisaoSap_011ea
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
                    create fill-in ghanDesDivisaoSap_011ea
                    assign frame             = p-wgh-frame
                           data-type         = 'character'
                           format            = 'x(50)'
                           row               = wh-object:row 
                           col               = wh-object:col + 24.5
                           width             = 30
                           height            = 0.88
                           visible           = yes
                           screen-value      = ''
                           sensitive         = yes
                        .
                end.
                when "v_cod_unid_negoc_pai" then do:
                    assign gh_v_cod_unid_negoc_pai = wh-object:Handle. 
                end.
                When "bt_ok"                Then Assign wh-object:Row           = wh-object:Row + 1.50.
                When "bt_sav"               Then Assign wh-object:Row           = wh-object:Row + 1.50.
                When "bt_can"               Then Assign wh-object:Row           = wh-object:Row + 1.50.
                When "bt_pre2"              Then Assign wh-object:Row           = wh-object:Row + 1.50.
                When "bt_sea2"              Then Assign wh-object:Row           = wh-object:Row + 1.50.
                When "bt_nex2"              Then Assign wh-object:Row           = wh-object:Row + 1.50.
                When "bt_cop"               Then Assign wh-object:Row           = wh-object:Row + 1.50.
                When "bt_hel2"              Then Assign wh-object:Row           = wh-object:Row + 1.50.
                
             end case.

             ASSIGN wh-object=wh-object:NEXT-SIBLING.
         END.  
         ELSE
             ASSIGN wh-object = wh-object:FIRST-CHILD.
     END.

    If Valid-handle(gh_v_cod_unid_negoc_pai) = True Then Do: 
    
        Create Text ghLcod_grp_div_sap_0ea
               Assign  Frame        = p-wgh-frame
                       Row          = gh_v_cod_unid_negoc_pai:Row + 0.95
                       Column       = gh_v_cod_unid_negoc_pai:Column - 11.50
                       Width        = 15
                       Format       = "x(15)"
                       Height       = 0.88
                       Screen-value = "Cod Gr Div SAP:"
                       Visible      = True 
                       Sensitive    = False.     
                    
        Create Fill-in ghcod_grp_div_sap_0ea 
               Assign Frame             = p-wgh-frame
                      Data-type         = "character":U
                      Format            = "x(50)"
                      Row               = gh_v_cod_unid_negoc_pai:Row + 0.95
                      Column            = gh_v_cod_unid_negoc_pai:Column
                      Side-label-handle = gh_v_cod_unid_negoc_pai:Side-label-handle
                      Name              = "ghcod_grp_div_sap_0ea"
                      Width             = 30
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
                    if valid-handle(ghanIdDivisaoSap_011ea) or valid-handle(gh_emg_code_011ea) then do:
                        if valid-handle(ghanIdDivisaoSap_011ea) then
                            assign ghanIdDivisaoSap_011ea:screen-value = ""
                                   ghanDesDivisaoSap_011ea:screen-value = "".

                        if valid-handle(gh_emg_code_011ea) then
                            assign gh_emg_code_011ea:screen-value = "".

                        find first es_unid_negoc
                            where es_unid_negoc.cod_unid_negoc = wh-object:screen-value
                            no-lock no-error.
                        if available es_unid_negoc then do:
                            if valid-handle(ghanIdDivisaoSap_011ea) then
                                assign ghanIdDivisaoSap_011ea:screen-value = es_unid_negoc.id_divisao_sap
                                       ghanDesDivisaoSap_011ea:screen-value = es_unid_negoc.desc_divisao_sap
                                       ghcod_grp_div_sap_0ea  :Screen-value = es_unid_negoc.cod_grp_div_sap.
                            if valid-handle(gh_emg_code_011ea) then
                                assign gh_emg_code_011ea:screen-value = es_unid_negoc.emg_code.
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
        if valid-handle(ghanIdDivisaoSap_011ea) or valid-handle(gh_emg_code_011ea) then do:
                
            find first es_unid_negoc
                where es_unid_negoc.cod_unid_negoc = unid_negoc.cod_unid_negoc
                exclusive-lock no-error.
            if not available es_unid_negoc then do:
                create es_unid_negoc.
                assign es_unid_negoc.cod_unid_negoc = unid_negoc.cod_unid_negoc.
            end.
            if valid-handle(ghanIdDivisaoSap_011ea) then
                assign es_unid_negoc.id_divisao_sap     = ghanIdDivisaoSap_011ea:screen-value
                       es_unid_negoc.desc_divisao_sap   = ghanDesDivisaoSap_011ea:screen-value
                       es_unid_negoc.cod_grp_div_sap    = ghcod_grp_div_sap_0ea  :Screen-value.

            if valid-handle(gh_emg_code_011ea) then
                assign es_unid_negoc.emg_code = gh_emg_code_011ea:screen-value.

            release es_unid_negoc.       
        end.
    end.
end.

Procedure pi-arq-eventos: 
   Def Input Parameter c-local As Char No-undo.
   Output To "X:\GNARITAS\sbo\t\upc\cd0640\temp\escd0640.txt" Append. 
   
   If c-local = "programa" Then
      Put p-ind-event               Format "x(30)" Space(1)
          p-ind-object              Format "x(20)" Space(1)
          p-wgh-object:Private-data Format "x(20)" Space(1)
          p-wgh-frame:Name          Format "x(20)" Space(1)
          p-cod-table               Format "x(20)" Space(1)
          String(p-row-table)       Format "x(20)" Space(1) 
          c-objeto                  Format "x(20)" Space(1) SKIP.
   Else
   If c-local = "evento" Then Do:
   End.       
   Output Close.
End Procedure.
