/* 
  09 - Escreve um programa que leia a nota de 5 alunos, e imprima se cada aluno está aprovado ou reprovado de acordo com a sua nota.
  Aluno: Theodoro Bertol
*/

import 'dart:io';

void main() {
  List<double> notas = [];

  for (int i = 1; i <= 5; i++) {
    stdout.write("Digite a nota do aluno $i: ");
    double nota = double.parse(stdin.readLineSync()!);
    notas.add(nota);
  }

  notas.asMap().forEach((index, nota) {
    print("Aluno ${index + 1} está ${nota >= 6 ? 'aprovado' : 'reprovado'}.");
  });
}
