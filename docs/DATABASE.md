# DATABASE.md — Visão Geral do Banco de Dados TOTVS Datasul / OpenEdge

Este documento fornece a visão geral de arquitetura do banco de dados relacional Progress OpenEdge no contexto do ERP TOTVS Datasul.

---

## 🏢 1. Arquitetura do Banco Datasul

O ERP TOTVS Datasul utiliza uma estrutura de banco de dados distribuída por bancos de módulos e bancos de fundação/framework:

- **Bancos de Framework / Segurança (`emsfnd` / `emsdis`)**: Armazenam dados mestre de usuários, empresas, segurança, menus, relatórios e parâmetros globais.
- **Bancos de Negócio**: Divisão por área de negócio (ex: `emsfin` para Financeiro, `emsmov` para Movimentação de Estoque/Faturamento, `emscad` para Cadastros).

---

## 🏷️ 2. Nomenclaturas e Convenções de Campos

No banco de dados Datasul, a nomenclatura dos campos segue prefixos indicativos do tipo de dado:

| Prefixo | Significado | Tipo de Dado Progress ABL | Exemplo |
| :--- | :--- | :--- | :--- |
| `cod_` | Código / Identificador | Character / Integer | `cod_usuario`, `cod_empresa` |
| `nom_` | Nome / Razão Social | Character | `nom_usuario` |
| `des_` | Descrição | Character | `des_observacao` |
| `log_` | Campo Lógico (Booleano) | Logical (`YES`/`NO`) | `log_inativ` |
| `dat_` | Data | Date | `dat_implant` |
| `val_` | Valor monetário/numérico | Decimal | `val_tot_ped` |
| `qtd_` | Quantidade | Decimal / Integer | `qtd_item` |

---

## 🔗 3. Relacionamentos Fundamentais Catalogados

```mermaid
erdiagram
    segur_empres_usuar ||--|| usuar_mestre : "cod_usuario"
    usuar_mestre ||--|| usuar_mestre_aux : "cod_usuario"
```

- **`usuar_mestre.cod_usuario` = `usuar_mestre_aux.cod_usuario`**: Vínculo 1-para-1 entre o cadastro mestre e o controle de status do usuário.
- **`segur_empres_usuar.cod_usuario` = `usuar_mestre.cod_usuario`**: Vínculo N-para-1 indicando as empresas permitidas para cada usuário.

---

## 💡 4. Boas Práticas de Banco de Dados

1. **Sempre utilizar `NO-LOCK` em leituras**: Evita a alocação desnecessária de locks de registro na tabela de lock (`-L`) da instância do Progress OpenEdge.
2. **Utilizar índices correspondentes nas cláusulas `WHERE`**: Evita *table scans* inteiros em tabelas volumosas.
3. **Respeitar o isolamento por empresa (`cod_empresa`)**: Sempre que o contexto exigir segregação corporativa, filtrar pela empresa corrente.
