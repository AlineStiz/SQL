use bd_mecanica5;

/*Selecione o código, nome, cpf, nome do Sexo, dados do Endereço, nome da Cidade e nome do Estado dos Clientes.*/
select * from sexo;
select * from cliente;
select * from endereco;
select * from cidade;


select
cliente.cod_cli as 'Código', 
cliente.nome_cli as 'Nome' , 
cliente.cpf_cli as 'CPF',  
sexo.nome_sex as 'Sexo', 
endereco.rua_end  as 'Rua', 
endereco.bairro_end as 'Bairro',
cidade.nome_cid as 'Cidade',
estado.sigla_est as 'Estado'
from 
cliente, sexo, endereco, cidade, estado
where
(cliente.cod_sex_fk = sexo.cod_sex) and
(cliente.cod_end_fk = endereco.cod_end) and
(endereco.cod_cid_fk = cidade.cod_cid) and
(cidade.cod_est_fk = estado.cod_est);

/*Selecione o código, nome, cpf, função, nome do Sexo, dados do Endereço, nome da Cidade, nome do Estado e nome do Departamento dos Funcionários.*/
select * from funcionario;
select * from sexo;
select * from endereco;
select * from cidade;
select * from departamento;

select
funcionario.nome_func as 'Nome do colaborador', 
funcionario.cpf_func as 'CPF' , 
funcionario.função_func as 'Cargo',  
sexo.nome_sex as 'Sexo', 
endereco.rua_end  as 'Rua', 
endereco.bairro_end as 'Bairro',
cidade.nome_cid as 'Cidade',
estado.sigla_est as 'Estado',
departamento.nome_dep as 'Departamento'
from 
funcionario, sexo, endereco, cidade, estado, departamento
where
(funcionario.cod_sex_fk = sexo.cod_sex) and
(funcionario.cod_end_fk = endereco.cod_end) and
(endereco.cod_cid_fk = cidade.cod_cid) and
(cidade.cod_est_fk = estado.cod_est) and
(funcionario.cod_dep_fk = departamento.cod_dep);

/*Selecione o nome do Cliente e os dados dos seus Carros.*/
select * from cliente;
select * from carro;

select
cliente.nome_cli as 'Nome do cliente', 
carro.modelo_car as 'Modelo do veículo' , 
carro.cor_car as 'Cor',  
carro.placa_car as 'Placa', 
carro.marcar_car  as 'Marca'

from 
cliente, carro
where
(carro.cod_cli_fk = cliente.cod_cli);

/*Selecione código e data da Compra, nome do Fornecedor e os nomes, quantidade e valor dos Produtos comprados.*/
select * from compra;
select * from fornecedor;
select * from itens_compra;
select * from produto;

select
compra.cod_comp as 'Código', 
compra.data_comp as 'Data da compra' , 
fornecedor.nomefantasial_forn as 'Fornecedor',  
produto.descrição_prod as 'Peça', 
itens_compra.quant_itenc as 'Quatidade comprada', 
itens_compra.valor_itenc as 'Valor unitario'
from 
compra, fornecedor, produto, itens_compra
where
(compra.cod_forn_fk = fornecedor.cod_forn) and
(itens_compra.cod_comp_fk = compra.cod_comp) and
(itens_compra.cod_prod_fk = produto.cod_prod) ;

/*Selecione o código e data da Venda, nome do Cliente e os nomes, quantidade e valor dos Produtos vendidos.*/
select * from venda;
select * from cliente;
select * from itens_venda;
select * from produto;

select
venda.cod_vend as 'Código', 
venda.data_vend as 'Data da venda' , 
cliente.nome_cli as 'Cliente',  
produto.descrição_prod as 'Peça', 
itens_venda.quant_itenv as 'Quatidade vendida', 
itens_venda.valor_itenv as 'Valor unitario'
from 
venda, cliente, produto, itens_venda
where
(venda.cod_cli_fk = cliente.cod_cli) and
(itens_venda.cod_prod_fk = produto.cod_prod) and
(itens_venda.cod_vend_fk = venda.cod_vend) ;

