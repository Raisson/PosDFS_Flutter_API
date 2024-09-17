
import 'package:flutter/material.dart';
import 'package:pokemon/screens/bottom_navigation.dart';
import '../models/pokemon.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetail({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: Center(
        child: Text('Details of ${pokemon.name}'),
      ),
      bottomNavigationBar: MyBottomNavigation()
    );
  }
}
