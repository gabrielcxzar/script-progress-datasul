# MEMORY.md — Memória Técnica Permanente

Este arquivo armazena **apenas conhecimento técnico permanente** acumulado sobre a base Progress OpenEdge / TOTVS Datasul. Tarefas temporárias ou pendências de sessão não são registradas aqui.

---

## 🏛️ Conhecimentos Consolidados

### 1. Framework de Segurança e Usuários no TOTVS Datasul
- `usuar_mestre`: Tabela central do cadastro de usuários do ERP Datasul. Contém dados fundamentais como `cod_usuario`, `nom_usuario`, `cod_e_mail_local`, `cod_e_mail_celular`, e o campo de validade do login `dat_fim_valid`.
- `usuar_mestre_aux`: Tabela complementar que controla a situação do usuário. O campo `log_inativ` (lógico: `YES`/`NO`) determina se o usuário está inativo no sistema (`YES` = inativo, `NO` = ativo) e o campo `dtm_ult_atualiz_usuar` (datetime) armazena a data/hora exata da alteração/inativação exibida no programa `sec000aa`.
- **Reativação / Inativação de Usuário**: Na inativação em lote, atualiza-se `usuar_mestre.cod_e_mail_local = ""`, `usuar_mestre.dat_fim_valid = TODAY`, `usuar_mestre_aux.log_inativ = YES` e `usuar_mestre_aux.dtm_ult_atualiz_usuar = NOW` (script [scripts/manutenção/inativar_usuarios_lista.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/manuten%C3%A7%C3%A3o/inativar_usuarios_lista.p)).
- `segur_empres_usuar`: Tabela de vinculo de segurança indicando a quais empresas (`cod_empresa`) cada usuário (`cod_usuario`) possui permissão de acesso.

### 2. Padrões de Exportação Progress 4GL / ABL
- Para evitar conversão de caracteres e problemas com acentuação em ambientes Windows/UNIX, utiliza-se a cláusula `NO-CONVERT` no `OUTPUT STREAM arq TO ...`.
- O delimitador padrão adotado nos relatórios da base para integração com Excel/CSV é o ponto e vírgula (`;`).
- O encadeamento de joins com `FOR EACH ... NO-LOCK, FIRST ... NO-LOCK` é o padrão de alta performance para relatórios tabulares.

### 3. Tabela de Vínculo Grupo-Usuário (Confirmado)
- **Tabela real**: `usuar_grp_usuar` (não `usuar_grupo_usuar`).
- **Campo do grupo**: `cod_grp_usuar` (character).
- **Campo do usuário**: `cod_usuario` (character).
- Os campos `cod_livre_*`, `dat_livre_*`, `log_livre_*`, `num_livre_*`, `val_livre_*` são campos genéricos do framework Datasul para extensão customizada.
- Os campos `fwk_created_at` e `fwk_updated_at` são campos de auditoria padrão do framework — presentes em todas as tabelas modernas do DataSul.

### 4. Caminhos de Saída por Ambiente
- **Produção**: `Z:\Gnaritas\temp\`
- **Teste / Quality**: `V:\temp\`
- Todos os scripts de consulta com saída de arquivo devem obrigatoriamente perguntar o ambiente via `MESSAGE ... VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO` e usar `OUTPUT STREAM arq TO VALUE(c_caminho)` para definir o caminho dinamicamente.

### 5. Regras de Desenvolvimento de UPCs e Campos Livres Datasul
- **Criação de Campos em Tela GUI**: Para exibir um campo customizado no programa padrão (ex: `CD0201`), deve-se instanciar o widget via `CREATE FILL-IN` e `CREATE TEXT` no evento `INITIALIZE` / `AFTER-INITIALIZE` no `p-wgh-frame`.
- **Sensibilidade em Consulta**: Na inicialização e nos eventos de exibição (`AFTER-FIND` / `DISPLAY`), o campo DEVE ser criado com `SENSITIVE = NO`. Só habilita (`SENSITIVE = YES`) quando o usuário aciona alteração/inclusão (`ENABLE`, `ADD`, `MODIFY`).
- **Campos Livres Genéricos (Tabela `grup-estoque`)**: O campo livre da tabela `grup-estoque` no banco `mgemp` é nomeado com hífen: `char-2`. A leitura da posição 80 utiliza `SUBSTRING(grup-estoque.char-2, 80, 1)` e a alteração utiliza `OVERLAY(grup-estoque.char-2, 80, 1)`.
- **Estrutura de Diretório**: Arquivos de UPC devem ficar sempre dentro da pasta `upc\` (ex: `upc/upc-cd0201.p` ou `C:\temp\upload\upc\upc-cd0201.p`).


### 6. Protocolo de Inicialização Obrigatório para Agentes de IA
- **Primeira Ação Mandatória**: Antes de criar, copiar ou modificar qualquer arquivo, o agente DEVE consultar [.ai/AI_CONVENTIONS.md](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/.ai/AI_CONVENTIONS.md).
- **Validação de Estrutura de Pastas**: Nenhum arquivo de script ou UPC pode ser criado na raiz; deve-se obrigatoriamente verificar e respeitar o diretório de destino padronizado (upc/, scripts/consultas/, scripts/utilitarios/, etc.).
- **Execução do Checklist**: Verificar convenções de nomenclatura, parâmetros de entrada, sensibilidade de campos (SENSITIVE = NO) e pós-atualização de documentação (CHANGELOG_AI.md, docs/TABLES.md).
