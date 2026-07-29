# AI_CONVENTIONS.md — Convenções e Regras Obrigatórias para IA

Qualquer agente de Inteligência Artificial que trabalhe neste repositório deve **cumprir rigorosamente** o conjunto de regras abaixo.



> [!CRITICAL]
> **CHECKLIST OBRIGATÓRIO DE INICIALIZAÇÃO DA IA**:
> Toda vez que receber um comando ou tarefa neste repositório, a PRIMEIRA AÇÃO ANTES de criar ou copiar qualquer arquivo é verificar este documento e validar o diretório de destino (ex: arquivos UPC DEVEM ficar obrigatoriamente dentro da pasta upc/).

---

## ⛔ 1. Proibição Absoluta de Duplicação e Alucinação
1. **Pesquisa Obrigatória**: NUNCA crie um script novo do zero sem antes consultar se existe uma solução parcial ou total em `scripts/` ou [docs/EXAMPLES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/EXAMPLES.md).
2. **Reutilização**: Sempre reaproveite código e trechos catalogados em [docs/SNIPPETS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/SNIPPETS.md).
3. **Não Inventar Informação**: Se um índice de banco, chave primária ou relacionamento de tabela não puder ser confirmado diretamente pelo código-fonte dos scripts, ele DEVE ser obrigatoriamente etiquetado como **`(Inferência)`**.

---

## 📝 2. Atualizações Obrigatórias Pós-Modificação

Sempre que um agente adicionar, modificar ou refatorar scripts no repositório, DEVE realizar a atualização sincronizada dos seguintes arquivos:

- **Novas Tabelas / Campos**: Atualizar [docs/TABLES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/TABLES.md) com a especificação da tabela e o link do script.
- **Novos Assuntos / Domínios**: Atualizar [docs/KNOWLEDGE_MAP.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/KNOWLEDGE_MAP.md).
- **Novos Exemplos Relevantes**: Atualizar [docs/EXAMPLES.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/EXAMPLES.md).
- **Novos Snippets**: Atualizar [docs/SNIPPETS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/docs/SNIPPETS.md).
- **Registro da Ação**: Adicionar entrada detalhada em [CHANGELOG_AI.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/CHANGELOG_AI.md).

---

## 📌 3. Padrões de Código Progress OpenEdge
- Utilizar `NO-LOCK` em todas as leituras que não exijam alteração explícita de dados.
- Utilizar `STREAM` com `EXPORT DELIMITER ";"` e `NO-CONVERT` para geração de CSV.
- Utilizar nomes legíveis e padronizados para variáveis e streams.
- Manter o cabeçalho explicativo em todos os scripts `.p`.

---

## 🛠️ 4. Padrões Obrigatórios de UPC (User Program Calls)
1. **Assinatura GUI (SmartWindows/Cadastro)**: Para programas de tela (ex: `CD0201`, `CD0204`, `CD0640`), utilize a assinatura de 6 parâmetros:
   `DEFINE INPUT PARAMETER p-ind-event AS CHARACTER NO-UNDO.`
   `DEFINE INPUT PARAMETER p-ind-object AS CHARACTER NO-UNDO.`
   `DEFINE INPUT PARAMETER p-wgh-object AS HANDLE NO-UNDO.`
   `DEFINE INPUT PARAMETER p-wgh-frame AS WIDGET-HANDLE NO-UNDO.`
   `DEFINE INPUT PARAMETER p-cod-table AS CHARACTER NO-UNDO.`
   `DEFINE INPUT PARAMETER p-row-table AS ROWID NO-UNDO.`
2. **Assinatura DBO/API**: Para programas de lógica de negócios ou APIs (ex: `BOSC070`, `RE1005RP`), utilize:
   `{include/i-epc200.i1}`
   `DEFINE INPUT PARAMETER p-ind-event AS CHARACTER NO-UNDO.`
   `DEFINE INPUT-OUTPUT PARAMETER TABLE FOR tt-epc.`
3. **Nomenclatura**: Seguir `upc-programa.p` (ex: `upc-cd0201.p`).
4. **Estrutura de Pastas / Deploy**: NUNCA crie arquivos de UPC diretamente na raiz da pasta de upload. Salve os arquivos SEMPRE dentro de uma pasta `upc\` (ex: `upc/upc-cd0201.p` no repositório ou `C:\temp\upload\upc\upc-cd0201.p`).
5. **Sensibilidade Inicial dos Campos de Tela (Regra Crítica)**: Ao criar um widget dinâmico (`CREATE FILL-IN`), o campo NUNCA deve iniciar editável (`SENSITIVE = NO`). Ele só pode ser habilitado (`SENSITIVE = YES`) quando o usuário clicar para alterar/incluir (eventos `ENABLE`, `ADD`, `MODIFY`).
6. **Gravação em Campos Livres Genéricos (Datasul)**: Respeitar o nome exato dos campos com hífen (ex: `char-2` em `mgemp.grup-estoque`). Usar `SUBSTRING` para leitura e `OVERLAY` para gravação preservando as posições vizinhas.
7. **Referência Base Real**: Fontes de referência adicionais estão localizados no diretório de específicos (`C:\Users\Dan13\OneDrive\Documentos\Projetos dev\Documentação de esp\Workspace\especificos\p\upc`).

