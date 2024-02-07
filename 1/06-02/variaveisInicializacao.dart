void main() {
  // ? recebe valor nulo na variavel
  String? nome;

  //Utilizando para laço de repetição
  int rodar_codigo = 2;

  // Função para verificar se a variavel está nula, se sim
  // ela inicializa a mesma colocando o valor de "teste 123"
  while (rodar_codigo > 0) {
    if (nome == null) {
      print("Variável nula ou não inicializada");
      rodar_codigo -= 1;
      nome = "teste 123";
    } else {
      print("Variável tem o valor de $nome");
      rodar_codigo -= 1;
    }
  }
}
