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
  Map<String, int> estoque = {}; // Mudança aqui
  double totalVendas = 0.0;

  void cadastrarCliente(String nome, String email) {
    Cliente cliente = Cliente(nome, email);
    clientes.add(cliente);
  }

  Cliente buscarCliente(String email) {
    var clienteEncontrado = null;
    try {
      clienteEncontrado =
          clientes.firstWhere((cliente) => cliente.email == email);
    } catch (e) {
      print('Ocorreu um erro ao buscar o cliente: $e');
    }
    return clienteEncontrado;
  }

  void deletarCliente(String email) {
    clientes.removeWhere((cliente) => cliente.email == email);
  }

  void cadastrarProduto(String nome, double preco, int quantidade) {
    Produto produto = Produto(nome, preco, quantidade);
    produtos.add(produto);
    estoque[produto.nome] = quantidade.toString(); // Convertendo para string
  }

  Produto? buscarProduto(String nome) {
    try {
      return produtos.firstWhere((produto) => produto.nome == nome);
    } catch (e) {
      print('Ocorreu um erro ao buscar o produto: $e');
      return null;
    }
  }

  void deletarProduto(String nome) {
    Produto produto = buscarProduto(nome)!; // Forçando a não ser nulo
    produtos.remove(produto);
    estoque.remove(nome); // Mudança aqui
  }

  void venderProduto(String nome, int quantidade) {
    Produto produto = buscarProduto(nome) ?? Produto('', 0.0, 0);
    if (produto.nome.isNotEmpty) {
      var estoqueProduto = int.parse(estoque[produto.nome]!); // Parse para int
      if (estoqueProduto >= quantidade) {
        estoque[produto.nome] =
            (estoqueProduto - quantidade).toString(); // Atualiza estoque
        totalVendas += produto.preco * quantidade;
        print('Venda realizada com sucesso.');
      } else {
        print('Quantidade insuficiente em estoque.');
      }
    } else {
      print('Produto não encontrado.');
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
