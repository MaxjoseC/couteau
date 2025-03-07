import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonView extends StatefulWidget {
  const PokemonView({super.key});

  @override
  _PokemonViewState createState() => _PokemonViewState();
}

class _PokemonViewState extends State<PokemonView> {
  String pokemonName = '';
  String imageUrl = '';
  int baseExperience = 0;
  List<String> abilities = [];

  Future<void> fetchPokemon() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        imageUrl = data['sprites']['front_default'];
        baseExperience = data['base_experience'];
        abilities = List<String>.from(data['abilities'].map((ability) => ability['ability']['name']));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Pokémon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  pokemonName = value.toLowerCase();
                });
              },
              decoration: InputDecoration(labelText: 'Nombre del Pokémon'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchPokemon,
              child: Text('Buscar Pokémon'),
            ),
            SizedBox(height: 20),
            if (imageUrl.isNotEmpty) Image.network(imageUrl, width: 200, height: 200),
            Text('Experiencia Base: $baseExperience'),
            Text('Habilidades: ${abilities.join(", ")}'),
          ],
        ),
      ),
    );
  }
}