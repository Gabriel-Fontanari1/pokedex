import 'package:flutter/material.dart';
import 'package:pokedex/app/core/busca_poke.dart';
import 'package:pokedex/app/core/database/data_base.dart';
import 'package:pokedex/app/core/poke_model.dart';
import 'package:pokedex/app/modules/home_gridview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<PokeModel> _pokemons = [];
  final BuscaPoke _buscaPoke = BuscaPoke();
  final DataBase _database = DataBase.instance;

  @override
  void initState() {
    super.initState();
    _loadSavedPokemons();
  }

  Future<void> _loadSavedPokemons() async {
    final savedPokemons = await _database.getPokemons();
    setState(() {
      _pokemons.addAll(savedPokemons);
    });
  }

  void _searchPokemon(String searchTerm) async {
    try {
      final pokemon = await _buscaPoke.getPokemon(searchTerm);
      setState(() {
        _pokemons.add(pokemon);
      });
      await _database.insertPokemon(pokemon);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pokémon não encontrado: $searchTerm")),
      );
    }
  }

  void _removerPokemon(PokeModel pokemon) {
    setState(() {
      _pokemons.remove(pokemon);
      _database.deletePokemon(pokemon);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Procurar Pokémon'),
      ),
      body: Column(
        children: [
          SearchBar(onSearch: _searchPokemon),
          Expanded(
            child: HomeGridView(
              pokemons: _pokemons,
              onRemove: _removerPokemon,
            ),
          ),
        ],
      ),
    );
  }
}


class SearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const SearchBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        decoration: const InputDecoration(
          labelText: 'Procurar',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onSubmitted: onSearch,
      ),
    );
  }
}

