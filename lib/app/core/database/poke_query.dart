import 'package:pokedex/app/core/database/data_base.dart';
import 'package:pokedex/app/core/poke_model.dart';

Future<List<PokeModel>> getFilteredPokemons({
  String? name,
  String? type,
  String? move,
}) async {
  final db = await DataBase.instance.database;

  List<String> conditions = [];
  List<dynamic> args = [];

  if (name != null && name.isNotEmpty) {
    conditions.add('name LIKE ?');
    args.add('%$name%');
  }

  if (type != null && type.isNotEmpty) {
    conditions.add('type = ?');
    args.add(type);
  }

  if (move != null && move.isNotEmpty) {
    conditions.add('moves LIKE ?');
    args.add('%$move%');
  }

  final whereClause = conditions.isNotEmpty ? conditions.join(' AND ') : null;

  final List<Map<String, dynamic>> maps = await db.query(
    'pokemons',
    where: whereClause,
    whereArgs: args,
  );

  return List.generate(maps.length, (i) {
    return PokeModel.fromMap(maps[i]);
  });
}
