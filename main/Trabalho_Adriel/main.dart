import 'dart:io';

class Cliente {
  String nome;
  String email;

  Cliente(this.nome, this.email);

  String toString() => 'Nome: $nome, Email: $email';
}

class Produto {
  String nome;
  double preco;
  int quantidade;

  Produto(this.nome, this.preco, this.quantidade);

  String toString() => 'Nome: $nome, Preço: $preco, Quantidade: $quantidade';
}

class Compra {
  Cliente cliente;
  Produto produto;

  Compra(this.cliente, this.produto);

  String toString() => '${cliente.nome} comprou ${produto.nome}';
}

class Loja {
  List<Cliente> clientes = [];
  List<Produto> produtos = [];
  Map<String, int> estoque = {};
  List<Compra> historicoCompras = [];

  void limparTerminal() {
    print("\x1B[2J\x1B[0;0H");
  }

  void adicionarCliente(String nome, String email) {
    clientes.add(Cliente(nome, email));
  }

  void editarCliente(String email, String novoNome, String novoEmail) {
    var cliente = clientes.firstWhere((c) => c.email == email);
    cliente.nome = novoNome;
    cliente.email = novoEmail;
  }

  void deletarCliente(String email) {
    clientes.removeWhere((cliente) => cliente.email == email);
  }

  void visualizarClientes() {
    if (clientes.isEmpty) {
      print('Não há clientes cadastrados.');
    } else {
      print('Clientes:');
      clientes.forEach(print);
    }
  }

  void adicionarProduto(String nome, double preco, int quantidade) {
    produtos.add(Produto(nome, preco, quantidade));
    estoque[nome] = quantidade;
  }

  void editarProduto(String nome, double novoPreco, int novaQuantidade) {
    var produto = produtos.firstWhere((p) => p.nome == nome);
    produto.preco = novoPreco;
    produto.quantidade = novaQuantidade;
    estoque[nome] = novaQuantidade;
  }

  void deletarProduto(String nome) {
    produtos.removeWhere((produto) => produto.nome == nome);
    estoque.remove(nome);
  }

  void visualizarProdutos() {
    if (produtos.isEmpty) {
      print('Não há produtos cadastrados.');
    } else {
      print('Produtos:');
      produtos.forEach(print);
    }
  }

  void carregarDados(String nomeArquivo) {
    File arquivo = File(nomeArquivo);
    if (!arquivo.existsSync()) {
      print('Arquivo não encontrado.');
      return;
    }

    var linhas = arquivo.readAsLinesSync();

    List<Cliente> clientesCarregados = [];
    List<Produto> produtosCarregados = [];

    for (var linha in linhas) {
      if (linha.startsWith('Cliente:')) {
        var dados = linha.split(', ');
        var nome = dados[0].split(': ')[1];
        var email = dados[1].split(': ')[1];
        clientesCarregados.add(Cliente(nome, email));
      } else if (linha.startsWith('Produto:')) {
        var dados = linha.split(', ');
        var nome = dados[0].split(': ')[1];
        var preco = double.parse(dados[1].split(': ')[1]);
        var quantidade = int.parse(dados[2].split(': ')[1]);
        produtosCarregados.add(Produto(nome, preco, quantidade));
      }
    }

    // Atualizar a lista de clientes e produtos da loja com os dados carregados
    clientes = clientesCarregados;
    produtos = produtosCarregados;

    print('Dados carregados com sucesso do arquivo: $nomeArquivo');
  }

  void efetuarCompra(int indiceCliente, int indiceProduto) {
    if (indiceCliente < 0 || indiceCliente >= clientes.length) {
      print('Índice de cliente inválido.');
      return;
    }

    if (indiceProduto < 0 || indiceProduto >= produtos.length) {
      print('Índice de produto inválido.');
      return;
    }

    var cliente = clientes[indiceCliente];
    var produto = produtos[indiceProduto];

    if (estoque[produto.nome] == 0) {
      print('Produto esgotado.');
      return;
    }

    estoque[produto.nome] = estoque[produto.nome]! - 1;
    historicoCompras.add(Compra(cliente, produto));
    print('Compra efetuada com sucesso!');
  }

