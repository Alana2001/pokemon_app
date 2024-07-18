import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokemonService {
  final String baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<Pokemon>> fetchPokemons() async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon?limit=151'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Pokemon> pokemons = [];
      for (var pokemon in data['results']) {
        String name = pokemon['name'];
        String url = pokemon['url'];
        int id = int.parse(url.split('/').reversed.elementAt(1));
        String imageUrl =
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
        pokemons.add(Pokemon(id: id, name: name, imageUrl: imageUrl));
      }
      return pokemons;
    } else {
      throw Exception('Falha ao carregar dados do PokeAPI');
    }
  }
}
