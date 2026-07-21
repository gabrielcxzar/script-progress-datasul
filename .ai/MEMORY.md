# MEMORY.md — Memória Técnica Permanente

Este arquivo armazena **apenas conhecimento técnico permanente** acumulado sobre a base Progress OpenEdge / TOTVS Datasul. Tarefas temporárias ou pendências de sessão não são registradas aqui.

---

## 🏛️ Conhecimentos Consolidados

### 1. Framework de Segurança e Usuários no TOTVS Datasul
- `usuar_mestre`: Tabela central do cadastro de usuários do ERP Datasul. Contém dados fundamentais como `cod_usuario`, `nom_usuario`, `cod_e_mail_local`, `cod_e_mail_celular`.
- `usuar_mestre_aux`: Tabela complementar que controla a situação do usuário. O campo `log_inativ` (lógico: `YES`/`NO`) determina se o usuário está inativo no sistema.
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
