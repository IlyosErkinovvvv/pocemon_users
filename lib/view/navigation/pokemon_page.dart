import 'package:flutter/material.dart';
import 'package:pokemon_users/data/model/pokemon/pokemon_model.dart';
import 'package:pokemon_users/data/service/pokemon_service.dart';

class PokemonPage extends StatelessWidget {
  const PokemonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokemons"),
      ),
      body: FutureBuilder(
        future: PokemonService().getPokemon(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<Pokemon>? data =
                (snapshot.data as PokemonModel..pokemon) as List<Pokemon>?;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].name.toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
