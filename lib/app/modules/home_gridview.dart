import 'package:flutter/material.dart';
import 'package:pokedex/app/core/poke_model.dart';

class HomeGridView extends StatelessWidget {
  final List<PokeModel> pokemons;
  final Function(PokeModel) onRemove;

  const HomeGridView({
    super.key,
    required this.pokemons,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.75,
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

  const PokemonItem({
    super.key,
    required this.pokemon,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '#${pokemon.id}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  pokemon.name,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Image.network(
                  pokemon.sprite,
                  height: 80,
                  width: 80,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.black),
              onPressed: () => _showConfirmationDialog(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogRemovePokemon(
          pokemon: pokemon,
          onConfirm: () {
            onRemove(pokemon);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class DialogRemovePokemon extends StatelessWidget {
  final PokeModel pokemon;
  final VoidCallback onConfirm;

  const DialogRemovePokemon({
    super.key,
    required this.pokemon,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Deseja remover o item?'),
      actions: [
        TextButton(
          onPressed: onConfirm,
          child: const Text('SIM'),
        ),
        TextButton(
          child: const Text('NÃO'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
