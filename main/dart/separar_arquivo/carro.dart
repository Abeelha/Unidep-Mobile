void main() {
  print("\x1B[2J\x1B[0;0H");
}

class Carro {
  final int velocidadeMaxima;
  int velocidadeAtual;

  Carro({this.velocidadeMaxima = 200, this.velocidadeAtual = 0});

  int acelerar() {
    if (velocidadeAtual + 5 > velocidadeMaxima) {
      velocidadeAtual = velocidadeMaxima;
    } else {
      velocidadeAtual += 5;
    }
    return velocidadeAtual;
  }

  int freio() {
    if (velocidadeAtual - 5 < 0) {
      velocidadeAtual = 0;
    } else {
      velocidadeAtual -= 5;
    }
    return velocidadeAtual;
  }

  bool estaNaVelocidadeMaxima() {
    return velocidadeAtual == velocidadeMaxima;
  }
}
