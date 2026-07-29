/* GNARITAS

   AUTOR: ANDRE MORAES
   DATA : 12/2025
   DESCRICAO: UPC PARA CADASTRAR DIVISAO SAP E EMG CODE.
   
*/

DEF INPUT PARAM p-ind-event  AS CHAR NO-UNDO.
DEF INPUT PARAM p-ind-object AS CHAR NO-UNDO.
DEF INPUT PARAM p-wgh-object AS handle NO-UNDO.
DEF INPUT PARAM p-wgh-frame  AS widget-handle NO-UNDO.
DEF INPUT PARAM p-cod-table  AS CHAR NO-UNDO.
DEF INPUT PARAM p-row-table  AS recid NO-UNDO.

DEF VAR wh-object AS WIDGET-HANDLE NO-UNDO.
Def Var c-objeto  As Char           No-undo.

define new global shared variable ghanIdDivisaoSap_011    as handle no-undo.
define new global shared variable ghanLblDivisaoSap_011   as handle no-undo.
define new global shared variable ghanDesDivisaoSap_011   as handle no-undo.
Define New Global Shared Variable ghLcod_grp_div_sap_011  As Handle No-undo.
Define New Global Shared Variable ghcod_grp_div_sap_011   As Handle No-undo.
Define New Global Shared Variable ghL_emg_code_011        As Handle No-undo.
Define New Global Shared Variable gh_emg_code_011         As Handle No-undo.

Assign c-objeto = Entry(Num-entries(p-wgh-object:Private-data, "~/"), p-wgh-object:Private-data, "~/").

if valid-handle(ghanLblDivisaoSap_011) 
   then assign ghanLblDivisaoSap_011:screen-value = 'ID Divisao SAP:'.

IF  p-ind-event = "initialize"
AND p-ind-object = "viewer" THEN DO:

    ASSIGN wh-object = p-wgh-frame:First-child 
           wh-object = wh-object:First-child .

    BUSCA_BOTAO:
    DO WHILE wh-object <> ?:

         IF wh-object:TYPE <> "field-group" THEN DO:

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
                when "v_ind_espec_unid_negoc" or when "ind_espec_unid_negoc" then do:
                    Create Text ghL_emg_code_011
                           Assign  Frame        = p-wgh-frame
                                   Row          = wh-object:Row
                                   Column       = wh-object:Column + wh-object:Width + 2.00
                                   Width        = 10
                                   Format       = "x(10)"
                                   Height       = 0.88
                                   Screen-value = "EMG Code:"
                                   Visible      = True 
                                   Sensitive    = False.     
                                
                    Create Fill-in gh_emg_code_011 
                           Assign Frame             = p-wgh-frame
                                  Data-type         = "character":U
                                  Format            = "x"
                                  Row               = wh-object:Row
                                  Column            = ghL_emg_code_011:Column + 10.50
                                  Side-label-handle = ghL_emg_code_011:Side-label-handle
                                  Name              = "gh_emg_code_011"
                                  Width             = 4
                                  Height            = 0.88
                                  Tooltip           = "EMG Code"
                                  Visible           = True
                                  Sensitive         = False.
                end.
                when "cdn_unid_negoc" then do:
                    create text ghanLblDivisaoSap_011
                    assign frame            = p-wgh-frame
                           data-type        = 'character'
                           format           = 'x(16)'
                           row              = wh-object:row + 1
                           col              = wh-object:col - 11.5
                           width            = 15
                           height           = 0.85
                           visible          = yes
                           screen-value     = "ID Divisao SAP:"
                           sensitive        = no
                           .
                    create fill-in ghanIdDivisaoSap_011
                    assign frame             = p-wgh-frame
                           data-type         = 'character'
                           format            = 'x(8)'
                           row               = wh-object:row + 1
                           col               = wh-object:col
                           width             = 10
                           height            = 0.88
                           visible           = yes
                           screen-value      = ''
                           sensitive         = no
                        .
                    create fill-in ghanDesDivisaoSap_011
                    assign frame             = p-wgh-frame
                           data-type         = 'character'
                           format            = 'x(50)'
                           row               = wh-object:row + 1
                           col               = wh-object:col + 10.25
                           width             = 30
                           height            = 0.88
                           visible           = yes
                           screen-value      = ''
                           sensitive         = no
                        .
                        
                    Create Text ghLcod_grp_div_sap_011
                           Assign  Frame        = p-wgh-frame
                                   Row          = ghanIdDivisaoSap_011:Row + 0.95
                                   Column       = ghanIdDivisaoSap_011:Column - 11.50
                                   Width        = 15
                                   Format       = "x(15)"
                                   Height       = 0.88
                                   Screen-value = "Cod Gr Div SAP:"
                                   Visible      = True 
                                   Sensitive    = False.     
                                
                    Create Fill-in ghcod_grp_div_sap_011 
                           Assign Frame             = p-wgh-frame
                                  Data-type         = "character":U
                                  Format            = "x(50)"
                                  Row               = ghanIdDivisaoSap_011:Row + 0.95
                                  Column            = ghanIdDivisaoSap_011:Column
                                  Side-label-handle = ghLcod_grp_div_sap_011:Side-label-handle
                                  Name              = "ghcod_grp_div_sap_011"
                                  Width             = 50
                                  Height            = 0.88
                                  Tooltip           = "Codigo Devisao Sap"
                                  Visible           = True
                                  Sensitive         = False.
                    
                end.
             end case.

             ASSIGN wh-object=wh-object:NEXT-SIBLING.
         END.  
         ELSE
             ASSIGN wh-object = wh-object:FIRST-CHILD.
     END.
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
                    if valid-handle(ghanIdDivisaoSap_011) then do:
                        assign ghanIdDivisaoSap_011 :screen-value = ""
                               ghanDesDivisaoSap_011:screen-value = ""
                               ghcod_grp_div_sap_011:Screen-value = ""
                               .                        
                    end.

                    if valid-handle(gh_emg_code_011) then
                        assign gh_emg_code_011:screen-value = "".

                    find first es_unid_negoc
                        where es_unid_negoc.cod_unid_negoc = wh-object:screen-value
                        no-lock no-error.
                    if available es_unid_negoc then do:
                        if valid-handle(ghanIdDivisaoSap_011) then
                            assign ghanIdDivisaoSap_011:screen-value  = es_unid_negoc.id_divisao_sap
                                   ghanDesDivisaoSap_011:Screen-value = es_unid_negoc.desc_divisao_sap
                                   ghcod_grp_div_sap_011:Screen-value = es_unid_negoc.cod_grp_div_sap 
                                   .                            
                        if valid-handle(gh_emg_code_011) then
                            assign gh_emg_code_011:screen-value = es_unid_negoc.emg_code.
                    end.
                end.
             end case.

             ASSIGN wh-object=wh-object:NEXT-SIBLING.
         END.  
         ELSE
             ASSIGN wh-object = wh-object:FIRST-CHILD.
     END.
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
