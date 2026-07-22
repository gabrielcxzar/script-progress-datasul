# EMAILS.md — Catálogo de Programas de Envio de E-mail

Este documento cataloga todos os programas específicos que realizam **envio de e-mails** e notificações automatizadas no ERP TOTVS Datasul.

---

## 🔧 Mecanismos de Envio no Progress OpenEdge / Datasul

No ecossistema Progress ABL / Datasul, os envios de e-mail identificados utilizam majoritariamente 3 abordagens:

### 1. Chamada à API Padrão Datasul (`utp/ut-mail.p` / `utp/ut-email.p`)
Mecanismo nativo do Datasul para envio via servidor SMTP configurado nas preferências globais.
```progress
/* Padrão de chamada utp/ut-mail.p */
RUN utp/ut-mail.p (
    INPUT "remetente@empresa.com.br",    /* De */
    INPUT "destino@empresa.com.br",      /* Para */
    INPUT "Assunto da Mensagem",          /* Assunto */
    INPUT "V:\temp\corpo_mensagem.txt",  /* Arquivo do Corpo / Texto */
    INPUT "V:\temp\anexo.pdf"            /* Arquivo Anexo (ou "") */
).
```

### 2. Envio com Corpo em HTML (`pi-envia-email-html`)
Formatação de e-mails corporativos com tabelas, cores e relatórios inline.
```progress
ASSIGN c-corpo = "<html><body>"
               + "<h2>Aviso de Alteração de Processo</h2>"
               + "<table border='1'><tr><th>OP</th><th>Item</th></tr>"
               + "<tr><td>" + STRING(ord-prod.nr-ord-produ) + "</td><td>" + item.it-codigo + "</td></tr></table>"
               + "</body></html>".

/* Salva em arquivo temporário e envia com flag HTML */
RUN pi-envia-email-html (INPUT c-destino, INPUT c-assunto, INPUT c-corpo, INPUT c-anexo).
```

### 3. Comunicação via Socket SMTP Direct (`ccp/atpmailsock.p`)
Comunicação direta por sockets TCP/IP com o servidor de e-mail (usado em utilitários de baixo nível).
```progress
RUN ccp/atpmailsock.p (
    INPUT c-server-smtp,
    INPUT c-from,
    INPUT c-to,
    INPUT c-subject,
    INPUT c-body
).
```

---

## 📋 Programas Catalogados por Domínio (Total: 84)

---

### 1. 🤖 Automação de Processos & Ficha de Produção (`Automacao/`)

Programas responsáveis por monitorar a qualidade, fichas técnicas, formulários e status de ensacamento, enviando alertas por e-mail a engenheiros e operadores.

| Módulo / Subpasta | Programa | Tipo | Ação / Evento de E-mail |
| :--- | :--- | :--- | :--- |
| `Automacao/aut/` | `esau0003e.w` | UI (`.w`) | `pi-email-situacao-formulacao` — Notifica alteração na situação da formulação |
| `Automacao/aut/` | `esau0006f.w` | UI (`.w`) | `pi-email-situacao-processo` — Notifica mudança de status do processo produtivo |
| `Automacao/aut/` | `ESAU0012.W` | UI (`.w`) | `pi-envia-email` — Alerta geral de formulários de automação |
| `Automacao/aut/` | `esau0015a.w` | UI (`.w`) | `pi-envia-email` — Notifica aprovação/rejeição de lote |
| `Automacao/aut/` | `ESAU0016.W` | UI (`.w`) | `pi-envia-email` — Disparo de alertas de parâmetros fora de especificação |
| `Automacao/aut/` | `esau0020rp.p` | Batch (`.p`) | `pi-envia-email` — Relatório batch de divergências de processo enviado por e-mail |
| `Automacao/aut/` | `ESAU0023.W` | UI (`.w`) | `pi-email-criticidade` — Alerta imediato de itens de alta criticidade |
| `Automacao/aut/` | `ESAU0026_avaliar.W` | UI (`.w`) | `pi-envia-email` — E-mail de avaliação técnica de parâmetros |
| `Automacao/aut/` | `esau0044.w` | UI (`.w`) | `pi-envia-email` — Notificação de alteração de mapa de ensacamento |
| `Automacao/aut/` | `ESAU0051.W` | UI (`.w`) | `pi-email-status-formulacao` — Atualização de status da fórmula |
| `Automacao/aut/` | `esau0062rp.p` | Batch (`.p`) | `pi-envia-email` — Relatório periódico de qualidade enviado aos supervisores |
| `Automacao/aut/` | `esau5102.w` | UI (`.w`) | `pi-envia-email-html` — Envio de relatório em formato HTML estilizado |
| `Automacao/aut/` | `esau5202rp.p` | Batch (`.p`) | `pi-envia-email-html` — Envio batch HTML de relatórios de produção |
| `Automacao/aubrw/` | `b01au5012.w` | Browser (`.w`) | `pi-envia-email` — Envio disparado diretamente de grid de automação |
| `Automacao/auvwr/` | `v02au0019.w` | Viewer (`.w`) | `pi-email-devol` / `pi-email-teste` — Notificação de devolução de testes |

