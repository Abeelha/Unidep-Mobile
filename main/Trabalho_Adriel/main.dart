import 'dart:collection';

class Cliente {
  String nome;
  String email;

  Cliente(this.nome, this.email);
}

class Produto {
  String nome;
  double preco;
  int quantidade;

  Produto(this.nome, this.preco, this.quantidade);
}

class Loja {
  List<Cliente> clientes = [];
  List<Produto> produtos = [];
  Map<String, int> estoque = {};
  double totalVendas = 0.0;

  void cadastrarCliente(String nome, String email) {
    Cliente cliente = Cliente(nome, email);
    clientes.add(cliente);
  }

  Cliente buscarCliente(String email) {
    return clientes.firstWhere((cliente) => cliente.email == email);
  }

  void deletarCliente(String email) {
    clientes.removeWhere((cliente) => cliente.email == email);
  }

  void cadastrarProduto(String nome, double preco, int quantidade) {
    Produto produto = Produto(nome, preco, quantidade);
    produtos.add(produto);
    estoque[produto.nome] = quantidade;
  }

  Produto buscarProduto(String nome) {
    return produtos.firstWhere((produto) => produto.nome == nome);
  }

  void deletarProduto(String nome) {
    Produto produto = buscarProduto(nome);
    produtos.remove(produto);
    estoque.remove(nome);
  }

  void venderProduto(String nome, int quantidade) {
    Produto produto = buscarProduto(nome);
    var estoqueProduto = estoque[produto.nome] ?? 0;
    if (estoqueProduto >= quantidade) {
      estoque[produto.nome] = estoqueProduto - quantidade;
      totalVendas += produto.preco * quantidade;
      print('Venda realizada com sucesso.');
    } else {
      print('Quantidade insuficiente em estoque.');
    }
  }

  void relatorioClientes() {
    print('Clientes Cadastrados:');
    for (var cliente in clientes) {
      print('Nome: ${cliente.nome}, Email: ${cliente.email}');
    }
  }

  void relatorioTotalVendas() {
    print('Total de Vendas: $totalVendas');
  }
}

void main() {
  Loja loja = Loja();

  // Exemplo de uso
  loja.cadastrarCliente('Adriel', 'adriel@example.com');
  loja.cadastrarCliente('Theo', 'theo@example.com');

  loja.cadastrarProduto('Cadeira Gamer A', 500.0, 10);
  loja.cadastrarProduto('Cadeira Gamer B', 600.0, 15);

  loja.venderProduto('Cadeira Gamer A', 3);
  loja.venderProduto('Cadeira Gamer B', 2);

  loja.relatorioClientes();
  loja.relatorioTotalVendas();
}
