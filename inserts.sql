-- Não usei o apelido de uma letra, ficou confuso de entender
-- Relatório 1 
CREATE VIEW Relatorio1 AS
SELECT 
    Empregado.nome AS "Nome Empregado", Empregado.cpf AS "CPF Empregado", 
    DATE_FORMAT(empregado.data_Admissao, '%d/%m/%Y') AS "Data de Admissão", 
    CONCAT('R$', FORMAT(Salario, 2, 'pt_BR')) AS "Salário",
    Departamento.nome AS "Departamento", Telefone.num AS "Numero Telefone"
FROM 
    Empregado
JOIN 
    Departamento ON Empregado.Departamento_idDepartamento = Departamento.idDepartamento
JOIN 
    Telefone ON Empregado.cpf = Telefone.Empregado_cpf
WHERE 
    Empregado.dataAdm BETWEEN '2019-01-01' AND '2022-03-31'
    
ORDER BY Empregado.dataAdm DESC;


-- Relatório 2
CREATE VIEW Relatorio2 AS
SELECT 
    empregado.Nome AS "Nome Empregado",
    empregado.CPF AS "CPF Empregado",
    DATE_FORMAT(empregado.data_Admissao, '%d/%m/%Y') AS "Data de Admissão",
    CONCAT('R$', FORMAT(e.Salario, 2, 'pt_BR')) AS "Salário",
    departamento.Nome AS "Departamento",
    empregado.Numero_Telefone AS "Número de Telefone"
FROM 
    Empregado
INNER JOIN 
    Departamento ON empregado.departamentoId = departamento.id
WHERE 
    empregado.Salario < (SELECT AVG(Salario) FROM Empregado)
-- AVG é pra calcular a média
ORDER BY empregado.Nome;


-- Relatório 3
CREATE VIEW Relatorio3 AS
SELECT 
    departamento.nome AS "Departamento",
    COUNT(empregado.ID) AS "Quantidade de Empregados",
    CONCAT('R$', FORMAT(AVG(empregado.Salario), 2, 'pt_BR')) AS "Média Salarial",
    CONCAT('R$', FORMAT(AVG(empregado.Comissao), 2, 'pt_BR')) AS "Média da Comissão"
FROM 
    Departamento
INNER JOIN 
    Empregado ON departamento.id = empregado.DepartamentoId

GROUP BY departamento.Nome
ORDER BY departamento.Nome;


-- Relatório 4
CREATE VIEW Relatorio4 AS
SELECT 
    empregado.Nome AS "Nome Empregado",
    empregado.CPF AS "CPF Empregado",
    empregado.Sexo AS "Sexo",
    CONCAT('R$', FORMAT(empregado.Salario, 2, 'pt_BR')) AS "Salário",
    COUNT(venda.ID) AS "Quantidade Vendas",
    CONCAT('R$', FORMAT(SUM(venda.Valor), 2, 'pt_BR')) AS "Total valor vendido",
    CONCAT('R$', FORMAT(SUM(venda.Comissao), 2, 'pt_BR')) AS "Total comissão das vendas"
FROM 
    Empregado
INNER JOIN 
    Venda ON empregado.Id = venda.EmpregadoId

GROUP BY empregado.id
ORDER BY COUNT(venda.ID) DESC;


-- Relatório 5
CREATE VIEW Relatorio5 AS
SELECT 
    empregado.Nome AS "Nome Empregado",
    empregado.CPF AS "CPF Empregado",
    empregado.Sexo AS "Sexo",
    CONCAT('R$', FORMAT(empregado.Salario, 2, 'pt_BR')) AS "Salário",
    COUNT(venda.id) AS "Quantidade Vendas com Serviço",
    CONCAT('R$', FORMAT(SUM(venda.Valor), 2, 'pt_BR')) AS "Total Valor Vendido com Serviço",
    CONCAT('R$', FORMAT(SUM(venda.Comissao), 2, 'pt_BR')) AS "Total Comissão das Vendas com Serviço"
FROM 
    Empregado
INNER JOIN 
    Venda ON empregado.id = venda.EmpregadoId
INNER JOIN 
    Venda_Servico ON venda.ID = valorServico.VendaId

GROUP BY empregado.Id
ORDER BY COUNT(venda.Id) DESC;


-- Relatório 6 
CREATE VIEW Relatorio6 AS
SELECT 
    pet.Nome AS "Nome do Pet",
    DATE_FORMAT(servico.data, '%d/%m/%Y') AS "Data do Serviço",
    servico.Nome AS "Nome do Serviço",
    valorServico.Quantidade AS "Quantidade",
    CONCAT('R$', FORMAT(servico.Valor, 2, 'pt_BR')) AS "Valor",
    empregado.nome AS "Empregado que realizou o Serviço"
