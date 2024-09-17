import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/screens/bottom_navigation.dart';
import 'dart:convert';

import '../models/pokemon.dart';
import 'pokemon_detail.dart';
import '../widgets/pokemon_tile.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({super.key});
  
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  List<Pokemon> _pokemons = [];
   String _searchQuery = ''; // String para armazenar o texto de pesquisa

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
      bottomNavigationBar: MyBottomNavigation()
    );
  }
  

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: [
  //       TextField(
  //         decoration: InputDecoration(labelText: 'Buscar por...'),
  //         onChanged: (value) {
  //           setState(() {
  //             _searchQuery = value;
  //           });
  //         },
  //       ),
  //       Expanded(
  //         child: ListView.builder(
  //           physics: const BouncingScrollPhysics(),
  //           itemCount: _pokemons.where((pokem) =>
  //               pokem.name.toLowerCase().contains(_searchQuery.toLowerCase()))
  //               .length, // Filtra a lista de acordo com a pesquisa
  //           itemBuilder: (context, index) {
  //             final filteredpokem = _pokemons.where((pokem) =>
  //                 pokem.name.toLowerCase().contains(_searchQuery.toLowerCase()))
  //                 .toList()[index]; // Pega o item filtrado da lista
  //             return PokemonTile(pokemon: filteredpokem);
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
