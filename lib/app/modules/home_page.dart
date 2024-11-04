// home_page.dart

import 'package:flutter/material.dart';
import 'package:pokedex/app/core/busca_poke.dart';
import 'package:pokedex/app/core/database/data_base.dart';
import 'package:pokedex/app/core/database/poke_query.dart';
import 'package:pokedex/app/core/poke_model.dart';
import 'package:pokedex/app/modules/home_gridview.dart';
import 'package:pokedex/app/modules/home_filter.dart'; 

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

  void _applyFilter(String name, String type, String move) async {
    final filteredPokemons = await getFilteredPokemons(
      name: name,
      type: type,
      move: move,
    );

    setState(() {
      _pokemons.clear();
      _pokemons.addAll(filteredPokemons);
    });

    if (filteredPokemons.isEmpty) {
      _showNoResultsDialog(name, type, move);
    }
  }

  void _showNoResultsDialog(String name, String type, String move) {
    String causeOfError = '';

    if (name.isNotEmpty && type.isEmpty && move.isEmpty) {
      causeOfError = 'Erro ao filtrar pelo Nome';
    } else if (type.isNotEmpty && name.isEmpty && move.isEmpty) {
      causeOfError = 'Erro ao filtrar pelo Tipo';
    } else if (move.isNotEmpty && name.isEmpty && type.isEmpty) {
      causeOfError = 'Erro ao filtrar por Movimentos';
    } else {
      causeOfError = 'Critérios inválidos nos filtros aplicados';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ocorreu um erro ao filtrar:'),
          content: Text(causeOfError),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
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
          const SizedBox(height: 8),
          Filtros(onFilterApplied: _applyFilter),
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