FROM 
    Servico
INNER JOIN 
    Venda_Servico ON servico.id = valorServico.ServicoId
INNER JOIN 
    Venda ON valorServico.VendaID = venda.id
INNER JOIN 
    Empregado ON venda.EmpregadoId = empregado.id
INNER JOIN 
    Pet ON venda.PetID = pet.id

ORDER BY s.Data DESC;


-- Relatório 7 
CREATE VIEW Relatório7 AS
SELECT 
    DATE_FORMAT(venda.data_venda, '%d/%m/%Y') AS "Data da Venda",
    CONCAT('R$', FORMAT(venda.valor, 2, 'pt_BR')) AS "Valor",
    CONCAT('R$', FORMAT(venda.desconto, 2, 'pt_BR')) AS "Desconto",
    CONCAT('R$', FORMAT((venda.valor - venda.desconto), 2, 'pt_BR')) AS "Valor Final",
    e.nome AS "Empregado que realizou a venda"
FROM 
    vendas
INNER JOIN 
    clientes ON venda.cliente_id = cliente.id
INNER JOIN 
    empregados ON venda.empregado_id = empregado.id
WHERE 
    cliente.id = "017.503.885-61"
    
ORDER BY venda.data_venda DESC;



-- Relatório 8
CREATE VIEW Relatorio8 AS
SELECT 
    s.Nome AS "Nome do Serviço",
    COUNT(valorServico.VendaID) AS "Quantidade Vendas",
    CONCAT('R$', FORMAT(SUM(servico.Valor), 2, 'pt_BR')) AS "Total Valor Vendido"
FROM 
    Servico 
INNER JOIN 
    Venda_Servico ON servico.Id = valorServico.ServicoId

GROUP BY servico.Nome
ORDER BY COUNT(valorServico.VendaID) DESC
LIMIT 10;

    
-- Relatório 9 
CREATE VIEW Relatorio9 AS
SELECT 
    formaPagamento.Tipo AS "Tipo Forma Pagamento",
    COUNT(venda.id) AS "Quantidade Vendas",
    CONCAT('R$', FORMAT(SUM(venda.Valor), 2, 'pt_BR')) AS "Total Valor Vendido"
FROM 
    Venda
INNER JOIN 
    Forma_Pagamento ON venda.FormaPagamentoId = formaPagamento.id
    
GROUP BY formaPagamento.Tipo
ORDER BY COUNT(venda.id) DESC;


--  Relatório 10 
CREATE VIEW Relatorio10 AS
SELECT 
    DATE_FORMAT(venda.data, '%d/%m/%Y') AS "Data Venda",
    COUNT(venda.id) AS "Quantidade de Vendas",
    CONCAT('R$', FORMAT(SUM(venda.Valor), 2, 'pt_BR')) AS "Valor Total Venda"
FROM 
    Venda

GROUP BY venda.data
ORDER BY venda.data DESC;


-- Relatório 11
CREATE VIEW Relatorio11 AS
SELECT 
    produto.nome AS "Nome Produto",
    CONCAT('R$', FORMAT(produto.Valor, 2, 'pt_BR')) AS "Valor Produto",
    produto.categoria AS "Categoria do Produto",
    fornecedor.nome AS "Nome Fornecedor",
    fornecedor.Email AS "Email Fornecedor",
    fornecedor.telefone AS "Telefone Fornecedor"
FROM Produto 
INNER JOIN Fornecedor ON produto.FornecedorId = fornecedor.id
ORDER BY produto.Nome;


-- Relatório 12
CREATE VIEW Relatorio12 AS
SELECT 
    produto.Nome AS "Nome Produto",
    COUNT(valorProduto.VendaID) AS "Quantidade de vendas",
    CONCAT('R$', FORMAT(SUM(produto.Valor), 2, 'pt_BR')) AS "Valor total recebido pela venda do produto"
FROM 
    Produto
INNER JOIN 
    Venda_Produto valorProduto ON produto.id = valorProduto.ProdutoID

GROUP BY produto.nome
ORDER BY COUNT(valorProduto.Vendaid) DESC;



SELECT * FROM Relatorio1;
SELECT * FROM Relatorio2;
SELECT * FROM Relatorio3;
SELECT * FROM Relatorio4;
SELECT * FROM Relatorio5;
SELECT * FROM Relatorio6;
SELECT * FROM Relatorio7;
SELECT * FROM Relatorio8;
SELECT * FROM Relatorio9;
SELECT * FROM Relatorio10;
SELECT * FROM Relatorio11;
SELECT * FROM Relatorio12;