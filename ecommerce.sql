- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL,
  `Endereço` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estoque` (
  `idEstoque` INT NOT NULL AUTO_INCREMENT,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Terceiro - Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Terceiro - Vendedor` (
  `idTerceiro - Vendedor` INT NOT NULL AUTO_INCREMENT,
  `Razão Social` VARCHAR(45) NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idTerceiro - Vendedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Status do pedido` VARCHAR(45) NULL,
  `Descrição` VARCHAR(45) NULL,
  `Frete` FLOAT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `Categoria` VARCHAR(45) NULL,
  `Descrição` VARCHAR(45) NULL,
  `Valor` FLOAT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor` (
  `idFornecedor` INT NOT NULL AUTO_INCREMENT,
  `Razão Social` VARCHAR(45) NULL,
  `CNPJ` VARCHAR(45) NULL,
  PRIMARY KEY (`idFornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Disponibiliza um produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Disponibiliza um produto` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produto_idProduto`),
  INDEX `fk_Fornecedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Produto_Fornecedor_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `mydb`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produto_has_Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produto_has_Estoque` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `mydb`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Relação de Produto/pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Relação de Produto/pedido` (
  `Produto_idProduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Pedido_idPedido`),
  INDEX `fk_Produto_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Produto_has_Pedido_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos por Vendedor (Terceiro)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos por Vendedor (Terceiro)` (
  `Terceiro - Vendedor_idTerceiro - Vendedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Terceiro - Vendedor_idTerceiro - Vendedor`, `Produto_idProduto`),
  INDEX `fk_Terceiro - Vendedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Terceiro - Vendedor_has_Produto_Terceiro - Vendedor1_idx` (`Terceiro - Vendedor_idTerceiro - Vendedor` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiro - Vendedor_has_Produto_Terceiro - Vendedor1`
    FOREIGN KEY (`Terceiro - Vendedor_idTerceiro - Vendedor`)
    REFERENCES `mydb`.`Terceiro - Vendedor` (`idTerceiro - Vendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro - Vendedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `mydb`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente PJ`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente PJ` (
  `idCliente PJ` INT NOT NULL AUTO_INCREMENT,
  `CNPJ` VARCHAR(14) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idCliente PJ`, `Cliente_idCliente`),
  INDEX `fk_Cliente PJ_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente PJ_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente PF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente PF` (
  `idCliente PF` INT NOT NULL AUTO_INCREMENT,
  `CPF` VARCHAR(11) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idCliente PF`, `Cliente_idCliente`),
  INDEX `fk_Cliente PF_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente PF_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT,
  `Valor total` FLOAT NULL,
  `Status` VARCHAR(45) NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`idPagamento`),
  INDEX `fk_Pagamento_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PAGAMENTO_PIX`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PAGAMENTO_PIX` (
  `Pagamento_idPagamento` INT NOT NULL,
  `Chave_pix` VARCHAR(100) NULL,
  `Data de Expiração` DATE NULL,
  PRIMARY KEY (`Pagamento_idPagamento`),
  CONSTRAINT `fk_PAGAMENTO_PIX_Pagamento1`
    FOREIGN KEY (`Pagamento_idPagamento`)
    REFERENCES `mydb`.`Pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PAGAMENTO_CARTÃO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PAGAMENTO_CARTÃO` (
  `Pagamento_idPagamento` INT NOT NULL,
  `Número` VARCHAR(45) NULL,
  `Data de Validade` DATE NULL,
  `Parcelas` INT NULL,
  `Nome` VARCHAR(45) NULL,
  PRIMARY KEY (`Pagamento_idPagamento`),
  UNIQUE INDEX `Número_UNIQUE` (`Número` ASC) VISIBLE,
  CONSTRAINT `fk_PAGAMENTO_CARTÃO_Pagamento1`
    FOREIGN KEY (`Pagamento_idPagamento`)
    REFERENCES `mydb`.`Pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PAGAMENTO_BOLETO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PAGAMENTO_BOLETO` (
  `Pagamento_idPagamento` INT NOT NULL,
  `Código de barras` VARCHAR(45) NULL,
  `Data de vencimento` DATE NULL,
  PRIMARY KEY (`Pagamento_idPagamento`),
  CONSTRAINT `fk_PAGAMENTO_BOLETO_Pagamento1`
    FOREIGN KEY (`Pagamento_idPagamento`)
    REFERENCES `mydb`.`Pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entrega` (
  `idEntrega` INT NOT NULL AUTO_INCREMENT,
  `Codigo de rastreio` VARCHAR(45) NULL,
  `Status` VARCHAR(45) NULL,
  `Data prevista` DATE NULL,
  `Data de entrega` DATE NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`idEntrega`),
  INDEX `fk_Entrega_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Entrega_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Input
-- -----------------------------------------------------

INSERT INTO `Cliente` (`Nome`, `Endereço`) VALUES
('João Silva', 'Rua das Flores, 123 - São Paulo/SP'),
('Maria Oliveira', 'Av. Paulista, 1000 - São Paulo/SP'),
('Carlos Souza', 'Rua XV de Novembro, 50 - Curitiba/PR'),
('Ana Costa', 'Av. Brasil, 2000 - Rio de Janeiro/RJ'),
('Pedro Santos', 'Rua da Praia, 300 - Salvador/BA');

INSERT INTO `Estoque` (`Local`) VALUES
('Centro de Distribuição SP'),
('Armazém Rio de Janeiro'),
('Galpão Curitiba'),
('Depósito Salvador'),
('Centro Logístico Minas');

INSERT INTO `Terceiro - Vendedor` (`Razão Social`, `Local`) VALUES
('Eletrônicos Brasil LTDA', 'São Paulo/SP'),
('Moda Fashion ME', 'Rio de Janeiro/RJ'),
('Casa e Construção SA', 'Belo Horizonte/MG'),
('Esportes Radicais EIRELI', 'Curitiba/PR'),
('Brinquedos Educativos LTDA', 'Porto Alegre/RS');

INSERT INTO `Pedido` (`Status do pedido`, `Descrição`, `Frete`, `Cliente_idCliente`) VALUES
('Processando', 'Pedido de eletrônicos', 15.90, 1),
('Enviado', 'Roupas e acessórios', 12.50, 2),
('Entregue', 'Ferramentas de construção', 25.00, 3),
('Cancelado', 'Brinquedos infantis', 10.00, 4),
('Processando', 'Produtos esportivos', 18.75, 5);

INSERT INTO `Produto` (`Categoria`, `Descrição`, `Valor`) VALUES
('Eletrônico', 'Smartphone XYZ', 1999.90),
('Vestuário', 'Camiseta Premium', 89.90),
('Ferramenta', 'Furadeira 500W', 249.90),
('Brinquedo', 'Quebra-cabeça 500 peças', 59.90),
('Esporte', 'Bola de Futebol Oficial', 129.90);

INSERT INTO `Fornecedor` (`Razão Social`, `CNPJ`) VALUES
('Tech Import LTDA', '12345678000101'),
('Têxtil Nacional SA', '23456789000102'),
('Ferramentas Forte ME', '34567890000103'),
('Brinquedos Educar EIRELI', '45678901000104'),
('Esportes Brasil LTDA', '56789012000105');

INSERT INTO `Disponibiliza um produto` (`Fornecedor_idFornecedor`, `Produto_idProduto`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO `Produto_has_Estoque` (`Produto_idProduto`, `Estoque_idEstoque`, `Quantidade`) VALUES
(1, 1, 50),
(2, 2, 120),
(3, 3, 30),
(4, 4, 80),
(5, 5, 45);

INSERT INTO `Relação de Produto/pedido` (`Produto_idProduto`, `Pedido_idPedido`, `Quantidade`) VALUES
(1, 1, 1),
(2, 2, 3),
(3, 3, 1),
(4, 4, 2),
(5, 5, 1);

INSERT INTO `Produtos por Vendedor (Terceiro)` (`Terceiro - Vendedor_idTerceiro - Vendedor`, `Produto_idProduto`, `Quantidade`) VALUES
(1, 1, 10),
(2, 2, 25),
(3, 3, 8),
(4, 4, 15),
(5, 5, 12);

INSERT INTO `Cliente PJ` (`CNPJ`, `Cliente_idCliente`) VALUES
('12345678901234', 1),
('23456789012345', 2),
('34567890123456', 3),
('45678901234567', 4),
('56789012345678', 5);

INSERT INTO `Cliente PF` (`CPF`, `Cliente_idCliente`) VALUES
('12345678901', 1),
('23456789012', 2),
('34567890123', 3),
('45678901234', 4),
('56789012345', 5);

INSERT INTO `Pagamento` (`Valor total`, `Status`, `Pedido_idPedido`) VALUES
(2015.80, 'Aprovado', 1),
(282.20, 'Aprovado', 2),
(274.90, 'Estornado', 3),
(129.80, 'Cancelado', 4),
(148.65, 'Processando', 5);

INSERT INTO `PAGAMENTO_PIX` (`Pagamento_idPagamento`, `Chave_pix`, `Data de Expiração`) VALUES
(1, 'joao.silva@email.com', '2023-12-31'),
(3, 'carlos.souza@email.com', '2023-11-30');

INSERT INTO `PAGAMENTO_CARTÃO` (`Pagamento_idPagamento`, `Número`, `Data de Validade`, `Parcelas`, `Nome`) VALUES
(2, '4111111111111111', '2025-12-01', 3, 'MARIA OLIVEIRA'),
(5, '5555555555554444', '2026-06-01', 1, 'PEDRO SANTOS');

INSERT INTO `PAGAMENTO_BOLETO` (`Pagamento_idPagamento`, `Código de barras`, `Data de vencimento`) VALUES
(4, '1234567890123456789012345678901234567890', '2023-10-15');

INSERT INTO `Entrega` (`Codigo de rastreio`, `Status`, `Data prevista`, `Data de entrega`, `Pedido_idPedido`) VALUES
('BR123456789SP', 'Entregue', '2023-10-10', '2023-10-09', 1),
('BR234567890RJ', 'Em trânsito', '2023-10-15', NULL, 2),
('BR345678901PR', 'Entregue', '2023-09-20', '2023-09-18', 3),
('BR456789012BA', 'Cancelada', '2023-10-05', NULL, 4),
('BR567890123MG', 'Postado', '2023-10-20', NULL, 5);

-- -----------------------------------------------------
-- 1. Quantos pedidos foram feitos por cada cliente?
-- -----------------------------------------------------

SELECT 
    c.Nome AS 'Cliente',
    COUNT(p.idPedido) AS 'Total de Pedidos'
FROM 
    Cliente c
LEFT JOIN 
    Pedido p ON c.idCliente = p.Cliente_idCliente
GROUP BY 
    c.idCliente, c.Nome
ORDER BY 
    COUNT(p.idPedido) DESC;

-- -----------------------------------------------------
-- 2. Algum vendedor também é fornecedor?
-- -----------------------------------------------------

SELECT 
    tv.`Razão Social` AS 'Razão Social',
    tv.`Local` AS 'Localização',
    'Terceiro-Vendedor' AS 'Tipo'
FROM 
    `Terceiro - Vendedor` tv
INNER JOIN 
    Fornecedor f ON tv.`Razão Social` = f.`Razão Social`
UNION
SELECT 
    f.`Razão Social`,
    f.CNPJ AS 'Localização',  -- Usando CNPJ como identificador já que Fornecedor não tem Local
    'Fornecedor' AS 'Tipo'
FROM 
    Fornecedor f
INNER JOIN 
    `Terceiro - Vendedor` tv ON f.`Razão Social` = tv.`Razão Social`;

-- -----------------------------------------------------
-- 3. Relação de produtos, fornecedores e estoques
-- -----------------------------------------------------    

SELECT 
    p.idProduto,
    p.Descrição AS 'Produto',
    f.`Razão Social` AS 'Fornecedor',
    e.Local AS 'Local do Estoque',
    phe.Quantidade AS 'Quantidade em Estoque'
FROM 
    Produto p
JOIN 
    `Disponibiliza um produto` dup ON p.idProduto = dup.Produto_idProduto
JOIN 
    Fornecedor f ON dup.Fornecedor_idFornecedor = f.idFornecedor
JOIN 
    Produto_has_Estoque phe ON p.idProduto = phe.Produto_idProduto
JOIN 
    Estoque e ON phe.Estoque_idEstoque = e.idEstoque
ORDER BY 
    p.idProduto;

-- -----------------------------------------------------
-- 4. Relação de nomes dos fornecedores e nomes dos produtos
-- -----------------------------------------------------    

SELECT 
    f.`Razão Social` AS 'Fornecedor',
    GROUP_CONCAT(p.Descrição SEPARATOR ', ') AS 'Produtos Fornecidos'
FROM 
    Fornecedor f
JOIN 
    `Disponibiliza um produto` dup ON f.idFornecedor = dup.Fornecedor_idFornecedor
JOIN 
    Produto p ON dup.Produto_idProduto = p.idProduto
GROUP BY 
    f.idFornecedor, f.`Razão Social`
ORDER BY 
    f.`Razão Social`;

-- -----------------------------------------------------
-- Queries Adicionais para Análise do Banco de Dados
-- -----------------------------------------------------  

-- -----------------------------------------------------
-- 1. Recuperações simples com SELECT Statement
-- -----------------------------------------------------  

-- Lista todos os clientes
SELECT * FROM Cliente;

-- Lista todos os produtos com valor acima de 100 reais
SELECT * FROM Produto WHERE Valor > 100;

-- Lista todos os pedidos com status 'Entregue'
SELECT * FROM Pedido WHERE `Status do pedido` = 'Entregue';

-- -----------------------------------------------------
-- 2. Filtros com WHERE Statement
-- -----------------------------------------------------

-- Produtos da categoria 'Eletrônico' com valor entre 500 e 2000 reais
SELECT * FROM Produto 
WHERE Categoria = 'Eletrônico' 
AND Valor BETWEEN 500 AND 2000;

-- Pedidos com frete maior que 15 reais feitos no último trimestre
SELECT * FROM Pedido 
WHERE Frete > 15 
AND `Status do pedido` NOT IN ('Cancelado');

-- Clientes de São Paulo (considerando endereço)
SELECT * FROM Cliente 
WHERE `Endereço` LIKE '%São Paulo%';

-- -----------------------------------------------------
-- 3. Expressões para gerar atributos derivados
-- -----------------------------------------------------

-- Valor total do pedido (produtos + frete)
SELECT 
    p.idPedido,
    p.`Status do pedido`,
    SUM(rp.Quantidade * pr.Valor) AS 'Valor dos Produtos',
    p.Frete,
    SUM(rp.Quantidade * pr.Valor) + p.Frete AS 'Valor Total'
FROM 
    Pedido p
JOIN 
    `Relação de Produto/pedido` rp ON p.idPedido = rp.Pedido_idPedido
JOIN 
    Produto pr ON rp.Produto_idProduto = pr.idProduto
GROUP BY 
    p.idPedido;

-- Média de valor dos produtos por categoria
SELECT 
    Categoria,
    COUNT(*) AS 'Quantidade de Produtos',
    AVG(Valor) AS 'Média de Valor',
    CONCAT('R$ ', FORMAT(AVG(Valor), 2)) AS 'Média Formatada'
FROM 
    Produto
GROUP BY 
    Categoria;

-- -----------------------------------------------------
-- 4. Ordenações dos dados com ORDER BY
-- -----------------------------------------------------

-- Produtos ordenados por valor (do mais caro para o mais barato)
SELECT * FROM Produto ORDER BY Valor DESC;

-- Pedidos ordenados por status e depois por data (considerando que haveria uma coluna de data)
SELECT * FROM Pedido 
ORDER BY 
    CASE `Status do pedido`
        WHEN 'Processando' THEN 1
        WHEN 'Enviado' THEN 2
        WHEN 'Entregue' THEN 3
        WHEN 'Cancelado' THEN 4
        ELSE 5
    END,
    idPedido DESC;

-- Clientes ordenados por nome
SELECT * FROM Cliente ORDER BY Nome;
-- -----------------------------------------------------
-- 5. Condições de filtros aos grupos – HAVING Statement
-- -----------------------------------------------------

-- Categorias com média de valor superior a 150 reais
SELECT 
    Categoria,
    AVG(Valor) AS 'Média de Valor'
FROM 
    Produto
GROUP BY 
    Categoria
HAVING 
    AVG(Valor) > 150;

-- Fornecedores que fornecem mais de 3 produtos
SELECT 
    f.`Razão Social`,
    COUNT(dup.Produto_idProduto) AS 'Quantidade de Produtos'
FROM 
    Fornecedor f
JOIN 
    `Disponibiliza um produto` dup ON f.idFornecedor = dup.Fornecedor_idFornecedor
GROUP BY 
    f.idFornecedor, f.`Razão Social`
HAVING 
    COUNT(dup.Produto_idProduto) > 3;

-- Clientes com mais de 2 pedidos
SELECT 
    c.Nome,
    COUNT(p.idPedido) AS 'Total de Pedidos'
FROM 
    Cliente c
JOIN 
    Pedido p ON c.idCliente = p.Cliente_idCliente
GROUP BY 
    c.idCliente, c.Nome
HAVING 
    COUNT(p.idPedido) > 2;