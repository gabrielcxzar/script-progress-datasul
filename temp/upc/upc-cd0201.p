/*
======================================================================
PROGRAMA: upc-cd0201.p
ERP / PROGRAMA PADRÃO: TOTVS Datasul - CD0201 (Cadastro de Grupo de Estoque)
BANCO / TABELA: mgemp.grup-estoque
TIPO: UPC (User Program Customization / Ponto de Entrada)
======================================================================
OBJETIVO:
Incluir o campo alfanumérico "EMG Code" (1 caractere) na tela do
programa padrão CD0201, posicionado ao lado do campo de Descrição.
Os dados são armazenados na tabela mgemp.grup-estoque, no campo livre
char-2, iniciando a partir da posição 80.
======================================================================
*/

/* *** DEFINIÇÃO DE PARÂMETROS PADRÃO UPC DATASUL (INTERFACE GUI) *** */
DEFINE INPUT PARAMETER p-ind-event  AS CHARACTER     NO-UNDO.
DEFINE INPUT PARAMETER p-ind-object AS CHARACTER     NO-UNDO.
DEFINE INPUT PARAMETER p-wgh-object AS HANDLE        NO-UNDO.
DEFINE INPUT PARAMETER p-wgh-frame  AS WIDGET-HANDLE NO-UNDO.
DEFINE INPUT PARAMETER p-cod-table  AS CHARACTER     NO-UNDO.
DEFINE INPUT PARAMETER p-row-table  AS ROWID         NO-UNDO.

/* *** VARIÁVEIS GLOBAIS DE HANDLES DOS WIDGETS DINÂMICOS *** */
DEFINE NEW GLOBAL SHARED VARIABLE ghanIdEMGCode  AS HANDLE NO-UNDO.
DEFINE NEW GLOBAL SHARED VARIABLE ghanLblEMGCode AS HANDLE NO-UNDO.

/* *** VARIÁVEIS LOCAIS DA UPC *** */
DEFINE VARIABLE c-objeto   AS CHARACTER NO-UNDO.
DEFINE VARIABLE wh-object  AS HANDLE    NO-UNDO.
DEFINE VARIABLE c-emg-code AS CHARACTER NO-UNDO.

/* Identificação do objeto invocador */
IF VALID-HANDLE(p-wgh-object) AND p-wgh-object:PRIVATE-DATA <> ? THEN
    ASSIGN c-objeto = ENTRY(NUM-ENTRIES(p-wgh-object:PRIVATE-DATA, "~/":U), p-wgh-object:PRIVATE-DATA, "~/":U).

/* ------------------------------------------------------------------ */
/* TRATAMENTO DOS EVENTOS DA UPC DO CD0201                            */
/* ------------------------------------------------------------------ */

