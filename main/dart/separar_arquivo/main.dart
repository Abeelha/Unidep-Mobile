import "carro.dart";

void main() {
  var velocidade = Carro(velocidadeAtual: 0);

  while (!velocidade.estaNaVelocidadeMaxima()) {
    print("Acelerando! ${velocidade.acelerar()}");
  }

  print("Velocidade Máxima: ${velocidade.velocidadeAtual}");

  while (velocidade.velocidadeAtual > 0) {
    print("Freando! ${velocidade.freio()}");
  }

  print("Velocidade Mínima: ${velocidade.velocidadeAtual}");
}
