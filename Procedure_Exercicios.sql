/*Exercícios para Praticar
Utilize o Script BD_Hotel*/
use bd_hotel;

/*1.Crie um procedimento para obter a lista de produtos disponíveis no hotel
com o estoque maior do que um número recebido no parâmetro de
entrada*/
select * from produto;

delimiter $$
create procedure produtos_disponíveis_hotel (quant int)
	begin
		select * from produto where quantidade_prod > quant;
	end ;
$$ delimiter ;

call produtos_disponíveis_hotel (1);

/*2.Crie um procedimento com passagem de parâmetros de entrada para
cadastrar um novo Produto */
select * from produto;
INSERT INTO produto (cod_prod, descrição_prod, quantidade_prod, valor_prod, dataValidade_prod) 
VALUES (5, 'Pão de forma', 60, 10.0, '2021-02-25');

delimiter $$
create procedure inserir_produtos_hotel (nome varchar(100), quant int, valor double, data_pro date)
	begin
		INSERT INTO produto values(null, nome, quant, valor, data_pro); 
		select 'Produtos cadastrados com sucesso!!!' as confirmação;
	end ;
$$ delimiter ;

call inserir_produtos_hotel ('Coca-cola', 10, 8.5, '2022-01-02');

/*3.Crie um procedimento que retorne por uma variável de saída o número
total de clientes cadastrados no sistema do hotel*/

select * from cliente;
drop procedure total_clientes_hotel;

# quando Atribuido um valor em varivel local (aqui= total),# 
#utilizamos uma variavel global para fazer a chamada (nesse casso = @resultado)#

delimiter $$
create procedure total_clientes_hotel ( out total int)
	begin
		select 
        count(cod_cli) into total from cliente ;
	end; 
$$ delimiter ;

call total_clientes_hotel(@resultado);
select @resultado; 

/*4.Crie um procedimento que atualize para mais o valor dos produtos no
estoque em X X é o parâmetro de entrada)*/

select * from produto; 
update produto set valor_prod = valor_prod + (valor_prod *(10/100));

delimiter $$
create procedure atualiza_valor_produto (X float)
	begin
	update produto set valor_prod = valor_prod + (valor_prod *(X/100));	
    select 'Produto atualizados com sucesso !' as Confirmação;    
	end; 
$$ delimiter ;

call atualiza_valor_produto(50);
select * from produto;

/*5.Crie um procedimento para somar o valor do consumo e o valor da diária
e atribuir ao valor total da hospedagem, receba a hospedagem como
parâmetro de entrada*/

select * from hospedagem; 
select valorConsumo_hosp, ValorDiárias_hosp from hospedagem; 
update hospedagem set valortotal_hosp = valorConsumo_hosp + ValorDiárias_hosp where cod_hosp= 1;  

delimiter $$
create procedure atualiza_valor_total_hosp (Hospedagem int)
	begin
	update hospedagem set valortotal_hosp = valorConsumo_hosp + ValorDiárias_hosp where cod_hosp= Hospedagem;	
    select 'Hospedagem atualizada com sucesso !' as Confirmação;    
	end; 
$$ delimiter ;

call atualiza_valor_total_hosp(2);
select * from hospedagem;

/*Exercício I
Crie um procedimento que se comporte como uma calculadora . Você
deverá receber 02 números como parâmetros de entrada . Também
deverá receber um parâmetro de entrada que informe o tipo da
operação (+, --, /,
Faça estruturas IF para calcular os 02 números de acordo com a operação (símbolo) informado pelo usuário;
Retorne o resultado em uma mensagem de retorno;*/

delimiter $$
create procedure calculadora ( num1 float, sinal varchar(10), num2 float)
begin
declare resultado float;

if (sinal = '+') then
	set resultado = num1 + num2;
    select concat('O resultado da soma é: ', resultado) as Soma;
else
		if (sinal = "-") then
			SET resultado = num1 - num2;
            select concat('O resultado da subtração é: ', resultado) as Subtração;
		else
			if (sinal = '*') then
				set resultado = num1 * num2;
                select concat('O resultado da multiplicação é: ', resultado) as Multiplicação;
			else
				if (sinal = '/') then
					set resultado = num1 / num2;
                    select concat('O resultado da divisão é: ', resultado) as Divisão;
				else	
					select 'Digite um sinal válido:  ou + ou - ou * ou /' as Aleta ;
				end if;
            end if;    
        end if;     
end if;
end;
$$ delimiter ;

drop procedure  calculadora ;
call calculadora(50, '/', 50);
  
  
                /*Exercício II
Crie um procedimento para informar a classificação de cada cliente utilizando as seguintes verificações Ifs
Caso a soma das hospedagens realizadas pelo cliente seja maior que R 1000 sua categoria é cliente VIP
Caso seja entre R 500 e 1000 sua categoria é cliente NORMAL
caso seja menor que R 500 sua categoria é POPULAR
O código do cliente deve ser passado como parâmetro de entrada
Na mensagem de retorno deve ser informado o nome do cliente e o seus status na classificação*/

delimiter $$
create procedure classificar_cliente (codigo_cli int) 
begin
declare soma float;
declare nome varchar(100);

set soma= (select sum(valorconsumo_hosp + valordiárias_hosp) from hospedagem where
	cod_cli = codigo_cli);
set nome = (select nome_cli from cliente where cod_cli = codigo_cli);

if (soma > 1000) then
	select concat('O cliente ' , nome , ' é VIP') AS Classificação;
else
	if (soma between 500 and 1000) then
	select concat('O cliente ' , nome , ' é NORMAL') AS Classificação;
	else
		select concat('O cliente ' , nome , ' é POPULAR') AS Classificação;
	end if;
end if;
end;
$$ delimiter ;    

drop procedure classificar_cliente;
select * from hospedagem; 
call classificar_cliente (1);

/* Exercício III
Crie um procedimento que reajuste o preço dos produtos em estoque
Você deve receber como parâmetro de entrada a porcentagem a ser
reajustada e uma variável que informe se o reajuste é para aumentar
ou diminuir o preço Faça as seguintes verificações
Se o reajuste for para aumentar não permita que seja maior do 50
Se o reajuste for para diminuir não permita que seja maior do 20
Retorno mensagens de retorno cada a atualização aconteça ou não de acordo com a condição*/

delimiter $$
create procedure reajuste_preco( verifica varchar(1), porcetagem float) 
begin

if (verifica = '+') and (porcetagem between 0 and 50.0 ) then
	update produto set valor_prod = valor_prod + (valor_prod *( porcetagem/100));	
	select concat('O Produto teve acrescimo de: ', porcetagem,'%' ) as Confirmação;    
else
	if (verifica = '-') and (porcetagem between 0 and 20.0) then
		update produto set valor_prod = valor_prod - (valor_prod *( porcetagem/100));	
		select concat('O Produto teve desconto de: ', porcetagem,'%' ) as Confirmação;    
	else
		select concat('Digite uma porcetagem validada para o operador  - (entre 0 e 20%) ou + (entre 0 e 50%)' ) as Confirmação;    
	end if;
end if;
end;
$$ delimiter ;    

drop procedure reajuste_preco;
select * from produto; 
call reajuste_preco ('+',50);
