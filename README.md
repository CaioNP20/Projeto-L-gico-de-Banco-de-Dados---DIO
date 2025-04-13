# Projeto-L-gico-de-Banco-de-Dados---DIO
# README - Sistema de E-Commerce `mydb`

## 📌 Visão Geral

Este repositório contém o banco de dados `mydb` para um sistema de e-commerce completo, com estrutura relacional que abrange:
- Cadastro de clientes (PF e PJ)
- Gestão de produtos e estoque
- Processamento de pedidos
- Controle de fornecedores e vendedores terceiros
- Sistema de pagamentos (PIX, cartão, boleto)
- Rastreamento de entregas

## 🗃️ Estrutura do Banco de Dados

### Principais Tabelas
- **Cliente** (com subtipos PF/PJ)
- **Produto** (com categorias)
- **Pedido** (com status)
- **Pagamento** (com formas específicas)
- **Fornecedor** e **Vendedor Terceiro**
- **Estoque** (com múltiplos locais)

### Diagrama Conceitual
```
Clientes → Pedidos → Produtos
                    ↑
Fornecedores → Estoque
Vendedores Terceiros ↗
```

## 🛠️ Queries Disponíveis

O sistema inclui queries para:

### Consultas Básicas
- Listagem de clientes, produtos e pedidos
- Filtros por categoria, valor e status

### Análises Comerciais
- Total de pedidos por cliente
- Relação produto-fornecedor-estoque
- Média de valores por categoria

### Operacionais
- Status de pagamentos e entregas
- Controle de inventário
- Identificação de vendedores/fornecedores

## 📊 Exemplos de Consultas Úteis

1. **Pedidos por cliente**:
   ```sql
   SELECT c.Nome, COUNT(p.idPedido) 
   FROM Cliente c LEFT JOIN Pedido p ON c.idCliente = p.Cliente_idCliente
   GROUP BY c.idCliente;
   ```

2. **Produtos em estoque crítico**:
   ```sql
   SELECT p.Descrição, SUM(phe.Quantidade) 
   FROM Produto p JOIN Produto_has_Estoque phe ON p.idProduto = phe.Produto_idProduto
   GROUP BY p.idProduto HAVING SUM(phe.Quantidade) < 10;
   ```

## ⚙️ Como Executar

1. Crie o banco executando o script SQL completo
2. Popule as tabelas com os dados de exemplo fornecidos
3. Execute as queries conforme necessidade

## 📝 Observações

- O banco utiliza convenção de nomes com espaços (requer aspas em queries)
- Algumas queries assumem a existência de campos de data não presentes no schema original
- Relacionamentos complexos estão devidamente mapeados com chaves estrangeiras

## 📈 Próximos Passos

Sugestões para evolução:
- Adicionar histórico de preços
- Implementar views para relatórios frequentes
- Criar procedures para operações repetitivas

Desenvolvido para estudo de modelos de banco de dados para e-commerce.
