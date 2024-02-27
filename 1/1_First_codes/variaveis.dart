// Variaveis de Dart
void main() {
  var teste_sem_tipagem = "teste de variavel sem tipar";
  print(teste_sem_tipagem);

  // Números inteiros
  int numeroInteiro = 10;
  print(numeroInteiro);

  // Números decimais
  double numeroDecimal = 3.14;
  print(numeroDecimal);

  // String
  String texto = "Olá, mundo!";
  print(texto);

  //Object
  Object materia = "MobileUnidep";
  print(materia);

  //Dynamic
  dynamic dinamicoVar = "Muda a tipagem para o tipo da variavel";
  print(dinamicoVar);
  dinamicoVar = 2 + 2;
  print(dinamicoVar);

  // Booleano
  bool estaChovendo = true;
  print(estaChovendo);

  // Registros (pares de valores)
  var registro = {'chave': 'valor'};
  print(registro);

  // Listas (arrays)
  List<int> listaDeNumeros = [1, 2, 3, 4, 5];
  print(listaDeNumeros);
  List<String> listaDeStrings = ['a', 'b', 'c'];
  print(listaDeStrings);

  // Conjuntos (sets)
  Set<int> conjuntoDeNumeros = {1, 2, 3, 4, 5};
  print(conjuntoDeNumeros);

  // Mapas (dicionários)
  Map<String, dynamic> mapaDePessoas = {
    'nome': 'João de Abacate',
    'idade': 33,
    'cidade': 'São Paulo'
  };
  print(mapaDePessoas);

  // Símbolo
  Symbol simbolo = #simbolo;
  print(simbolo);

  // Valor nulo
  dynamic valorNulo = null;
  print(valorNulo);

  // Caracteres (runes)
  Runes caracteres = Runes('\u{1F60A}'); // Representação de um emoji
  print(caracteres);
}
