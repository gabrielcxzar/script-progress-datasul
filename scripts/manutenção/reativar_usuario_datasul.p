/*
======================================================================
OBJETIVO: Reativar usuário inativo no ERP TOTVS Datasul.
CATEGORIA: manutenção / segurança / usuários
TABELAS: usuar_mestre, usuar_mestre_aux
======================================================================
DESCRICAO:
Este script solicita interativamente o código do usuário (cod_usuario)
e permite alterar os campos de status de inativação e validade de acesso:
  - usuar_mestre_aux.log_inativ (LOGICAL: NO = Ativo, YES = Inativo)
  - usuar_mestre.dat_fim_valid   (DATE: Data limite de validade do usuário)
======================================================================
*/

// REATIVAR USUÁRIO DATASUL

Prompt-for usuar_mestre.cod_usuario
  With Frame f.

Find usuar_mestre
    Where usuar_mestre.cod_usuario = Input Frame f usuar_mestre.cod_usuario.

Find usuar_mestre_aux
     Where usuar_mestre_aux.cod_usuario = Input Frame f usuar_mestre.cod_usuario.

Update usuar_mestre_aux.log_inativ
       usuar_mestre.dat_fim_valid
       With 1 Column Frame f2.
