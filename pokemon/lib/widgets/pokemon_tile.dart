// lib/widgets/pokemon_tile.dart
import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../screens/pokemon_detail.dart';

class PokemonTile extends StatelessWidget {
  final Pokemon pokemon;

  PokemonTile({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(pokemon.name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetail(pokemon: pokemon),
          ),
        );
      },
    );
  }
}
