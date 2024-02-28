class Data {
  int? dia;
  int? mes;
  int? ano;

  Data() {
    this.ano = 2077;
    this.mes = 05;
    this.dia = 19;
  }
}

var dataAtual = Data();
void main() {
  print(dataAtual.dia);
  print(dataAtual.mes);
  print(dataAtual.ano);
}
