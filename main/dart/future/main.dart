void main() async {
  Future<String> cepFuture = buscarCepPeloNome("Rua Brasil");

  late String cep;
  cep = await cepFuture.get();
  print(cep);
}

Future<String> buscarCepPeloNome(String nomeRua) {
  if (nomeRua == "Rua Brasil") {
    return Future.value("58441-238");
  }

  return Future.value("CEP Não encontrado");
}
