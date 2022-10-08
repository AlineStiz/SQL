#EXERCICIOS

use BD_Banco_view;

/*1. Selecione todos os registros da Conta Corrente substituindo as chaves estrangeiras (FK) pelo número da Agência e o nome do 
Cliente sucessivamente. Salve a consulta em uma Visão.*/
select * from conta_corrente;
select * from agencia;
select * from cliente;

create view rel_contas as 
select 
conta_corrente.cod_cc as codigo,
conta_corrente.numero_cc as numero_da_conta,
conta_corrente.dataAbertura_cc as data_da_abertura,
conta_corrente.saldo_cc as saldo,
conta_corrente.valorlimite_cc as limite_da_conta,
conta_corrente.saldocomlimite_cc as saldo_com_limite,
agencia.numero_ag as numero_da_agencia,
cliente.nome_cli as Nome_do_cliente
from
conta_corrente, agencia, cliente
where
(conta_corrente.cod_ag_fk = agencia.cod_ag) and
(conta_corrente.cod_cli_fk = cliente.cod_cli);

/*2. Selecione todos os registros da Transferência substituindo as FK de Conta Corrente por número e saldo da Conta, e mostre 
também os nomes dos Cliente de origem e destino. Salve a consulta em uma Visão.*/

select * from transferencia;
select * from conta_corrente;
select * from cliente;

create view rel_trans as 
select
transferencia.cod_trans as codigo,
transferencia.valor_trans as valor,
transferencia.data_trans as data,
transferencia.descricao_trans as descricao_da_operacao,
cli_o.nome_cli as nome_depositario,
cc_o.cod_cc as conta_depositario,
cli_d.nome_cli as nome_favorecido,
cc_d.cod_cc as conta_favorecida
from
transferencia inner join conta_corrente as cc_o on
(transferencia.cod_cc_origem_fk = cc_o.cod_cc) 
inner join 
conta_corrente as cc_d on
(transferencia.cod_cc_origem_fk = cc_d.cod_cc)
inner join 
cliente as cli_o on
(cc_o.cod_cli_fk = cli_o.cod_cli)
inner join
cliente as cli_d on
(cc_d.cod_cli_fk = cli_d.cod_cli);


/*3. Selecione todos os registros do Saque substituindo as FK de Conta Corrente por número e saldo da Conta, e mostre também o 
nome do Cliente. Salve a consulta em uma Visão.*/

select * from saque; 
select * from conta_corrente;

create view rel_saque as 
select
saque.cod_saq  as codigo,
saque.valor_saq as valor,
saque.data_saq as 'data',
saque.local_saq as 'local',
saque.hora_saq as horario,
conta_corrente.numero_cc as numero_da_conta,
conta_corrente.saldo_cc as saldo_em_conta,
cliente.nome_cli as cliente
from 
saque, conta_corrente, cliente
where
(saque.cod_cc_fk = conta_corrente.cod_cc) and
(conta_corrente.cod_cli_fk = cliente.cod_cli);

/*4. Selecione todos os registros do Depósito substituindo as FK de Conta Corrente por número e saldo da Conta, e mostre também 
o nome do Cliente. Salve a consulta em uma Visão.*/

select * from deposito;
select * from conta_corrente;
select * from cliente;

create view rel_dep as 
select
deposito.cod_dep  as codigo,
deposito.valor_dep as valor,
deposito.data_dep as data,
deposito.tipo_dep as forma_de_deposito,
conta_corrente.cod_cc as numero_da_conta,
conta_corrente.saldo_cc as saldo_em_conta,
cliente.nome_cli as cliente
from 
deposito, conta_corrente, cliente
where
(deposito.cod_cc_fk = conta_corrente.cod_cc) and
(conta_corrente.cod_cli_fk = cliente.cod_cli);

/*5. Selecione todos os registros do Pagamento substituindo as FK de Conta Corrente por número e saldo da Conta, e mostre também 
o nome do Cliente. Salve a consulta em uma Visão.*/

select * from pagamento;
select * from conta_corrente;

create view rel_pag as 
select
pagamento.cod_pag  as codigo,
pagamento.valor_pag as valor,
pagamento.data_pag as 'data',
pagamento.tipo_pag as forma_de_pagamento,
pagamento.dataVencimento_pag as data_de_vencimento,
pagamento.codigoBarras_pag as codigo_de_barra,
conta_corrente.cod_cc as numero_da_conta,
conta_corrente.saldo_cc as saldo_em_conta,
cliente.nome_cli as cliente
from 
pagamento, conta_corrente, cliente
where
(pagamento.cod_cc_fk = conta_corrente.cod_cc) and
(conta_corrente.cod_cli_fk = cliente.cod_cli);

/*6. Selecione o código e nome do Cliente, informando o nome do seu Banco. Salve a consulta em uma Visão.*/

select * from cliente;
select * from banco;

