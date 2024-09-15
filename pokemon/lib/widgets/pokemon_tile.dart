import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

class PokemonTile extends StatelessWidget {
  final Pokemon pokemon;

  PokemonTile({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchPokemonData(pokemon),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final pokemonData = snapshot.data!;
          final pokemonName = pokemonData['name'];
          final spriteUrl = pokemonData['sprites']['front_default'];
          return ListTile(
            leading: Image.network(spriteUrl),
            title: Text(pokemonName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonDetail(pokemon: pokemonData),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<Map<String, dynamic>> fetchPokemonData(pokemon) async {
    final response = await http.get(Uri.parse(pokemon.url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load pokemon data');
    }
  }
}

class PokemonDetail extends StatelessWidget {
  final Map<String, dynamic> pokemon;

  PokemonDetail({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon['name']),
      ),
      body: Center(
        child: Image.network(pokemon['sprites']['front_default']),
      ),
    );
  }
}