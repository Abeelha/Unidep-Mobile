/* 
  08 -Escreva um programa que pergunte a idade do usuário e imprima se ele tem idade suficiente para votar (18 anos ou mais) ou não.
  Aluno: Theodoro Bertol
*/
import 'dart:io';

void main() {
  // Solicita a idade do usuário
  print("Qual é a sua idade?");
  int idade = int.parse(stdin.readLineSync()!);

  String mensagem = (idade >= 18)
      ? "Você tem idade suficiente para votar e ser responsabilizado criminalmente."
      : "Você não tem idade suficiente para votar e ser responsabilizado criminalmente.";

  // Imprime a mensagem
  print(mensagem);
}
