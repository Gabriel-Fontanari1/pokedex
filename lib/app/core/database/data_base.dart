import 'package:pokedex/app/core/poke_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DataBase {
  DataBase._();
  static final DataBase instance = DataBase._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'pokedex.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE pokemons(id INTEGER PRIMARY KEY, name TEXT, sprite TEXT, type TEXT, moves TEXT)',
    );
  }

  Future<void> insertPokemon(PokeModel pokemon) async {
    final db = await database;
    await db.insert(
      'pokemons',
      pokemon.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //remover pokemon
  Future<void> deletePokemon(PokeModel pokemon) async {
    final db = await database;
    await db.delete(
      'pokemons',
      where: 'id = ?',
      whereArgs: [pokemon.id],
    );
  }

  Future<List<PokeModel>> getPokemons() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pokemons');

    return List.generate(maps.length, (i) {
      return PokeModel.fromMap(maps[i]);
    });
  }
}
