import 'package:flutter/material.dart';
import 'package:pokedex/app/core/busca_poke.dart';
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

  void _searchPokemon(String searchTerm) async {
    try {
      final pokemon = await _buscaPoke.getPokemon(searchTerm);
      setState(() {
        _pokemons.add(pokemon);
      });
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
          const TituloFiltro(),
          const Filtros(),
          Expanded(
            child: HomeGridview(pokemons: _pokemons, onRemove: _removerPokemon),
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
        onSubmitted: (searchTerm) {
          onSearch(searchTerm);
        },
      ),
    );
  }
}


class TituloFiltro extends StatelessWidget {
  const TituloFiltro({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(8.0),
      child: const Text('Filtros'),
    );
  }
}

class Filtros extends StatelessWidget {
  const Filtros({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
                hintText: 'Digite o nome',
              ),
            ),
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Tipo',
                border: OutlineInputBorder(),
                hintText: 'Digite o tipo',
              ),
            ),
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Movimentos',
                border: OutlineInputBorder(),
                hintText: 'Digite o movimento',
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Filtrar'),
            ),
          ),
        )
      ],
    );
  }
}
