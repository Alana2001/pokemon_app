import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pokemon_model.dart';
import '../services/pokemon_service.dart';
import '../providers/pokemon_provider.dart';
import 'favorite_pokemon_screen.dart';

class PokemonListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokemonProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pokémon:'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritoPokemonScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: PokemonService().fetchPokemons(),
        builder: (context, AsyncSnapshot<List<Pokemon>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados'));
          }
          List<Pokemon> pokemons = snapshot.data ?? [];
          return ListView.builder(
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              Pokemon pokemon = pokemons[index];
              bool isFavorite = provider.isFavorito(pokemon);
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(pokemon.imageUrl),
                ),
                title: Text(pokemon.name),
                trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    if (isFavorite) {
                      provider.removeFavorito(pokemon);
                    } else {
                      provider.addFavorito(pokemon);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
