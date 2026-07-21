# APIS.md — Catálogo de APIs Progress OpenEdge (PO-UI / THF)

Este documento cataloga as APIs Progress ABL criadas para integração com o framework **PO-UI (TOTVS Hermes Framework)**, consumidas por telas Angular + PO-UI embarcadas no menu Datasul.

> **Projeto de referência**: `C:\Users\Dan13\OneDrive\Documentos\Projetos dev\API - PO-UI`

---

## 🔧 Padrão Técnico das APIs

### Estrutura base de uma API Progress para PO-UI

```progress
{utp/ut-api.i}
{utp/ut-api-utils.i}

DEF TEMP-TABLE ttNomeTabela NO-UNDO SERIALIZE-NAME "nome_serializado"
    FIELD campo_1 AS CHARACTER
    FIELD campo_2 AS INTEGER SERIALIZE-NAME "nome-json"
    .

DO:
   RUN pi-json-retorno (OUTPUT jsonOutput).
   jsonOutput:WRITE (INPUT-OUTPUT lcOutput, INPUT YES, INPUT "UTF-8").
   RETURN.
END.

PROCEDURE pi-json-retorno:
   DEF OUTPUT PARAM jsonOutput    AS JsonObject NO-UNDO.
   DEF VAR jsonObjectOutput       AS JsonObject NO-UNDO.

   FOR EACH tabela_banco NO-LOCK
       BY tabela_banco.campo_ordem:
      CREATE ttNomeTabela.
      ASSIGN
         ttNomeTabela.campo_1 = tabela_banco.campo-1
         ttNomeTabela.campo_2 = tabela_banco.campo-2.
   END.

   jsonObjectOutput = NEW JsonObject().
   jsonObjectOutput:READ(TEMP-TABLE ttNomeTabela:HANDLE).
   jsonOutput = JsonAPIResponseBuilder:ok(jsonObjectOutput, 200).

END PROCEDURE.
```

### Includes obrigatórios
| Include | Finalidade |
| :--- | :--- |
| `{utp/ut-api.i}` | Framework base de APIs do THF — expõe `jsonOutput`, `lcOutput` |
| `{utp/ut-api-utils.i}` | Utilitários adicionais do framework THF para APIs |

### Convenções de TEMP-TABLE para APIs
- **`SERIALIZE-NAME`** na tabela → define a chave raiz do JSON retornado (ex: `"grp_usuar"`)
- **`SERIALIZE-NAME`** nos campos → renomeia campos com `_` para `kebab-case` no JSON (ex: `cod-canal-venda`)
- Os campos sem `SERIALIZE-NAME` mantêm o nome original no JSON

### Endpoint padrão
```
GET /api/v1/<nome_arquivo_sem_extensao>
```
Exemplo: arquivo `api_grp_usuar.p` → endpoint `/api/v1/api_grp_usuar`

---

## 📋 APIs Catalogadas

---

### API-001 — Grupos de Usuários (`api_grp_usuar`)

| Atributo | Valor |
| :--- | :--- |
| **Arquivo** | `api_grp_usuar.p` |
| **Endpoint** | `GET /api/v1/api_grp_usuar` |
| **Tabela Banco** | `grp_usuar` |
| **Operação** | Somente leitura (GET) |
| **PO-UI Contexto** | `grp_usuar_po_ui/` |
| **Status** | ✅ Validado e em produção |

#### Payload de Resposta
```json
{
  "grp_usuar": [
    {
      "cod_grp_usuar": "MSP",
      "des_grp_usuar": "Email Solicitação Serviço PDO"
    }
  ]
}
```

#### Tabelas Utilizadas
| Tabela | Campos Lidos |
| :--- | :--- |
| `grp_usuar` | `cod_grp_usuar`, `des_grp_usuar` |

#### TEMP-TABLE
| Campo TT | Tipo | Campo Banco |
| :--- | :--- | :--- |
| `cod_grp_usuar` | CHARACTER | `grp_usuar.cod_grp_usuar` |
| `des_grp_usuar` | CHARACTER | `grp_usuar.des_grp_usuar` |

> **Nota**: A tabela `grp_usuar` é diferente de `usuar_grp_usuar`. A primeira armazena a **definição dos grupos** (código + descrição). A segunda armazena o **vínculo grupo ↔ usuário** (membros de cada grupo).

---

### API-002 — Distribuidores Emitente/Estabelecimento (`api_distrib_emit_estab`)

| Atributo | Valor |
| :--- | :--- |
| **Arquivo** | `api_distrib_emit_estab.p` |
| **Endpoint** | `GET /api/v1/api_distrib_emit_estab` |
| **Tabela Banco** | `distrib-emit-estab` |
| **Operação** | Somente leitura (GET) |
| **PO-UI Contexto** | `distrib_emit_estab_po_ui/` |
| **Ordenação** | `BY cod-estabel, BY cod-emitente` |
| **Status** | ✅ Validado e em produção |

