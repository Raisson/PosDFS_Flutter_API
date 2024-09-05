import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/pokemon.dart';
import 'pokemon_detail.dart';
import '../widgets/pokemon_tile.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  List<Pokemon> _pokemons = [];

  @override
  void initState() {
    super.initState();
    _fetchPokemons();
  }

  Future<void> _fetchPokemons() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=100'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];

      setState(() {
        _pokemons = results.map((e) => Pokemon.fromJson(e)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon List'),
      ),
      body: ListView.builder(
        itemCount: _pokemons.length,
        itemBuilder: (context, index) {
          return PokemonTile(pokemon: _pokemons[index]);
        },
      ),
    );
  }
}
