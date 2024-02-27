import 'dart:io';

void main() {
  print('Hello, World!');
  print("Calculadora Simples");
  print("Entre o primeiro numero:");
  double num1 = double.parse(stdin.readLineSync()!);

  print("Entre segudo number:");
  double num2 = double.parse(stdin.readLineSync()!);

  print("Entre operador (+, -, *, /):");
  String operator = stdin.readLineSync()!;

  double result = 0;

  switch (operator) {
    case '+':
      result = num1 + num2;
      break;
    case '-':
      result = num1 - num2;
      break;
    case '*':
      result = num1 * num2;
      break;
    case '/':
      if (num2 != 0) {
        result = num1 / num2;
      } else {
        print("Error: Dividindo por zero");
        return;
      }
      break;
    default:
      print("Error: Operador invalido");
      return;
  }

  print("Result: $result");
}
