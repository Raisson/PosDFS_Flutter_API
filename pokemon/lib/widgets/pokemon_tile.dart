import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/screens/bottom_navigation.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.network(pokemon['sprites']['front_default']),
                  Expanded( 
                    child: Column(
                      children: [
                        Text('Nome: ${pokemon['name']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('ID: ${pokemon['id']}'),
                        Text('Altura: ${pokemon['height']}'),
                        Text('Peso: ${pokemon['weight']}'),
                        Text('Tipos:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Wrap(
                          spacing: 8.0,
                          children: pokemon['types'].map<Widget>((type) => Chip(
                            label: Text(type['type']['name']),
                          )).toList(),
                        ),
                      ],
                    ),
                  ),
                  Image.network(pokemon['sprites']['back_default']),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(),
    );
  }
}