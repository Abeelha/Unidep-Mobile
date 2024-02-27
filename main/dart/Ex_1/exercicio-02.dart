/* 
  02 - Impletar um algoritmo em que seja realizada as operações básicas bancárias.
    A - Realizar a saque de um determinado valor;
    B - Realizar um depósito de um determinado valor;
    C - Mostrar o extrato bancário de um determinado cliente.
	Aluno: Theodoro Bertol
*/
class ContaBancaria {
  String titular;
  double saldo;
  String nomeBanco;

  ContaBancaria(this.titular, this.saldo, this.nomeBanco);

  void sacar(double valor) {
    if (saldo >= valor) {
      saldo -= valor;
      print("Saque de $valor realizado com sucesso na conta $nomeBanco.");
    } else {
      print("Saldo insuficiente para realizar o saque na conta $nomeBanco.");
    }
  }

  void depositar(double valor) {
    saldo += valor;
    print("Depósito de $valor realizado com sucesso na conta $nomeBanco.");
  }

  void mostrarExtrato() {
    print("Extrato bancário de $titular na conta $nomeBanco:");
    print("Saldo atual: $saldo na conta $nomeBanco.");
  }
}

void main() {
  ContaBancaria conta = ContaBancaria("Theo", 1000.0, "Nubank");

  conta.sacar(500.0);
  conta.depositar(200.0);
  conta.mostrarExtrato();
}
