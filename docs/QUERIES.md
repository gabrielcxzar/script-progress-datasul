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

---

## 🏭 Domínio: Manufatura / Produção (PCP)

### Q-004 — Consultar Ordens de Produção Abertas/Planejadas por Estabelecimento

* **Quando Usar**: Para obter a listagem de Ordens de Produção em aberto (Não Planejadas, Planejadas, Liberadas, Iniciadas) por estabelecimento, incluindo dados do produto e quantidades.
* **Saída**: Padrão de dados para relatórios ou exportação CSV.
* **Tabelas**: `ord-prod` + `item` + `estabelec`
* **Lógica Principal**:
  ```progress
  FOR EACH ord-prod NO-LOCK
      WHERE ord-prod.cod-estabel = "101"
        AND (ord-prod.estado = 2 OR ord-prod.estado = 3 OR ord-prod.estado = 4),
      FIRST item NO-LOCK
          WHERE item.it-codigo = ord-prod.it-codigo
      BY ord-prod.dt-inicio:

      /* Exibe/Exporta: ord-prod.nr-ord-produ, item.it-codigo, item.descricao,
         ord-prod.qt-planejada, ord-prod.qt-produzida, ord-prod.estado */
  END.
  ```
* **Observações**: Estados comuns de `ord-prod`: 1=Não Planejada, 2=Planejada, 3=Liberada, 4=Iniciada, 5=Finalizada, 6=Terminada.

---

## 📦 Domínio: Estoque e Materiais

### Q-005 — Consultar Saldo Físico e Alocado por Item e Depósito

* **Quando Usar**: Para consultar a posição atualizada de estoque (saldo físico `qtidade-atu` e quantidade alocada `qt-alocada`) por item, estabelecimento e depósito.
* **Saída**: Extrato sintético de estoque físico e saldo disponível (`qtidade-atu - qt-alocada`).
* **Tabelas**: `saldo-estoq` + `item` + `deposito`
* **Lógica Principal**:
  ```progress
  FOR EACH saldo-estoq NO-LOCK
      WHERE saldo-estoq.cod-estabel = "101"
        AND saldo-estoq.cod-depos   = "ALM",
      FIRST item NO-LOCK
          WHERE item.it-codigo = saldo-estoq.it-codigo,
      FIRST deposito NO-LOCK
          WHERE deposito.cod-depos = saldo-estoq.cod-depos
      BY saldo-estoq.it-codigo:

      /* Saldo disponível calculável: saldo-estoq.qtidade-atu - saldo-estoq.qt-alocada */
  END.
  ```

---

### Q-006 — Historico de Movimentações de Estoque por Período

* **Quando Usar**: Para rastrear o histórico detalhado de movimentações de estoque (entradas, saídas, requisições, transferências) em um determinado período.
* **Saída**: Relatório analítico de movimentações com data, espécie de documento, depósito e quantidade.
* **Tabelas**: `movto-estoq` + `item`
* **Lógica Principal**:
  ```progress
  FOR EACH movto-estoq NO-LOCK
      WHERE movto-estoq.cod-estabel = "101"
        AND movto-estoq.dt-trans    >= 2026-01-01
        AND movto-estoq.dt-trans    <= 2026-07-31,
      FIRST item NO-LOCK
          WHERE item.it-codigo = movto-estoq.it-codigo
      BY movto-estoq.dt-trans
      BY movto-estoq.it-codigo:

      /* Exibe/Exporta: movto-estoq.dt-trans, movto-estoq.esp-doc, item.it-codigo,
         movto-estoq.cod-depos, movto-estoq.quantidade */
  END.
  ```

---

## 🏪 Domínio: Vendas e Faturamento

### Q-007 — Pedidos de Venda Abertos com Itens e Dados do Cliente

* **Quando Usar**: Para exportar a carteira de pedidos de venda em aberto (Situação = 1 ou 2) vinculados ao cliente (emitente) e seus respectivos itens.
* **Saída**: Relatório de carteira de vendas com pedido, cliente, item, quantidade pedida/atendida e valor unitário.
* **Tabelas**: `ped-venda` + `ped-item` + `emitente` + `item`
* **Lógica Principal**:
  ```progress
  FOR EACH ped-venda NO-LOCK
      WHERE ped-venda.cod-estabel = "101"
        AND (ped-venda.cod-sit-ped = 1 OR ped-venda.cod-sit-ped = 2),
      FIRST emitente NO-LOCK
          WHERE emitente.cod-emitente = ped-venda.cod-emitente,
      FOR EACH ped-item OF ped-venda NO-LOCK
          WHERE ped-item.cod-sit-item = 1,
          FIRST item NO-LOCK
              WHERE item.it-codigo = ped-item.it-codigo
      BY ped-venda.nr-pedido
      BY ped-item.nr-sequencia:

      /* Exibe/Exporta: ped-venda.nr-pedido, emitente.nome-abrev, item.it-codigo,
         ped-item.qt-pedida, ped-item.qt-atendida, ped-item.vl-preuni */
  END.
  ```

