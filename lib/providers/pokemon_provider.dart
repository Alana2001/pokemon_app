import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';

class PokemonProvider extends ChangeNotifier {
  List<Pokemon> _favoritoPokemons = [];

  List<Pokemon> get favoritoPokemons => _favoritoPokemons;

  void addFavorito(Pokemon pokemon) {
    _favoritoPokemons.add(pokemon);
    notifyListeners();
  }

  void removeFavorito(Pokemon pokemon) {
    _favoritoPokemons.remove(pokemon);
    notifyListeners();
  }

  bool isFavorito(Pokemon pokemon) {
    return _favoritoPokemons.contains(pokemon);
  }
}
