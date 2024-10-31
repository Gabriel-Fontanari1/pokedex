import 'package:flutter/material.dart';
import 'package:pokedex/app/core/poke_model.dart';

class HomeGridview extends StatelessWidget {
  final List<PokeModel> pokemons;
  final Function(PokeModel) onRemove;

  const HomeGridview(
      {super.key, required this.pokemons, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.8,
      ),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        return PokemonItem(
          pokemon: pokemons[index],
          onRemove: onRemove,
        );
      },
    );
  }
}

class PokemonItem extends StatelessWidget {
  final PokeModel pokemon;
  final Function(PokeModel) onRemove;

  const PokemonItem({super.key, required this.pokemon, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('#${pokemon.id}'),
                Text(pokemon.name),
                Image.network(pokemon.getSprite),
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                onRemove(pokemon);
              },
            ),
          ),
        ],
      ),
    );
  }
}
