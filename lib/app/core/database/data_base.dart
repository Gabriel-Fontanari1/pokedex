import 'package:sqflite/sqflite.dart';
// ignore: unnecessary_import
import 'package:sqflite/sqlite_api.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

//vou resgatar os pokemons pela api, e manter no banco de dados, e usar querys para filtrar os pokemons
class DataBase {
  //construtor com um acesso privado
  DataBase._();

  //instancia do db
  static final DataBase instance = DataBase._();

  //instancia do sqlite
  static Database? _database;

  get database async {
    if (_database == null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'pokedex.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE pokemons(id INTEGER PRIMARY KEY, name TEXT, url TEXT, type TEXT, moves TEXT)');
  }

  String get createTable => '''
  CREATE TABLE pokemons(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, url TEXT, type TEXT, moves TEXT)
  ''';
}
