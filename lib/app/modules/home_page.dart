import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

//titulo do app
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Procurar Pokemon'),
      ),
      body: const Column(
        children: [
          SearchBar(),
          TituloFiltro(),
          Filtros(),
          Expanded(
            child: Center(
              child: Text(''),
            ),
          ),
        ],
      ),
    );
  }
}

//barra de busca para procurar os pokemons pelo nome ou id
class SearchBar extends StatelessWidget {
  const SearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Procurar',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onSubmitted: (searchTerm) {
          // Lógica para buscar os pokemons pelo termo de busca
        },
      ),
    );
  }
}

//filtros
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
        //botão para confirmar os filtros
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
