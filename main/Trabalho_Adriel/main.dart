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

class Loja {
  List<Cliente> clientes = [];
  List<Produto> produtos = [];
  Map<String, int> estoque = {};
  double totalVendas = 0.0;

  void adicionarCliente(String nome, String email) {
    clientes.add(Cliente(nome, email));
  }

  void carregarDados(String nomeArquivo) {
    File arquivo = File(nomeArquivo);
    if (!arquivo.existsSync()) {
      print('Arquivo não encontrado.');
      return;
    }

    List<String> linhas = arquivo.readAsLinesSync();

    for (var linha in linhas) {
      if (linha.startsWith('Cliente:')) {
        var dados = linha.split(', ');
        var nome = dados[0].split(': ')[1];
        var email = dados[1].split(': ')[1];
        this.adicionarCliente(nome, email);
      } else if (linha.startsWith('Produto:')) {
        var dados = linha.split(', ');
        var nome = dados[0].split(': ')[1];
        var preco = double.parse(dados[1].split(': ')[1]);
        var quantidade = int.parse(dados[2].split(': ')[1]);
        produtos.add(Produto(nome, preco, quantidade));
        estoque[nome] = quantidade;
      } else if (linha.startsWith('Total de Vendas:')) {
        totalVendas = double.parse(linha.split(': ')[1]);
      }
    }
  }

  void salvarDados(String nomeArquivo) {
    File arquivo = File(nomeArquivo);
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

    // Escrever total de vendas
    dados.writeln('Total de Vendas: $totalVendas');

    arquivo.writeAsStringSync(dados.toString());
    print('Dados salvos com sucesso no arquivo: $nomeArquivo');
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
}

void main() {
  Loja loja = Loja();
  loja.carregarDados('dados_loja.txt');

  var opcao;
  while (opcao != '0') {
    print('Menu:');
    print('1. Adicionar Cliente');
    print('2. Editar Cliente');
    print('3. Deletar Cliente');
    print('4. Visualizar Clientes');
    print('0. Sair');
    stdout.write('Escolha uma opção: ');
    opcao = stdin.readLineSync() ?? '';

    switch (opcao) {
      case '1':
        stdout.write('Nome do cliente: ');
        var nome = stdin.readLineSync();
        stdout.write('Email do cliente: ');
        var email = stdin.readLineSync();
        loja.adicionarCliente(nome ?? '', email ?? '');
        break;
      case '2':
        stdout.write('Email do cliente a ser editado: ');
        var emailAntigo = stdin.readLineSync() ?? '';
        stdout.write('Novo nome do cliente: ');
        var novoNome = stdin.readLineSync() ?? '';
        stdout.write('Novo email do cliente: ');
        var novoEmail = stdin.readLineSync() ?? '';
        loja.editarCliente(emailAntigo, novoNome, novoEmail);
        loja.salvarDados('dados_loja.txt');
        break;
      case '3':
        stdout.write('Email do cliente a ser deletado: ');
        var emailDeletar = stdin.readLineSync() ?? '';
        loja.deletarCliente(emailDeletar);
        loja.salvarDados('dados_loja.txt');
        break;
      case '4':
        loja.visualizarClientes();
        break;
      case '0':
        print('Saindo do programa...');
        break;
      default:
        print('Opção inválida.');
    }
  }
}
