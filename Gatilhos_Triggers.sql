use BD_Banco_Gatilhos_Charleston;

#Gatilhos

#######################################################################################################################
#Exericio 01

 delimiter $$
 create trigger positivarDeposito after insert on deposito for each row
 begin
 update conta_corrente set saldo_cc = saldo_cc + new.valor_dep where cod_cc = new.cod_cc_fk;
 end;
 $$ demiliter ;
 
 delimiter $$
 create procedure inserirDeposito (valor float, data date, tipo varchar(100), conta int)
 begin
 if (valor > 0) then 
	if (tipo = 'cheque') then
		if (valor <= 2000) then
			insert into deposito values(null, valor, data, tipo, conta);
            select 'O deposito em cheque foi realizado com sucesso !' as Confirmacao;
        else
			select'O valor do deposito em cheque não pode ser maior que 2.000,00 reais' as Alerta ;
		end if;
	else 
		if (tipo = 'Dinheiro') then
			if (valor <= 5000) then
				insert into deposito values(null, valor, data, tipo, conta);
				select 'O deposito em dinheiro foi realizado com sucesso !' as Confirmacao;
            else
				select'O valor do deposito em dinheiro não pode ser maior que 5.000,00 reais' as Alerta ;
			end if;
		else
			select'Só é possivel depositos em cheque ou dinheiro' as Alerta ;
		end if;
	end if;
    else
		select 'Não e possivel fazer depositos Zerados' as Alerta;
end if;
end;
 $$ delimiter ; 
 
 call inserirDeposito (5000, '2020-09-02', 'Dinheiro', 4);
 
 select * from conta_corrente;
 select * from deposito;

########################################################################################################################

# Exericio 02

 delimiter $$
 create trigger RetirarSaque after insert on saque for each row
 begin
 update conta_corrente set saldo_cc = saldo_cc - new.valor_saq where cod_cc = new.cod_cc_fk;
 end;
 $$ delimiter ;

drop trigger retirarsaque;

delimiter $$
create procedure Saque_conta (valor float, data date, local varchar(100), hora time, conta int)

begin
declare saldo float;
set saldo = (select saldo_cc from conta_corrente where cod_cc = conta );

if (valor <= saldo) then
	if (valor <= 3000) then 
		if ( hora > '06:01:00') and ( hora < '23:59:00') then
			insert into saque values (null, valor, data, local, hora, conta);
			select 'Saque relizado com sucesso !!!' as Corfirmacao;
		else    
			select 'Horario não permitido para saque !!!' as Alerta;
		end if;    
	else         
		select 'Saque não permitido, Valor deve ser inferior que 3.000,00 reais' as Alerta;
	end if;   
else			 
	select 'Saldo insulficiente' as Alerta;
end if;    
end;
$$ delimiter ; 

call Saque_conta  (3000, '2020-09-02', 'Caixa eletrônico', '08:00:00', 4);

drop procedure Saque_conta;
select * from saque;
select * from conta_corrente;

##########################################################################################################

# Tarefa 03

 delimiter $$
 create trigger fazerTransferencia after insert on transferencia for each row
 begin
 update conta_corrente set saldo_cc = saldo_cc + new.valor_trans where cod_cc = new.cod_cc_destino_fk;
 update conta_corrente set saldo_cc = saldo_cc - new.valor_trans where cod_cc = new.cod_cc_origem_fk;
 end;
 $$ delimiter ;
 

delimiter $$
create procedure transferencia_conta (valor float, data date, descricao varchar(500), cod_origem int, cod_destino int)

begin
declare saldo float;
set saldo = (select saldo_cc from conta_corrente where cod_cc = cod_origem );

if (valor <= saldo) then
	if (cod_origem <> cod_destino) then 
		insert into transferencia values (null, valor, data, descricao, cod_origem, cod_destino);
		select 'Transferência relizada com sucesso !!!' as Corfirmacao;
	else    
		select 'Transferêcia para mesma conta. ERRO!!!' as Alerta;
	end if;    
else         
	select 'Saldo insulficiente' as Alerta;
end if;    
end;
$$ delimiter ;

call  transferencia_conta (4000, '2020-09-02', 'Pagamento de salario', 4, 1);

drop procedure  transferencia_conta;
select * from transferencia;
select * from conta_corrente;

#####################################################################################

#Exericio 04

 delimiter $$
 create trigger debitar_pagamento after insert on pagamento for each row
 begin
 update conta_corrente set saldo_cc = saldo_cc - new.valor_pag where cod_cc = new.cod_cc_fk;
 end;
 $$ delimiter ;

drop trigger  debitar_pagamento;

delimiter $$
create procedure fazer_Pagamento (valor float, data date, tipo varchar(100), hora time, data_vencimento date, codigo_barra varchar(10), conta int)

begin
declare saldo float;
set saldo = (select saldo_cc from conta_corrente where cod_cc = conta );

if (valor <= saldo) then
	if ( hora > '06:00:00') and ( hora < '24:00:00') then
		if (character_length(codigo_barra) = 10 ) then
			insert into pagamento values (null, valor, data, tipo, hora, data_vencimento, codigo_barra, conta);
			select 'Pagamento relizado com sucesso !!!' as Corfirmacao;
		else    
			select 'Codigo de barras não conferi !!!' as Alerta;
		end if;    
	else         
		select 'Horario permitido para pamentos de 6h as 24h' as Alerta;
	end if;   
else			 
	select 'Saldo insulficiente' as Alerta;
end if;    
end;
$$ delimiter ; 

call fazer_Pagamento(3000, '2020-09-02', 'PAGAMENTO CARRO', '08:00:00', '2021-09-20', '1234567890', 2);

drop procedure fazer_Pagamento;
select * from pagamento;
select * from conta_corrente;

