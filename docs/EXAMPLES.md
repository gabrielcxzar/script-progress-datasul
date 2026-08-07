# EXAMPLES.md — Biblioteca de Exemplos Práticos

Este catálogo centraliza os exemplos práticos de implementação disponíveis no repositório. Para evitar duplicações, este documento aponta diretamente para os scripts reais.

---

## 📌 Exemplos Catalogados

### 1. Exportação de Todos os Usuários Ativos no DataSul (CSV)
* **Objetivo**: Listar globalmente todos os usuários ativos no Datasul sem filtro de empresa, exportando dados de login, nome, e-mail local e celular.
* **Tabelas**: `usuar_mestre_aux`, `usuar_mestre`
* **Categorias**: Consultas, Auditoria, Segurança
* **Script**: [scripts/consultas/listar_usuarios_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_ativos_datasul.p)

---

### 2. Exportação de Usuários Ativos Filtrados por Empresa (CSV)
* **Objetivo**: Extrair lista de usuários ativos no ERP Datasul vinculados a empresas específicas (ex: empresas "2", "5", "6"), gerando arquivo CSV formatado.
* **Tabelas**: `segur_empres_usuar`, `usuar_mestre`, `usuar_mestre_aux`
* **Categorias**: Consultas, Auditoria, Segurança
* **Script**: [scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p)

---

### 3. Usuários de um Grupo Ativos com Acesso a uma Empresa — com Seleção de Ambiente
* **Objetivo**: Verificar dinamicamente quais usuários de um Grupo do DataSul (ex: MSP) estão ativos e têm acesso a uma empresa específica (ex: empresa 5). O script pergunta o ambiente de execução (Produção ou Teste/Quality) e define automaticamente o caminho de saída.
* **Tabelas**: `usuar_grp_usuar`, `usuar_mestre_aux`, `segur_empres_usuar`, `usuar_mestre`
* **Categorias**: Consultas, Auditoria, Segurança
* **Padrões Utilizados**: FOR EACH multi-tabela com FIRST, seleção de ambiente via MESSAGE/UPDATE
* **Script**: [scripts/consultas/grupo_msp_ativos_empresa_5.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/grupo_msp_ativos_empresa_5.p)
* **Saída Produção**: `Z:\Gnaritas\temp\MSP_ATIVOS_EMPRESA_5.csv`
* **Saída Teste**: `V:\temp\MSP_ATIVOS_EMPRESA_5.csv`

---

### 4. Reativação Interativa de Usuário Inativo no DataSul
* **Objetivo**: Reativar o acesso de um usuário no ERP Datasul solicitando o login interativamente e permitindo alterar o campo `log_inativ` (status ativo/inativo) e a data limite de validade (`dat_fim_valid`).
* **Tabelas**: `usuar_mestre`, `usuar_mestre_aux`
* **Categorias**: Manutenção, Segurança, Usuários
* **Padrões Utilizados**: Prompt-for, Input Frame, Update Frame em 1 coluna
* **Script**: [scripts/manutenção/reativar_usuario_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/manuten%C3%A7%C3%A3o/reativar_usuario_datasul.p)

---

### 5. Inativação em Lote de Lista de Usuários com Limpeza de E-mail Local
* **Objetivo**: Inativar uma lista específica de 82 logins no Datasul, limpando previamente o campo `cod_e_mail_local`, ajustando `dat_fim_valid = TODAY`, atualizando a data/hora da última alteração (`dtm_ult_atualiz_usuar = NOW`) e definindo `log_inativ = YES`. Pergunta o ambiente de execução e gera log em CSV.
* **Tabelas**: `usuar_mestre`, `usuar_mestre_aux`
* **Categorias**: Manutenção, Segurança, Usuários
* **Padrões Utilizados**: TEMP-TABLE de carga de lista, Seleção de Ambiente, EXCLUSIVE-LOCK com verificação IF AVAILABLE, Geração de Log CSV
* **Script**: [scripts/manutenção/inativar_usuarios_lista.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/manuten%C3%A7%C3%A3o/inativar_usuarios_lista.p)
* **Saída Produção**: `Z:\Gnaritas\temp\LOG_INATIVACAO_USUARIOS.csv`
* **Saída Teste**: `V:\temp\LOG_INATIVACAO_USUARIOS.csv`