#### Payload de Resposta
```json
{
  "distrib_emit_estab": [
    {
      "cod-canal-venda": 1,
      "cod-cond-pag": 10,
      "cod-emitente": 100,
      "cod-entrega": "CIF",
      "cod-estabel": "0001",
      "cod-rep": 5,
      "nat-operacao": "5101",
      "nat-oper-ext": "",
      "nome-abrev": "DISTRIBUIDORA X",
      "nr-tabpre": "001",
      "val-perc-desc-clien": 0.0
    }
  ]
}
```

#### Tabelas Utilizadas
| Tabela | Campos Lidos |
| :--- | :--- |
| `distrib-emit-estab` | `cod-canal-venda`, `cod-cond-pag`, `cod-emitente`, `cod-entrega`, `cod-estabel`, `cod-rep`, `nat-operacao`, `nat-oper-ext`, `nome-abrev`, `nr-tabpre`, `val-perc-desc-clien` |

#### TEMP-TABLE com mapeamento de campos
| Campo TT (`_`) | Tipo | Campo Banco (`-`) | Serialize-Name JSON |
| :--- | :--- | :--- | :--- |
| `cod_canal_venda` | INTEGER | `cod-canal-venda` | `cod-canal-venda` |
| `cod_cond_pag` | INTEGER | `cod-cond-pag` | `cod-cond-pag` |
| `cod_emitente` | INTEGER | `cod-emitente` | `cod-emitente` |
| `cod_entrega` | CHARACTER | `cod-entrega` | `cod-entrega` |
| `cod_estabel` | CHARACTER | `cod-estabel` | `cod-estabel` |
| `cod_rep` | INTEGER | `cod-rep` | `cod-rep` |
| `nat_operacao` | CHARACTER | `nat-operacao` | `nat-operacao` |
| `nat_oper_ext` | CHARACTER | `nat-oper-ext` | `nat-oper-ext` |
| `nome_abrev` | CHARACTER | `nome-abrev` | `nome-abrev` |
| `nr_tabpre` | CHARACTER | `nr-tabpre` | `nr-tabpre` |
| `val_perc_desc_clien` | DECIMAL | `val-perc-desc-clien` | `val-perc-desc-clien` |

> **Nota sobre nomenclatura**: Tabelas do módulo de vendas/distribuição no DataSul usam hífen (`-`) nos nomes de campos e tabelas (ex: `distrib-emit-estab`). As TEMP-TABLE das APIs convertem para underscore (`_`) para compatibilidade com o JSON e o framework ABL.

---

## 📦 Processo de Deploy

> Documentação completa: [MANUAL_PO_UI_DATASUL_THF.md](file:///C:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/API%20-%20PO-UI/MANUAL_PO_UI_DATASUL_THF.md)

### Fluxo resumido
```
1. Desenvolver API (.p) e tela Angular (po-ui-app/)
2. Build Angular:
   cmd /c npm run build -- --configuration production --base-href /<contexto>/
3. Gerar WAR com conteúdo de dist/<app>/browser/*
4. Validar WAR (entradas internas devem usar "/" não "\")
5. Upload via FTC005:
   - Frontend: Tomcat - WebApps Customizacoes THF (.war)
   - API: pasta UPLOAD/api/v1/
6. Cadastrar no bas_prog_dtsul:
   - Template: Programa THF | Tipo: WEB
   - Nome Externo: <contexto>/
```

### Caminhos operacionais
| Artefato | Caminho |
| :--- | :--- |
| API no projeto | `<projeto>/api_<nome>.p` |
| API para upload | `UPLOAD/api/v1/api_<nome>.p` |
| Cópia externa da API | `C:\Temp\Upload\api\v1\api_<nome>.p` |
| WAR no projeto | `<projeto>/entrega_ftc005_war/<contexto>.war` |
| Cópia externa WAR | `C:\Temp\UploadWar\<contexto>.war` |

### Validação obrigatória do WAR antes de upload
```powershell
$war = "C:\caminho\entrega_ftc005_war\<contexto>.war"
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip = [System.IO.Compression.ZipFile]::OpenRead($war)
"Entradas: $($zip.Entries.Count)"
$zip.Entries | Select-Object -First 30 -ExpandProperty FullName
$zip.Dispose()
```
✅ OK: abre sem exceção, entradas com `/` (ex: `media/font.woff`)
❌ Falha: `zip END header not found` = WAR corrompido, regenerar

---

## 🐛 Troubleshooting Rápido

| Sintoma | Causa | Solução |
| :--- | :--- | :--- |
| `404` após "cópia concluída" | WAR inválido ou contexto errado | Validar WAR + conferir `Nome Externo` |
| `zip END header not found` no log | WAR corrompido | Regenerar WAR |
| API falha com CORS/OPTIONS | URL absoluta + header Authorization | Usar endpoint relativo `/api/v1/...` |
| Fonte `.woff` com 404 | `media/` ausente no WAR | Reconstruir WAR garantindo `dist/.../browser/media/` |
| `npm.ps1` bloqueado | PowerShell policy | Usar `cmd /c npm ...` |
| PO-UI x Angular conflito | Versão incompatível | Fixar `@po-ui/ng-components@20.13.1` |
