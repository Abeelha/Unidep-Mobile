import 'dart:io';

class Pessoa {
  String nome;
  int idade;
  String cpf;
  String genero;
  bool solteiro;

  Pessoa(this.nome, this.idade, this.cpf, this.genero, this.solteiro);

  @override
  String toString() {
    return 'Nome: $nome\nIdade: $idade\nCPF: $cpf\nGênero: $genero\nEstado civil: ${solteiro ? 'Solteiro(a)' : 'Casado(a)'}\n';
  }
}

void cadastrarPessoa() {
  print('--- Cadastro de Pessoa ---');
  print('Digite o nome:');
  String nome = stdin.readLineSync()!;
  print('Digite a idade:');
  int idade = int.parse(stdin.readLineSync()!);
  print('Digite o CPF:');
  String cpf = stdin.readLineSync()!;
  print('Digite o gênero:');
  String genero = stdin.readLineSync()!;
  print('A pessoa é solteira? (s/n):');
  bool solteiro = stdin.readLineSync()!.toLowerCase() == 's';

  Pessoa pessoa = Pessoa(nome, idade, cpf, genero, solteiro);

  salvarPessoa(pessoa);
}

void salvarPessoa(Pessoa pessoa) {
  File file = File('pessoas.txt');
  IOSink sink = file.openWrite(mode: FileMode.append);

  sink.write(
      '${pessoa.nome};${pessoa.idade};${pessoa.cpf};${pessoa.genero};${pessoa.solteiro ? 'solteiro' : 'casado'}\n');

  sink.close();
}

void verPessoasCadastradas() {
  File file = File('pessoas.txt');
  if (!file.existsSync()) {
    print('Nenhuma pessoa cadastrada ainda.');
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
    print(pessoa);
  }
}

void main() {
  bool sair = false;
  while (!sair) {
    print('Escolha uma opção:');
    print('1. Cadastrar Pessoa');
    print('2. Ver Pessoas Cadastradas');
    print('3. Sair');

    String? opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        cadastrarPessoa();
        break;
      case '2':
        verPessoasCadastradas();
        break;
      case '3':
        sair = true;
        break;
      default:
        print('Opção inválida');
    }
  }
}