/*Selecione o código, a data, o valor e a forma de pagamento dos Pagamentos, o código e data do Caixa, o nome do 
Funcionário e a descrição, data de vencimento e o valor da Despesa. */
select * from pagamentos;
select * from caixa;
select * from funcionario;
select * from despesas;

select
pagamentos.cod_pag as 'Código do pagamento', 
pagamentos.data_pag as 'Data do pagamento' , 
pagamentos.valor_pag as 'Valor pago',  
pagamentos.formapagamento_pag as 'Forma do pagamento', 
caixa.cod_cai as 'Código do caixa', 
caixa.dataabertura_cai as 'Data abertura do caixa',
caixa.datafechamento_cai as 'Data fechameto do caixa',
funcionario.nome_func as 'Nome colaborador',
despesas.descrição_desp as 'Conta',
despesas.datavencimento_desp as 'Data vencimento da despesa',
despesas.valor_desp as 'Valor da despesa'
from 
pagamentos, caixa, funcionario, despesas
where
(pagamentos.cod_cai_fk = caixa.cod_cai) and
(pagamentos.cod_func_fk = funcionario.cod_func) and
(pagamentos.cod_desp_fk = despesas.cod_desp) 
;

/*Selecione o código e o nome do Fornecedor, assim como a quantidade e a soma do valor total das Compras que ele participou. 
Dica: Use subconsulta com funções.*/
select * from compra;
select * from fornecedor;

select
fornecedor.cod_forn as 'Código',
fornecedor.nomefantasial_forn as 'Nome do fornecedor',
(select count(cod_comp) from compra where fornecedor.cod_end_fk = compra.cod_comp) as 'Quantidade'
from 
fornecedor;

/*Secione o código e nome do Cliente, assim como o valor médio e a soma do valor total das Vendas que ele participou.
 Dica: Use subconsulta com funções.*/
select * from cliente;
select * from venda;

select
cliente.cod_cli as 'Código',
cliente.nome_cli as 'Nome do cliente',
(select avg(valortotal_vend) from venda where venda.cod_cli_fk = cliente.cod_cli) as 'Media de compras',
(select sum(valortotal_vend) from venda where venda.cod_cli_fk = cliente.cod_cli) as 'Soma de compras'
from 
cliente;
 
/*Selecione o código, a data e a forma de pagamento da Venda, o nome do Cliente, assim como a quantidade e a soma do valor total dos
Itens Vendidos em cada Venda.  Dica: Use subconsulta com funções.*/
select * from cliente;
select * from venda;
select * from itens_venda;
select * from produto;

select
venda.cod_vend as 'Código',
venda.data_vend as 'Data venda',
venda.formpag_vend as 'forma de pagamento',
cliente.nome_cli as 'Nome cliente',
(select count(quant_itenv) from itens_venda where itens_venda.cod_vend_fk = venda.cod_vend) as 'Quantidade',
(select sum(valor_itenv) from itens_venda where itens_venda.cod_vend_fk = venda.cod_vend) as 'Soma itens vendidos'
from 
venda, cliente
where
(venda.cod_cli_fk = cliente.cod_cli);

/*Selecione o nome do Funcionário, assim como a quantidade e a soma do valor total das Vendas realizadas por cada vendedor. 
Dica: Use subconsulta com funções.
*/

select nome_func , valortotal_vend from funcionario, venda where venda.cod_func_fk = funcionario.cod_func;
select * from venda;

select
funcionario.nome_func as 'Nome funcionario',
(select count(cod_vend) from venda where venda.cod_func_fk = funcionario.cod_func) as 'Quantidade de venda',
(select sum(valortotal_vend) from venda where venda.cod_func_fk = funcionario.cod_func) as 'Soma do valor vendido'
from 
funcionario;