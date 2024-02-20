/* 
  01 - Implementar um algoritmo que verifique se um determinado número é par ou ímpar.
  Aluno: Theodoro Bertol
*/

void main() {
  List<int> listaDeNumeros = [7, 14, 21, 36, 48]; // Altere os números aqui para testar
  int numero_teste = 5;
  verificarParImpar(numero_teste);
  verificarParImparLista(listaDeNumeros);
  
  var numero01 = 3;
  var numero02 = 2;
  
  calcularParImpar(numero01,numero02);
}

void calcularParImpar(num1, num2){
  
  //Forma NOOB / INICIANTE
  var restoDivisao = num1 % num2;
  
  print("A resto da divisão de $num1 % $num2 é: $restoDivisao");
  print("Se o Resultado da divisão for 0, ele é par");
  print("Se o Resultado da divisão for diferente de 0, ele é impar");
}

void verificarParImpar(numero) {
  
 //Forma "Aprendendo"
 if (numero % 2 == 0) {
    print('$numero é um número par.');
  } else {
    print('$numero é um número ímpar.');
  }
}

void verificarParImparLista(List<int> numeros) {
  
  //Forma "Dev Senior kkkk"
  for (int numero in numeros) {
    if (numero % 2 == 0) {
      print('$numero é um número par.');
    } else {
      print('$numero é um número ímpar.');
    }
  }
}


