import 'dart:io';

class Pessoa {
  late String nome;
  late int idade;
  late String cpf;
  late String genero;
  late bool solteiro;

  Pessoa(this.nome, this.idade, this.cpf, this.genero, this.solteiro);

  @override
  String toString() {
    String generoString = '';
    switch (genero) {
      case '1':
        generoString = 'Feminino';
        break;
      case '2':
        generoString = 'Masculino';
        break;
      case '3':
        generoString = 'Neutro';
        break;
      case '4':
        generoString = 'Outro';
        break;
      default:
        generoString = 'Desconhecido';
    }
    return 'Nome: $nome\nIdade: $idade\nCPF: $cpf\nGênero: $generoString\nEstado civil: ${solteiro ? 'Solteiro(a)' : 'Casado(a)'}\n';
  }
}

class CadastroPessoa {
  late List<Pessoa> pessoas;

  CadastroPessoa() {
    pessoas = [];
    _carregarDados();
  }

  void _carregarDados() {
    File file = File('pessoas.txt');
    if (!file.existsSync()) {
      return;
    }

    List<String> linhas = file.readAsLinesSync();

    for (String linha in linhas) {
      List<String> dados = linha.split(';');
      String nome = dados[0];
      int idade = int.parse(dados[1]);
      String cpf = dados[2];
      String genero = dados[3];
      bool solteiro = dados[4] == 'solteiro';

      Pessoa pessoa = Pessoa(nome, idade, cpf, genero, solteiro);
      pessoas.add(pessoa);
    }
  }

  void _salvarDados() {
    File file = File('pessoas.txt');
    IOSink sink = file.openWrite();

    for (Pessoa pessoa in pessoas) {
      sink.write(
          '${pessoa.nome};${pessoa.idade};${pessoa.cpf};${pessoa.genero};${pessoa.solteiro ? 'solteiro' : 'casado'}\n');
    }

    sink.close();
  }

  void cadastrarPessoa(Pessoa pessoa) {
    pessoas.add(pessoa);
    _salvarDados();
  }

  void editarPessoa(String cpf, Pessoa pessoaEditada) {
    Pessoa? pessoaEncontrada = encontrarPessoaPorCPF(cpf);
    if (pessoaEncontrada != null) {
      pessoaEncontrada.nome = pessoaEditada.nome;
      pessoaEncontrada.idade = pessoaEditada.idade;
      pessoaEncontrada.genero = pessoaEditada.genero;
      pessoaEncontrada.solteiro = pessoaEditada.solteiro;
      _salvarDados();
      print('Pessoa editada com sucesso.');
    } else {
      print('CPF não encontrado.');
    }
  }

  void excluirPessoa(String cpf) {
    Pessoa? pessoaEncontrada = encontrarPessoaPorCPF(cpf);
    if (pessoaEncontrada != null) {
      pessoas.remove(pessoaEncontrada);
      _salvarDados();
      print('Pessoa excluída com sucesso.');
    } else {
      print('CPF não encontrado.');
    }
  }

  Pessoa? encontrarPessoaPorCPF(String cpf) {
    return pessoas.firstWhere((pessoa) => pessoa.cpf == cpf,
        orElse: () => null);
  }

  void listarPessoas() {
    for (Pessoa pessoa in pessoas) {
      print(pessoa);
    }
  }
}

void main() {
  CadastroPessoa cadastro = CadastroPessoa();

  bool sair = false;
  while (!sair) {
    print('Escolha uma opção:');
    print('1. Cadastrar Pessoa');
    print('2. Editar Pessoa');
    print('3. Excluir Pessoa');
    print('4. Ver Pessoas Cadastradas');
    print('5. Sair');

    String? opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        cadastrarPessoa(cadastro);
        break;
      case '2':
        editarPessoa(cadastro);
        break;
      case '3':
        excluirPessoa(cadastro);
        break;
      case '4':
        cadastro.listarPessoas();
        break;
      case '5':
        sair = true;
        break;
      default:
        print('Opção inválida');
    }
  }
}

void cadastrarPessoa(CadastroPessoa cadastro) {
  print('--- Cadastro de Pessoa ---');
  print('Digite o nome:');
  String nome = stdin.readLineSync()!;
  print('Digite a idade:');
  int idade = int.parse(stdin.readLineSync()!);
  print('Digite o CPF:');
  String cpf = stdin.readLineSync()!;
  print(
      'Digite o gênero (1 - Feminino, 2 - Masculino, 3 - Neutro, 4 - Outro):');
  String genero = stdin.readLineSync()!;
  print('A pessoa é solteira? (s/n):');
  bool solteiro = stdin.readLineSync()!.toLowerCase() == 's';

  Pessoa novaPessoa = Pessoa(nome, idade, cpf, genero, solteiro);

  if (cadastro.encontrarPessoaPorCPF(cpf) != null) {
    print('CPF já cadastrado.');
  } else {
    cadastro.cadastrarPessoa(novaPessoa);
    print('Pessoa cadastrada com sucesso.');
  }
}

void editarPessoa(CadastroPessoa cadastro) {
  print('Digite o CPF da pessoa que deseja editar:');
  String cpf = stdin.readLineSync()!;
  Pessoa? pessoaEncontrada = cadastro.encontrarPessoaPorCPF(cpf);

  if (pessoaEncontrada != null) {
    print('Digite o novo nome:');
    String novoNome = stdin.readLineSync()!;
    print('Digite a nova idade:');
    int novaIdade = int.parse(stdin.readLineSync()!);
    print(
        'Digite o novo gênero (1 - Feminino, 2 - Masculino, 3 - Neutro, 4 - Outro):');
    String novoGenero = stdin.readLineSync()!;
    print('A pessoa é solteira? (s/n):');
    bool novoEstadoCivil = stdin.readLineSync()!.toLowerCase() == 's';

    Pessoa pessoaEditada =
        Pessoa(novoNome, novaIdade, cpf, novoGenero, novoEstadoCivil);

    cadastro.editarPessoa(cpf, pessoaEditada);
  } else {
    print('CPF não encontrado.');
  }
}

void excluirPessoa(CadastroPessoa cadastro) {
  print('Digite o CPF da pessoa que deseja excluir:');
  String cpf = stdin.readLineSync()!;
  cadastro.excluirPessoa(cpf);
}
