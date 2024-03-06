    1 - Importando bibliotecas: O código começa importando a biblioteca dart:collection, que fornece classes de coleções, como Map, que é usada neste código.

    2 - Definindo as classes Cliente e Produto:

        Cliente: Esta classe tem dois atributos, nome e email, e um construtor que inicializa esses atributos.
        Produto: Similar à classe Cliente, com atributos nome, preco e quantidade.
    
    3 - Definindo a classe Loja:

        A classe Loja tem quatro atributos: clientes, produtos, estoque e totalVendas.
        Métodos:
        cadastrarCliente: Adiciona um novo cliente à lista de clientes da loja.
        buscarCliente: Procura um cliente pelo seu e-mail na lista de clientes.
        deletarCliente: Remove um cliente da lista de clientes da loja.
        cadastrarProduto: Adiciona um novo produto à lista de produtos da loja e ao estoque, mantendo o controle da quantidade.
        buscarProduto: Procura um produto pelo nome na lista de produtos da loja.
        deletarProduto: Remove um produto da lista de produtos da loja e do estoque.
        venderProduto: Vende um produto da loja, atualizando a quantidade no estoque e o total de vendas.
        relatorioClientes: Imprime na tela o nome e o e-mail de todos os clientes cadastrados na loja.
        relatorioTotalVendas: Imprime na tela o total de vendas realizadas pela loja.


    4 - Função main:

        Cria uma instância da classe Loja.
        Realiza algumas operações de exemplo, como cadastrar clientes, cadastrar produtos, vender produtos e gerar relatórios.