create view rel_cli_ban as 
select
cliente.cod_cli as codigo,
cliente.nome_cli as cliente,
banco.nome_ban as Banco
from 
cliente, conta_corrente, agencia, banco
where
(conta_corrente.cod_cli_fk = cliente.cod_cli) and 
(conta_corrente.cod_ag_fk = agencia.cod_ag) and
(agencia.cod_ban_fk = banco.cod_ban);


/*7. Selecione o nome do Banco, o número da Agência, o nome do Cliente, o número e o saldo da sua Conta Corrente. Salve a consulta em uma Visão.*/

select * from banco;
select * from agencia;
select * from cliente;
select * from conta_corrente;

create view rel_cli_ban_conta as 
select 
cliente.cod_cli as cod,
cliente.nome_cli as cliente,
banco.nome_ban as banco,
agencia.numero_ag as numero_da_agencia,
conta_corrente.saldo_cc as saldo_em_conta
from
banco, agencia, cliente, conta_corrente
where 
(conta_corrente.cod_cli_fk = cliente.cod_cli) and
(conta_corrente.cod_ag_fk = agencia.cod_ag) and 
(agencia.cod_ban_fk = banco.cod_ban);



/*8. Selecione o nome do Cliente, número da Conta Corrente, a soma, a média, o valor máximo, o valor mínimo e a quantidade de Saques 
realizados. Salve a consulta em uma Visão.*/

select * from saque;
select * from cliente;
select * from conta_corrente;

create view rel_cli_saq as 
select 
cliente.cod_cli as cod,
cliente.nome_cli as cliente,
conta_corrente.numero_cc as numero_da_conta,
(select sum(valor_saq) from saque where saque.cod_cc_fk = conta_corrente.cod_cc ) as Soma_dos_saques,
(select avg(valor_saq) from saque where saque.cod_cc_fk = conta_corrente.cod_cc ) as Media_dos_saques,
(select max(valor_saq) from saque where saque.cod_cc_fk = conta_corrente.cod_cc ) as valor_maximo_sacado,
(select min(valor_saq) from saque where saque.cod_cc_fk = conta_corrente.cod_cc ) as valor_minimo_sacado,
(select count(cod_saq) from saque where saque.cod_cc_fk = conta_corrente.cod_cc ) as quantidade_de_saques_realizados
from
cliente, conta_corrente
where 
(conta_corrente.cod_cli_fk = cliente.cod_cli);


/*9.  Selecione o nome do Cliente, número da Conta Corrente, a soma, a média, o valor máximo, o valor mínimo e a quantidade de 
Depósitos realizados. Salve a consulta em uma Visão.*/

select * from deposito;
select * from cliente;
select * from conta_corrente;

create view rel_cli_dep as 
select 
cliente.cod_cli as cod,
cliente.nome_cli as cliente,
conta_corrente.numero_cc as numero_da_conta,
(select sum(valor_dep) from deposito where conta_corrente.cod_cc = deposito.cod_cc_fk) as Soma_dos_depositos,
(select avg(valor_dep) from deposito where conta_corrente.cod_cc = deposito.cod_cc_fk) as Media_dos_depositos,
(select max(valor_dep) from deposito where conta_corrente.cod_cc = deposito.cod_cc_fk) as Maior_valor_depositado,
(select min(valor_dep) from deposito where conta_corrente.cod_cc = deposito.cod_cc_fk) as Valor_minimo_depositado,
(select count(cod_dep) from deposito where conta_corrente.cod_cc = deposito.cod_cc_fk) as Quantidade_de_depositos_realizados
from
cliente, conta_corrente
where 
(conta_corrente.cod_cli_fk = cliente.cod_cli);

/*10. Selecione o nome do Cliente, número da Conta Corrente, a soma, a média, o valor máximo, o valor mínimo e a quantidade de Pagamentos 
realizados. Salve a consulta em uma Visão.*/

select * from pagamento;
select * from cliente;
select * from conta_corrente;

create view rel_cli_pag as 
select 
cliente.cod_cli as cod,
cliente.nome_cli as cliente,
conta_corrente.numero_cc as numero_da_conta,
(select sum(valor_pag) from pagamento where pagamento.cod_cc_fk = conta_corrente.cod_cc ) as Soma_dos_depositos,
(select avg(valor_pag) from pagamento where pagamento.cod_cc_fk = conta_corrente.cod_cc ) as Media_dos_depositos,
(select max(valor_pag) from pagamento where pagamento.cod_cc_fk = conta_corrente.cod_cc ) as valor_maximo_desitado,
(select min(valor_pag) from pagamento where pagamento.cod_cc_fk = conta_corrente.cod_cc ) as valor_minimo_desitado,
(select count(valor_pag) from pagamento where pagamento.cod_cc_fk = conta_corrente.cod_cc ) as quantidade_de_depositos_realizados
from
cliente, conta_corrente
where 
(conta_corrente.cod_cli_fk = cliente.cod_cli);