  void mostrarHistoricoCompras() {
    if (historicoCompras.isEmpty) {
      print('Não há histórico de compras.');
    } else {
      print('Histórico de Compras:');
      historicoCompras.forEach(print);
    }
  }

  void mostrarEstoqueProdutos() {
    if (estoque.isEmpty) {
      print('Não há produtos no estoque.');
    } else {
      print('Estoque de Produtos:');
      estoque.forEach((nome, quantidade) {
        print('Produto: $nome, Quantidade: $quantidade');
      });
    }
  }

  void salvarDados(String nomeArquivo) {
    var arquivo = File(nomeArquivo);
    var dados = StringBuffer();

    // Escrever dados dos clientes
    dados.writeln('Clientes:');
    for (var cliente in clientes) {
      dados.writeln('Cliente: Nome: ${cliente.nome}, Email: ${cliente.email}');
    }
    dados.writeln();

    // Escrever dados dos produtos
    dados.writeln('Produtos:');
    for (var produto in produtos) {
      dados.writeln(
          'Produto: Nome: ${produto.nome}, Preço: ${produto.preco}, Quantidade: ${produto.quantidade}');
    }
    dados.writeln();

    // Escrever dados do estoque
    dados.writeln('Estoque:');
    estoque.forEach((nome, quantidade) {
      dados.writeln('Produto: $nome, Quantidade: $quantidade');
    });
    dados.writeln();

    // Escrever histórico de compras
    dados.writeln('Histórico de Compras:');
    for (var compra in historicoCompras) {
      dados.writeln(
          'Compra: Cliente: ${compra.cliente.nome}, Produto: ${compra.produto.nome}');
    }
    dados.writeln();

    arquivo.writeAsStringSync(dados.toString());
    print('Dados salvos com sucesso no arquivo: $nomeArquivo');
  }

  void menuClientes() {
    var opcao;
    do {
      limparTerminal();
      print('Menu de Clientes:');
      print('1. Adicionar Cliente');
      print('2. Editar Cliente');
      print('3. Deletar Cliente');
      print('4. Visualizar Clientes');
      print('0. Voltar');
      stdout.write('Escolha uma opção: ');
      opcao = stdin.readLineSync() ?? '';
      limparTerminal();
      switch (opcao) {
        case '1':
          stdout.write('Nome do cliente: ');
          var nome = stdin.readLineSync() ?? '';
          stdout.write('Email do cliente: ');
          var email = stdin.readLineSync() ?? '';
          adicionarCliente(nome, email);
          salvarDados('dados_loja.txt');
          break;
        case '2':
          visualizarClientes();
          stdout.write('Índice do cliente a ser editado: ');
          var indice = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
          if (indice >= 0 && indice < clientes.length) {
            stdout.write('Novo nome do cliente: ');
            var novoNome = stdin.readLineSync() ?? '';
            stdout.write('Novo email do cliente: ');
            var novoEmail = stdin.readLineSync() ?? '';
            editarCliente(clientes[indice].email, novoNome, novoEmail);
            salvarDados('dados_loja.txt');
          } else {
            print('Índice inválido.');
          }
          break;
        case '3':
          visualizarClientes();
          stdout.write('Índice do cliente a ser deletado: ');
          var indice = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
          if (indice >= 0 && indice < clientes.length) {
            deletarCliente(clientes[indice].email);
            salvarDados('dados_loja.txt');
          } else {
            print('Índice inválido.');
          }
          break;
        case '4':
          visualizarClientes();
          break;
        case '0':
          break;
        default:
          print('Opção inválida.');
      }
      if (opcao != '0') {
        stdout.write('Pressione Enter para continuar...');
        stdin.readLineSync();
      }
    } while (opcao != '0');
  }

