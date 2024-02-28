class Carro {
  final String? modelo;

  //CONSTRUCTOR
  Carro({this.modelo});

  int valor = 10000;

  //GETTER
  int? get getValor => valor;

  //SETTER
  void setValor(int valor) => this.valor = valor;
}

void main() {
  Carro fiat = Carro(modelo: "Fiat Uno");
  Carro volts = Carro(modelo: "Volts Motors");

  fiat.setValor(100);
  volts.setValor(200);
  print("${fiat.getValor}");
  print("${volts.getValor}");
}
