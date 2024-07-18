import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pokemon_provider.dart';
import '../models/pokemon_model.dart';

class FavoritoPokemonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokemonProvider>(context);
    List<Pokemon> favoritoPokemons = provider.favoritoPokemons;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon favoritos:'),
      ),
      body: ListView.builder(
        itemCount: favoritoPokemons.length,
        itemBuilder: (context, index) {
          Pokemon pokemon = favoritoPokemons[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(pokemon.imageUrl),
            ),
            title: Text(pokemon.name),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                provider.removeFavorito(pokemon);
              },
            ),
          );
        },
      ),
    );
  }
}
