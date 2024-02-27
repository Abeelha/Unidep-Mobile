/* 
  07 - Crie uma variável chamada menor e atribua a ela um algoritmo que verifique o menor número entre 10, 20, e 30. Em seguida, imprima a variável.
  Aluno: Theodoro Bertol
*/

import 'dart:math';

void main() {
  int menor = min(min(10, 20), 30);

  // Imprime o menor número
  print(menor);
}
