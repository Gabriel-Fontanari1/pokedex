class PokeModel {
  final String name;
  final int id;
  final String sprite;
  final String type;
  final List<String> moves;

  PokeModel({
    required this.name,
    required this.id,
    required this.sprite,
    required this.type,
    required this.moves,
  });

  PokeModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        sprite = json['sprites']['other']['showdown']['front_default'] ?? '',
        type = json['types'][0]['type']['name'],
        moves = (json['moves'] as List).map((e) => e['move']['name'] as String).toList();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sprite': sprite,
      'type': type,
      'moves': moves.join(','),
    };
  }

  factory PokeModel.fromMap(Map<String, dynamic> map) {
    return PokeModel(
      id: map['id'],
      name: map['name'],
      sprite: map['sprite'],
      type: map['type'],
      moves: map['moves'].split(','),
    );
  }
}
