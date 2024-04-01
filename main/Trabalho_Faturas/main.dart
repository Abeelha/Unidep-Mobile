import 'dart:io'; // importa o faz tudo

//Adriel Souza
//Theo Bertol

Future<void> main() async {
  List<String> files = ['arquivo1.txt', 'arquivo2.txt']; // pegando arquivos
  double totalReceitas = 0.0, totalDespesas = 0.0; //inicizando variaveis

  for (String file in files) {
    List<String> lines =
        await File(file).readAsLines(); // le o arquivo linha por linha

    for (var i = 1; i < lines.length; i++) {
      var parts = lines[i].split(
          ', '); // ignora a primeira linha do cabeçalho assim como minha ex me ignorava :)

      totalReceitas +=
          double.parse(parts[1]); // convertendo e somando os valores
      totalDespesas +=
          double.parse(parts[2]); // convertendo e somando os valores
    }
  }

  double lucroTotal = totalReceitas - totalDespesas; //soma as parada

  ///gera relatorio
  String relatorio = '''
Relatório Financeiro da Empresa

Período Analisado: ${files.first.split('.').first} - ${files.last.split('.').first}

Total de Receitas: R\$ ${totalReceitas.toStringAsFixed(2)}
Total de Despesas: R\$ ${totalDespesas.toStringAsFixed(2)}
Lucro Total: R\$ ${lucroTotal.toStringAsFixed(2)}
''';

  // a porra da IDE ta salvando e identando codigo abaixo tudo errado... mas deixa assim

  await File('relatorio.txt')
      .writeAsString(relatorio); // taca o relatorio em strring
  print(
      'Relatório gerado com sucesso.'); // parabens, nao deu erro no codigo, boa noite vou dormir
}
