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
                _showConfirmationDialog(context);
              },
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

class PokemonsFiltrados {
  List<PokeModel> filtrarPokemons(
    List<PokeModel> pokemons,
    String nome,
    String tipo,
    String movimento,
  ) {
    return pokemons.where((pokemon) {
      final bool nomeMatch = nome.isEmpty ||
          pokemon.name.toLowerCase().contains(nome.toLowerCase());
      final bool tipoMatch = tipo.isEmpty ||
          pokemon.type.toLowerCase().contains(tipo.toLowerCase());
      final bool movimentoMatch = movimento.isEmpty ||
          pokemon.moves
              .any((m) => m.toLowerCase().contains(movimento.toLowerCase()));
      return nomeMatch && tipoMatch && movimentoMatch;
    }).toList();
  }
}

class DialogRemovePokemon extends StatelessWidget {
  final PokeModel pokemon;
  final Function() onConfirm;

  const DialogRemovePokemon(
      {super.key, required this.pokemon, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Deseja excluir o item?'),
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
