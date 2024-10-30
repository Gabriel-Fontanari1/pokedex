//classe que vai ser uma gridview para exibir uma lista de pokemons, que vão ser adicionados pelo usuario no botão de buscar
//não vai ser uma tela nova, vai ser inserido na pagehome
import 'package:flutter/material.dart';
import 'package:pokedex/app/core/poke_model.dart';

class HomeGridview extends StatelessWidget {
  const HomeGridview({super.key});

  @override
  Widget build(BuildContext context) {
    List<PokeModel> pokemons = [];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        return PokemonItem(pokemon: pokemons[index]);
      },
    );
  }
}

class PokemonItem extends StatelessWidget {
  final PokeModel pokemon;

  const PokemonItem({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(pokemon.getSprite),
          Text(pokemon.getName),
        ],
      ),
    );
  }
}
