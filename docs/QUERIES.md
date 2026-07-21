# QUERIES.md — Catálogo de Consultas Úteis

Este documento cataloga as consultas Progress OpenEdge ABL disponíveis no repositório, agrupadas por assunto e com instruções de uso.

---

## 🔄 Atualização
Sempre que um novo script de consulta for adicionado ao repositório, uma entrada correspondente deve ser adicionada aqui.

---

## 👤 Domínio: Usuários e Segurança

### Q-001 — Listar Todos os Usuários Ativos no DataSul

* **Quando Usar**: Para obter a lista completa de usuários habilitados no ERP, independentemente da empresa. Útil para inventários de acesso, relatórios de TI, ou integração com diretórios corporativos (AD/LDAP).
* **Saída**: CSV com `LOGIN`, `NOME`, `EMAIL LOCAL`, `EMAIL CELULAR`, `LOG INATIVO`.
* **Tabelas**: `usuar_mestre_aux` (filtro de status) + `usuar_mestre` (dados do usuário)
* **Script**: [scripts/consultas/listar_usuarios_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_ativos_datasul.p)
* **Lógica Principal**:
  ```progress
  FOR EACH usuar_mestre_aux NO-LOCK
      WHERE usuar_mestre_aux.log_inativ = NO,
      FIRST usuar_mestre NO-LOCK
          WHERE usuar_mestre.cod_usuario = usuar_mestre_aux.cod_usuario
      BY usuar_mestre.cod_usuario:
  ```

---

### Q-002 — Listar Usuários Ativos por Empresa(s) Específica(s) no DataSul

* **Quando Usar**: Para obter usuários ativos vinculados a empresas específicas no modelo multi-empresa do Datasul. Ideal para auditorias de segurança segregadas por empresa ou relatórios de RH corporativos.
* **Saída**: CSV com `EMPRESA`, `LOGIN`, `NOME`, `EMAIL LOCAL`, `EMAIL CELULAR`, `LOG INATIVO`.
* **Tabelas**: `segur_empres_usuar` (filtro de empresa) + `usuar_mestre` (dados) + `usuar_mestre_aux` (status ativo)
* **Script**: [scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/listar_usuarios_por_empresa_ativos_datasul.p)
* **Lógica Principal**:
  ```progress
  FOR EACH segur_empres_usuar NO-LOCK
      WHERE segur_empres_usuar.cod_empresa = "2"
         OR segur_empres_usuar.cod_empresa = "5"
         OR segur_empres_usuar.cod_empresa = "6",
      FIRST usuar_mestre NO-LOCK
          WHERE usuar_mestre.cod_usuario = segur_empres_usuar.cod_usuario,
      FIRST usuar_mestre_aux NO-LOCK
          WHERE usuar_mestre_aux.cod_usuario = usuar_mestre.cod_usuario
            AND usuar_mestre_aux.log_inativ = NO
      BY segur_empres_usuar.cod_empresa
      BY usuar_mestre.cod_usuario:
  ```
* **Observações**: Para alterar as empresas filtradas, ajuste os valores de `cod_empresa` na cláusula `WHERE`.

---

### Q-003 — Usuários de um Grupo Específicos, Ativos, com Acesso a uma Empresa

* **Quando Usar**: Para verificar quais usuários de um Grupo do DataSul (ex: `MSP`) estão ativos e possuem acesso a uma empresa específica (ex: `"5"`). Consulta dinâmica — não requer hardcode de lista de logins.
* **Saída**: CSV com `EMPRESA`, `LOGIN`, `NOME`, `EMAIL LOCAL`, `EMAIL CELULAR`. Caminho definido em tempo de execução via diálogo (Produção ou Teste).
* **Tabelas**: `usuar_grp_usuar` + `usuar_mestre_aux` + `segur_empres_usuar` + `usuar_mestre`
* **Script**: [scripts/consultas/grupo_msp_ativos_empresa_5.p](file:///c:/Users/Dan13/OneDrive/Documentos/Projetos%20dev/Script%20Progress/scripts/consultas/grupo_msp_ativos_empresa_5.p)
* **Lógica Principal**:
  ```progress
  FOR EACH usuar_grp_usuar NO-LOCK
      WHERE usuar_grp_usuar.cod_grp_usuar = "MSP",
      FIRST usuar_mestre_aux NO-LOCK
          WHERE usuar_mestre_aux.cod_usuario = usuar_grp_usuar.cod_usuario
            AND usuar_mestre_aux.log_inativ  = NO,
      FIRST segur_empres_usuar NO-LOCK
          WHERE segur_empres_usuar.cod_usuario = usuar_grp_usuar.cod_usuario
            AND segur_empres_usuar.cod_empresa  = "5",
      FIRST usuar_mestre NO-LOCK
          WHERE usuar_mestre.cod_usuario = usuar_grp_usuar.cod_usuario
      BY usuar_mestre.cod_usuario:
  ```
* **Saída Produção**: `Z:\Gnaritas\temp\MSP_ATIVOS_EMPRESA_5.csv`
* **Saída Teste**: `V:\temp\MSP_ATIVOS_EMPRESA_5.csv`
* **Observações**: Para adaptar a outro grupo, altere `cod_grp_usuar = "MSP"`. Para outra empresa, altere `cod_empresa = "5"`.
