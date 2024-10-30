class PokeModel {
  String name;
  int id;
  String sprite;
  String type;
  //lista de movs
  List<String> moves;

  PokeModel(
      {required this.name,
      required this.id,
      required this.sprite,
      required this.type,
      required this.moves});

  //getters e setters

  set setMoves(List<String> moves) {
    this.moves = moves;
  }

  List<String> get getMoves => moves;

  set setSprite(String sprite) {
    this.sprite = sprite;
  }

  String get getSprite => sprite;

  set setType(String type) {
    this.type = type;
  }

  String get getType => type;

  set setId(int id) {
    this.id = id;
  }

  int get getId => id;

  set setName(String name) {
    this.name = name;
  }

  String get getName => name;
}
