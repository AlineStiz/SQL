#Script BD_AgenciaBancaria - Versão 4.0 - Atividade 01 - 3ª Etapa
#SEU NOME: Charleston Ribeiro dos Passos

create database BD_Banco_Gatilhos_Charleston;
use BD_Banco_Gatilhos_Charleston;
	
create table Banco (
cod_ban int primary key not null auto_increment,
nome_ban varchar (200) not null
);

insert into Banco values (null, 'Caixa Econômica Federal');
insert into Banco values (null, 'Banco do Brasil');


create table Agencia (
cod_ag int primary key not null auto_increment,
numero_ag varchar (100) not null,
nome_ag varchar (100),
telefone_ag varchar (200),
cod_ban_fk int not null,
foreign key (cod_ban_fk) references Banco (cod_ban)
);

insert into Agencia values (null, '0951-2', 'Centro', '69 3421 1111', 2);
insert into Agencia values (null, '4402-1', 'Centro', '69 3422 2299', 2);
insert into Agencia values (null, '1824', 'Centro', '69 3423 1925', 1);
insert into Agencia values (null, '1920', 'Nova Brasilia', '69 3421 1122', 1);


create table Cliente (
cod_cli int primary key not null auto_increment,
nome_cli varchar (200) not null,
cpf_cli varchar (50) not null,
rg_cli varchar (100) not null,
sexo_cli varchar (1),
dataNasc_cli date not null,
renda_cli float not null,
endereco_cli varchar (300) not null,
email_cli varchar (300) not null,
telefone_cli varchar (200) not null
);

insert into Cliente values (null, 'Maria da Silva', '123.123.123-23', '1113322 sesdec/RO', 'F', '1990-10-10', 2500.00, 'Rua das Flores', 'maria.silva@hotmail.com', '3423 3333'); 
insert into Cliente values (null, 'Roberto Carlos', '789.789.789-89', '889977 sesdec/RO', 'M', '1975-01-10', 4990.00, 'Av. Costa', 'roberto.carlos@gmail.com', '8444 8899'); 
insert into Cliente values (null, 'Jane Pereira', '444.666.444-44', '005548 sesdec/RO', 'F', '1989-06-07', 1850.50, 'Rua Presidente', 'jane.pereira@hotmail.com', '9977 8899'); 
insert into Cliente values (null, 'Clodoaldo Bragança', '654.456.654-65', '654658 sesdec/RO', 'F', '1991-10-12', 9850.50, 'Av. Brasil', 'clodoaldo.bragança@gmail.com', '3423 5500'); 
insert into Cliente values (null, 'Livia de Souza', '333.444.666-98', '0033333 sesdec/RO', 'F', '1982-01-30', 1100.00, 'Av. Ji-Parana', 'livia.souza@hotmail.com', '8498 9898'); 
insert into Cliente values (null, 'Joab da Silva', '159.425.456-77', '001215 sesdec/RO', 'M', '2000-10-01', 4990.00, 'Av. Ji-Parana', 'joab.silva@hotmail.com', '69 8411 2321');
insert into cliente values (null, 'Rodrigo Hilbert', '123.445.888-99', '5592 sesdec', 'M', '1970-09-30', 2500.00, 'Rua Dr. Luiz', 'rodrigo.hilbert@yahoo.com.br', '9944 4545');
insert into cliente values (null, 'João Eujácio Teixeira Júnior', '999.445.789-99', '978999992 sesdec', 'M', '1989-01-10', 6000.00, 'Rua Silva Abreu', 'joao.eujacio@ifro.edu.br', '3421 1159');
insert into cliente values (null, 'Everton Feline', '123.123.888-99', '12392 sesdec', 'M', '1987-12-10', 11500.00, 'Rua Alencar Vieira', 'everton.feline@gmail.com','69 84228811');
insert into cliente values (null, 'Igor de Souza Santos', '123.345.848-99', '43299892 sesdec', 'M', '1990-12-30', 1000.00, 'Av. Brasil', 'igor.souza@gmail.com', '69 9977 7777');
insert into cliente values (null, 'Francisco Bezerra', '888.123.111-11', '213156 sesdec', 'M', '1965-01-30', 3500.00, 'Rua Fim do Mundo', 'francisco.bezerra@ifro.edu.br', '69 3423 5502');


create table Conta_Corrente (
cod_cc int primary key not null auto_increment,
numero_cc int not null,
dataAbertura_cc date not null,
saldo_cc float not null,
cod_ag_fk int not null,
cod_cli_fk int not null,
foreign key (cod_ag_fk) references Agencia (cod_ag),
foreign key (cod_cli_fk) references Cliente (cod_cli)
);

insert into Conta_Corrente values (null, 40650, '2009-01-01', 0.00, 1, 1);
insert into Conta_Corrente values (null, 41897, '2009-01-30', 0.00, 1, 2);
insert into Conta_Corrente values (null, 42487, '2010-06-06', 0.00, 1, 3);
insert into Conta_Corrente values (null, 43456, '2011-04-21', 0.00, 1, 4);
insert into Conta_Corrente values (null, 44787, '2012-12-31', 0.00, 1, 5);

create table Deposito (
cod_dep int primary key not null auto_increment,
valor_dep float not null,
data_dep date not null,
tipo_dep varchar (100),
cod_cc_fk int not null,
foreign key (cod_cc_fk) references Conta_Corrente (cod_cc)
);

create table Saque (
cod_saq int primary key not null auto_increment,
valor_saq float not null,
data_saq date not null,
local_saq varchar (100) not null,
hora_saq time,
cod_cc_fk int not null,
foreign key (cod_cc_fk) references Conta_Corrente (cod_cc)
);

create table Transferencia (
cod_trans int primary key not null auto_increment,
valor_trans float not null,
data_trans date not null,
descricao_trans varchar (100), #Exemplo: Pagamento de carro
cod_cc_origem_fk int not null,
cod_cc_destino_fk int not null,
foreign key (cod_cc_origem_fk) references Conta_Corrente (cod_cc),
foreign key (cod_cc_destino_fk) references Conta_Corrente (cod_cc)
);

create table Pagamento (
cod_pag int primary key not null auto_increment,
valor_pag float not null,
data_pag date not null,
tipo_pag varchar (100), #Tipos possíveis: Boleto ou Convênio
hora_pag time,
dataVencimento_pag date not null,
codigoBarras_pag varchar (300),
cod_cc_fk int not null,
foreign key (cod_cc_fk) references Conta_Corrente (cod_cc)
);

drop table pagamento;
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

