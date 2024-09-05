import 'package:flutter/material.dart';
import 'screens/pokemon_list.dart';

void main() {
  runApp(PokeApp());
}


class PokeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeApp',
      theme: ThemeData ( // teste conflito 2
        primarySwatch: Colors.blue,
      ),
      home: PokemonList(),
    );
  }
}
