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
       initialRoute: '/home',
        routes: {
          '/home': (context) => const PokemonList(),
          //'/search': (context) => const SearchPage(),
        },
      home: PokemonList(),
    );
  }
}
