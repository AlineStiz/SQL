use bd_hotel;


delimiter $$
create procedure MostrarProutosquartos(codigo int)
	begin
		select
		quarto.número_qua as 'Número do quarto',
		produto.descrição_prod as 'Nome do Produto',
		produtos_quarto.quantidade_pq as 'Quantidade diponivel no Quarto'
		from
		quarto, produtos_quarto, produto
		where
		(quarto.cod_qua = produtos_quarto.cod_qua) and
		(produtos_quarto.cod_prod = produto.cod_prod) and 
		(quarto.cod_qua = codigo);
	end 
$$ delimiter ;

call MostrarProutosquartos (2);


delimiter $$
create procedure atualizarRendaCliente(renda float, codigo_cliente int)
	begin
		update cliente set rendafamiliar_cli = renda where cod_cli = codigo_cliente;
		select'cliente atualizado com sucesso !' as Corfirmação;
	end 
$$ delimiter ;
    
    call atualizarRendaCliente(2500, 10);  
    
    
delimiter $$
	create procedure listarTodosClientes ()
	begin
    select * from cliente;
    end
    $$ delimiter ;
    
call listarTodosClientes ();

    
