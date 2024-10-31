class PokeModel {
  final String name;
  final int id;
  final String sprite;
  final String type;
  final List<String> moves;

  PokeModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        sprite = json['sprites']['other']['showdown']['front_default'] ?? '',
        type = json['types'][0]['type']['name'],
        moves = (json['moves'] as List)
            .map((e) => e['move']['name'] as String)
            .toList();

  String get getName => name;
  String get getSprite => sprite;
}
