class Pai {
  String? falar() {
    return "Gírias";
  }
}

class Filho extends Pai {}

void main() {
  Filho filho = Filho();
  print(filho.falar());
}