  void menuProdutos() {
    var opcao;
    do {
      limparTerminal();
      print('Menu de Produtos:');
      print('1. Adicionar Produto');
      print('2. Editar Produto');
      print('3. Deletar Produto');
      print('4. Visualizar Produtos');
      print('0. Voltar');
      stdout.write('Escolha uma opção: ');
      opcao = stdin.readLineSync() ?? '';
      limparTerminal();
      switch (opcao) {
        case '1':
          stdout.write('Nome do produto: ');
          var nome = stdin.readLineSync() ?? '';
          stdout.write('Preço do produto: ');
          var preco = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;
          stdout.write('Quantidade do produto: ');
          var quantidade = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
          adicionarProduto(nome, preco, quantidade);
          salvarDados('dados_loja.txt');
          break;
        case '2':
          visualizarProdutos();
          stdout.write('Índice do produto a ser editado: ');
          var indice = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
          if (indice >= 0 && indice < produtos.length) {
            stdout.write('Novo preço do produto: ');
            var novoPreco = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;
            stdout.write('Nova quantidade do produto: ');
            var novaQuantidade = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
            editarProduto(produtos[indice].nome, novoPreco, novaQuantidade);
            salvarDados('dados_loja.txt');
          } else {
            print('Índice inválido.');
          }
          break;
        case '3':
          visualizarProdutos();
          stdout.write('Índice do produto a ser deletado: ');
          var indice = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
          if (indice >= 0 && indice < produtos.length) {
            deletarProduto(produtos[indice].nome);
            salvarDados('dados_loja.txt');
          } else {
            print('Índice inválido.');
          }
          break;
        case '4':
          visualizarProdutos();
          break;
        case '0':
          break;
        default:
          print('Opção inválida.');
      }
      if (opcao != '0') {
        stdout.write('Pressione Enter para continuar...');
        stdin.readLineSync();
      }
    } while (opcao != '0');
  }

  void menuCompras() {
    var opcao;
    do {
      limparTerminal();
      // Carregar os dados dos clientes e produtos do arquivo
      carregarDados('dados_loja.txt');
      print('Menu de Compras:');
      visualizarClientes();
      visualizarProdutos();
      visualizarClientes();
      visualizarProdutos();
      print('Selecione o cliente e o produto para fazer a compra.');
      print(
          'Para selecionar, digite o índice do cliente e do produto separados por vírgula.');
      print('Exemplo: 1,3');
      print('0. Voltar');
      stdout.write('Escolha uma opção: ');
      opcao = stdin.readLineSync() ?? '';
      if (opcao != '0') {
        var indices = opcao.split(',');
        if (indices.length == 2) {
          var indiceCliente = int.tryParse(indices[0].trim()) ?? -1;
          var indiceProduto = int.tryParse(indices[1].trim()) ?? -1;
          if (indiceCliente >= 0 &&
              indiceCliente < clientes.length &&
              indiceProduto >= 0 &&
              indiceProduto < produtos.length) {
            efetuarCompra(indiceCliente, indiceProduto);
            salvarDados('dados_loja.txt');
          } else {
            print('Índice de cliente ou produto inválido.');
          }
        } else {
          print('Opção inválida.');
        }
        stdout.write('Pressione Enter para continuar...');
        stdin.readLineSync();
      }
    } while (opcao != '0');
  }

  void menuPrincipal() {
    var opcao;
    do {
      limparTerminal();
      print('Menu Principal:');
      print('1. Clientes');
      print('2. Produtos');
      print('3. Compras');
      print('4. Mostrar Histórico de Compras');
      print('5. Mostrar Estoque de Produtos');
      print('0. Sair');
      stdout.write('Escolha uma opção: ');
      opcao = stdin.readLineSync() ?? '';
      limparTerminal();
      switch (opcao) {
        case '1':
          menuClientes();
          break;
        case '2':
          menuProdutos();
          break;
        case '3':
          menuCompras();
          break;
        case '4':
          mostrarHistoricoCompras();
          break;
        case '5':
          mostrarEstoqueProdutos();
          break;
        case '0':
          break;
        default:
          print('Opção inválida.');
      }
      if (opcao != '0') {
        stdout.write('Pressione Enter para continuar...');
        stdin.readLineSync();
      }
    } while (opcao != '0');
  }
}

void main() {
  Loja loja = Loja();
  loja.menuPrincipal();
}
