// home_filter.dart

import 'package:flutter/material.dart';

class TituloFiltro extends StatelessWidget {
  const TituloFiltro({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Text(
        'Filtros',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class Filtros extends StatefulWidget {
  final Function(String, String, String) onFilterApplied;

  const Filtros({super.key, required this.onFilterApplied});

  @override
  State<Filtros> createState() => _FiltrosState();
}

class _FiltrosState extends State<Filtros> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _movController = TextEditingController();

  void _applyFilters() {
    widget.onFilterApplied(
      _nomeController.text,
      _tipoController.text,
      _movController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TituloFiltro(),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _tipoController,
                    decoration: const InputDecoration(
                      labelText: 'Tipo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _movController,
                    decoration: const InputDecoration(
                      labelText: 'Movimentos',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                  onPressed: _applyFilters,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.grey[800]),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    minimumSize: WidgetStateProperty.all(const Size(200, 40)),
                  ),
                  child: const Text('Filtrar'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