---

### 2. ⚡ Triggers Automáticas de Banco (`p/trigger/`)

Triggers de tabela que disparam e-mails automáticos quando ocorrem alterações em dados críticos do ERP.

| Tabela Relacionada | Programa Trigger | Evento / Gatilho |
| :--- | :--- | :--- |
| `twdoc-pend-aprov` | `twdoc-pend-aprov.p` | Dispara e-mail de pendência para aprovadores quando surge documento pendente |
| `twsolic-serv` | `twsolic-serv.p` | Envia confirmação por e-mail ao solicitante na criação de Solicitação de Serviço |
| `tditem-cli` | `tditem-cli.p` | Notifica equipe comercial ao alterar itens específicos do cliente |
| `tdp-ped-item` / `twp-ped-item` | `tdp-ped-item.p` | Envia e-mail para grupo responsável ao alterar item em Pedido de Venda |
| `tw-ord-manut` | `tw-ord-manut.p` | Dispara alerta por e-mail para a equipe de manutenção na emissão da Ordem |

---

### 3. 🛠️ Pontos de Entrada / UPCs (`p/upc/`)

Extensões do padrão Datasul que adicionam envios de e-mail aos programas originais da TOTVS.

| Programa UPC | Programa Padrão Datasul | Função do E-mail |
| :--- | :--- | :--- |
| `upc/re1005rp-u01.p` | `RE1005RP` (Recebimento Fiscal) | Envia relatório HTML de divergências de recebimento de Nota Fiscal |
| `upc/upc-bodi159com-mso.p` | `BODI159COM` (Planejamento) | Dispara e-mail para a equipe de Planejamento de Materiais |
| `upc/upc-qo0310e.p` | `QO0310E` (Laudos de Qualidade) | Gera PDF do laudo do cliente e envia em anexo via e-mail HTML |

---

### 4. 🛒 Supply Chain & Compras (`p/supplychain/` & `supplychain/`)

Programas envolvidos na cotação, negociação e aprovação de ordens e processos de compras.

| Subpasta | Programa | Descrição da Ação |
| :--- | :--- | :--- |
| `p/supplychain/esp/` | `esco-proc-comp.p` | Envia e-mail aos fornecedores no processo de compra |
| `p/supplychain/esp/` | `esco-proc-comp-mso.p` | Notificação de processo de compras MSO |
| `p/supplychain/esp/` | `esco0009rp.p` | `pi-grupo-e-mail` — Envia relatório de pedidos de compras pendentes |
| `supplychain/esp/` | `esco6009rp.p` | Versão estendida do relatório de compras com disparo por grupo de e-mail |

---

### 5. 💰 Financeiro & Faturamento (`esp/`, `apb/`, `ftp/`)

Notificações fiscais, faturamento e contas a pagar.

| Subpasta | Programa | Descrição da Ação |
| :--- | :--- | :--- |
| `apb/` | `esapb003aa.w` | `pi_Env_eMail` — Envio de aviso de pagamento a fornecedores |
| `ftp/` | `FT0518RP.P` | `pi-envia-e-mail` — Envio de espelho de Nota Fiscal e DANFE por e-mail |
| `esp/` | `esft0018rp.p` | Relatório de notas fiscais com envio por e-mail ao cliente |
| `esp/` | `escmg0001rp.p` | `piEnviaEmail` — Alerta de movimentações financeiras de caixa |
| `esp/` | `escd0033rp.p` | Envio de relatórios fiscais formatados em HTML |

---

### 6. 🔬 Qualidade & Estimativas (`esp/`, `estimativa/`)

Programas de controle de qualidade e estimativas comerciais.

| Subpasta | Programa | Descrição da Ação |
| :--- | :--- | :--- |
| `esp/` | `app-aprova.w` / `app-reprova.w` | `pi-cria-envia-e-mail-int` — E-mail de aprovação/rejeição de laudo |
| `esp/` | `esqo0603rp.p` | Relatório de não-conformidades de qualidade enviado aos gestores |
| `estimativa/` | `espd0018-v02.w` | Envio de estimativa de vendas por e-mail para o cliente |
| `estimativa/` | `espd5010-v02.w` | Envio de proposta comercial e estimativa técnica |

---

### 7. 🔗 Fluig & Integrações (`fluig/`)

| Subpasta | Programa | Descrição da Ação |
| :--- | :--- | :--- |
| `fluig/` | `gtfluigtabpreco.p` | `enviarEmail` — Consulta o e-mail do colaborador no Datasul e dispara notificação de alteração da tabela de preços no Fluig |

---

## 📌 Boas Práticas Mapeadas para Scripts de E-mail

1. **Validação de Destinatário**: Sempre verificar se o e-mail não está vazio (`IF c-email <> "" AND c-email <> ?`).
2. **Uso de Arquivos Temporários**: O corpo da mensagem deve ser escrito em um arquivo texto temporário em `V:\temp\` ou `Z:\Gnaritas\temp\` antes de passar como parâmetro para `ut-mail.p`.
3. **Limpeza de Artefatos**: Deletar o arquivo temporário do corpo após o retorno da procedure `ut-mail.p`.
