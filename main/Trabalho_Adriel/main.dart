import 'dart:collection';
import 'dart:io';

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

  void salvarDados(String nomeArquivo) {
    File arquivo = File(nomeArquivo);
    var dados = StringBuffer();

    // Escrever dados dos clientes
    dados.writeln('Clientes:');
    for (var cliente in clientes) {
      dados.writeln('Nome: ${cliente.nome}, Email: ${cliente.email}');
    }
    dados.writeln();

    // Escrever dados dos produtos
    dados.writeln('Produtos:');
    for (var produto in produtos) {
      dados.writeln(
          'Nome: ${produto.nome}, Preço: ${produto.preco}, Quantidade: ${produto.quantidade}');
    }
    dados.writeln();

    // Escrever dados do estoque
    dados.writeln('Estoque:');
    estoque.forEach((nome, quantidade) {
      dados.writeln('Produto: $nome, Quantidade: $quantidade');
    });
    dados.writeln();

    // Escrever total de vendas
    dados.writeln('Total de Vendas: $totalVendas');

    arquivo.writeAsStringSync(dados.toString());
    print('Dados salvos com sucesso no arquivo: $nomeArquivo');
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

  // Salvando os dados em um arquivo
  loja.salvarDados('dados_loja.txt');
}