CASE p-ind-event:

    /* -------------------------------------------------------------- */
    /* Eventos de Inicialização: Cria os Widgets Dinâmicos na Tela     */
    /* -------------------------------------------------------------- */
    WHEN "INITIALIZE" OR WHEN "AFTER-INITIALIZE" THEN DO:
        IF VALID-HANDLE(p-wgh-frame) AND NOT VALID-HANDLE(ghanIdEMGCode) THEN DO:
            ASSIGN wh-object = p-wgh-frame:FIRST-CHILD.
            IF VALID-HANDLE(wh-object) AND wh-object:TYPE = "field-group":U THEN
                ASSIGN wh-object = wh-object:FIRST-CHILD.

            DO WHILE VALID-HANDLE(wh-object):
                IF wh-object:TYPE <> "field-group":U THEN DO:
                    /* Localiza o campo de Descrição no frame para posicionar ao lado */
                    IF wh-object:NAME = "descricao":U OR wh-object:NAME = "des-grupo":U OR wh-object:NAME = "cod-grupo":U THEN DO:
                        /* Cria o Rótulo (Label "EMG Code:") ajustado e rente à caixa de texto */
                        CREATE TEXT ghanLblEMGCode
                        ASSIGN FRAME        = p-wgh-frame
                               DATA-TYPE    = "character":U
                               FORMAT       = "x(10)":U
                               ROW          = wh-object:ROW
                               COL          = wh-object:COL + wh-object:WIDTH + 1.5
                               WIDTH        = 9.5
                               HEIGHT       = 0.88
                               AUTO-RESIZE  = YES
                               VISIBLE      = YES
                               SCREEN-VALUE = "EMG Code:":U
                               SENSITIVE    = NO.

                        /* Cria a Caixa de Texto (Fill-in) compacta (1 caractere) e desabilitada inicialmente */
                        CREATE FILL-IN ghanIdEMGCode
                        ASSIGN FRAME        = p-wgh-frame
                               DATA-TYPE    = "character":U
                               FORMAT       = "X":U
                               ROW          = wh-object:ROW
                               COL          = ghanLblEMGCode:COL + 9.5
                               WIDTH        = 2.5
                               HEIGHT       = 0.88
                               VISIBLE      = YES
                               SCREEN-VALUE = "":U
                               SENSITIVE    = NO.
                        LEAVE.
                    END.
                    ASSIGN wh-object = wh-object:NEXT-SIBLING.
                END.
                ELSE
                    ASSIGN wh-object = wh-object:FIRST-CHILD.
            END.

            /* Fallback: posiciona no topo direito do frame se não encontrar o nome */
            IF NOT VALID-HANDLE(ghanIdEMGCode) THEN DO:
                CREATE TEXT ghanLblEMGCode
                ASSIGN FRAME        = p-wgh-frame
                       DATA-TYPE    = "character":U
                       FORMAT       = "x(10)":U
                       ROW          = 1.50
                       COL          = 50.00
                       WIDTH        = 9.5
                       HEIGHT       = 0.88
                       AUTO-RESIZE  = YES
                       VISIBLE      = YES
                       SCREEN-VALUE = "EMG Code:":U
                       SENSITIVE    = NO.

                CREATE FILL-IN ghanIdEMGCode
                ASSIGN FRAME        = p-wgh-frame
                       DATA-TYPE    = "character":U
                       FORMAT       = "X":U
                       ROW          = 1.50
                       COL          = 59.50
                       WIDTH        = 2.5
                       HEIGHT       = 0.88
                       VISIBLE      = YES
                       SCREEN-VALUE = "":U
                       SENSITIVE    = NO.
            END.
        END.
    END.

    /* -------------------------------------------------------------- */
    /* Eventos de Leitura/Exibição: AFTER-FIND, DISPLAY, DISPLAY-FIELDS */
    /* Exibe o caractere da posição 80 do campo char-2 no widget     */
    /* Mantém o campo desabilitado durante a visualização             */
    /* -------------------------------------------------------------- */
    WHEN "AFTER-FIND" OR WHEN "DISPLAY" OR WHEN "DISPLAY-FIELDS" OR WHEN "DISPLAY-RECORD" THEN DO:
        IF p-row-table <> ? THEN DO:
            FIND FIRST grup-estoque NO-LOCK WHERE ROWID(grup-estoque) = p-row-table NO-ERROR.
            IF AVAILABLE grup-estoque THEN DO:
                ASSIGN c-emg-code = SUBSTRING(grup-estoque.char-2, 80, 1).
                IF c-emg-code = ? THEN ASSIGN c-emg-code = "".
                IF VALID-HANDLE(ghanIdEMGCode) THEN ASSIGN
                    ghanIdEMGCode:SCREEN-VALUE = c-emg-code
                    ghanIdEMGCode:SENSITIVE    = NO.
            END.
        END.
        ELSE DO:
            IF VALID-HANDLE(ghanIdEMGCode) THEN ASSIGN
                ghanIdEMGCode:SCREEN-VALUE = ""
                ghanIdEMGCode:SENSITIVE    = NO.
        END.
    END.

    /* -------------------------------------------------------------- */
    /* Eventos de Gravação: BEFORE-UPDATE, ASSIGN, ASSIGN-RECORD      */
    /* Obtém a entrada do widget e grava na posição 80 do char-2     */
    /* -------------------------------------------------------------- */
    WHEN "BEFORE-UPDATE" OR WHEN "ASSIGN" OR WHEN "ASSIGN-RECORD" OR WHEN "ASSIGN-FIELDS" THEN DO:
        IF p-row-table <> ? THEN DO:
            FIND FIRST grup-estoque EXCLUSIVE-LOCK WHERE ROWID(grup-estoque) = p-row-table NO-ERROR.
            IF AVAILABLE grup-estoque THEN DO:
                IF VALID-HANDLE(ghanIdEMGCode) THEN
                    ASSIGN c-emg-code = ghanIdEMGCode:SCREEN-VALUE.

                /* Garante tamanho mínimo de 80 caracteres */
                IF LENGTH(grup-estoque.char-2) < 80 THEN DO:
                    IF grup-estoque.char-2 = ? THEN
                        ASSIGN grup-estoque.char-2 = "".
                    ASSIGN grup-estoque.char-2 = RIGHT-TRIM(grup-estoque.char-2) + FILL(" ", 80 - LENGTH(grup-estoque.char-2)).
                END.

                /* Sobrepõe a posição 80 com o valor informado */
                OVERLAY(grup-estoque.char-2, 80, 1) = IF c-emg-code <> "" THEN c-emg-code ELSE " ".
            END.
        END.
    END.

    /* -------------------------------------------------------------- */
    /* Eventos de Estado: Habilita apenas em modo de edição/inclusão  */
    /* -------------------------------------------------------------- */
    WHEN "ENABLE" OR WHEN "AFTER-ENABLE" OR WHEN "ENABLE-FIELDS" OR WHEN "ADD" OR WHEN "MODIFY" THEN DO:
        IF VALID-HANDLE(ghanIdEMGCode) THEN
            ASSIGN ghanIdEMGCode:SENSITIVE = YES.
    END.

    WHEN "DISABLE" OR WHEN "AFTER-DISABLE" OR WHEN "DISABLE-FIELDS" OR WHEN "CANCEL" THEN DO:
        IF VALID-HANDLE(ghanIdEMGCode) THEN
            ASSIGN ghanIdEMGCode:SENSITIVE = NO.
    END.

END CASE.

RETURN "OK":U.
