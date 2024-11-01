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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '#${pokemon.id}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Image.network(
            pokemon.sprite,
            height: 80,
            width: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          Text(
            pokemon.name,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.black),
            onPressed: () => _showConfirmationDialog(context),
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
  final Function() onConfirm;

  const DialogRemovePokemon({
    super.key,
    required this.pokemon,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remover Pokémon'),
      content: const Text('Deseja remover o item?'),
      actions: [
        TextButton(
          onPressed: onConfirm,
          child: const Text('SIM'),
        ),
        TextButton(
          child: const Text('NÃO'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
