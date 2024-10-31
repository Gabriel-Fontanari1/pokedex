import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/app/core/poke_model.dart';

class BuscaPoke {
  final String _baseUrl = 'https://pokeapi.co/api/v2/pokemon/';

  Future<PokeModel> getPokemon(String nameOrId) async {
    final response = await http.get(Uri.parse('$_baseUrl$nameOrId'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return PokeModel.fromJson(json);
    } else {
      throw Exception('Pokémon não encontrado');
    }
  }
}
