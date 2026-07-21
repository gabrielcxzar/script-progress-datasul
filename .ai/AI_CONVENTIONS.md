# AI_CONVENTIONS.md — Convenções e Regras Obrigatórias para IA

Qualquer agente de Inteligência Artificial que trabalhe neste repositório deve **cumprir rigorosamente** o conjunto de regras abaixo.

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
