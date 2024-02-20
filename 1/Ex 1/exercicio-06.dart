/* 
  06 - Crie uma variável chamada maior e atribua a ela um algoritmo que verifique o maior número entre 10, 20, e 30. Em seguida, imprima a variável.
  Aluno: Theodoro Bertol
*/
import 'dart:math';

void main() {
  int maior = max(10, max(20, 30));
  print("O maior número é: $maior");
}
