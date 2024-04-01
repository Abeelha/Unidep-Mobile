import 'dart:io';

void main() async {
  final List<String> fileNames = ['arquivo1.txt', 'arquivo2.txt'];
  List<Map<String, dynamic>> financialData = [];

  // Leitura dos dados dos arquivos
  for (var fileName in fileNames) {
    final file = File(fileName);
    List<String> lines = await file.readAsLines();
    // Ignora o cabeçalho
    lines.removeAt(0);
    lines.forEach((line) {
      final data = line.split(', ');
      financialData.add({
        'Data': data[0],
        'Receitas': double.parse(data[1]),
        'Despesas': double.parse(data[2]),
      });
    });
  }

  // Cálculo dos totais
  double totalReceitas = financialData.fold(
      0, (previousValue, element) => previousValue + element['Receitas']);
  double totalDespesas = financialData.fold(
      0, (previousValue, element) => previousValue + element['Despesas']);
  double lucroTotal = totalReceitas - totalDespesas;

  // Geração do relatório
  String report = '''
Relatório Financeiro da Empresa

Período Analisado: ${financialData.first['Data']} - ${financialData.last['Data']}

Total de Receitas: R\$ ${totalReceitas.toStringAsFixed(2)}
Total de Despesas: R\$ ${totalDespesas.toStringAsFixed(2)}
Lucro Total: R\$ ${lucroTotal.toStringAsFixed(2)}
''';

  // Escrita do relatório em um novo arquivo
  final reportFile = File('relatorio.txt');
  await reportFile.writeAsString(report);

  print('Relatório gerado com sucesso!');
}
