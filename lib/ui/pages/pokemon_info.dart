import 'package:flutter/material.dart';
import 'package:pokedex_flutter/domain/pokemon.dart';

class PokemonInfo extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonInfo({super.key, required this.pokemon});

  Color _getBackgroundColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.redAccent;
      case 'water':
        return Colors.blueAccent;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.yellow;
      case 'psychic':
        return Colors.purple;
      case 'rock':
        return Colors.brown;
      case 'ground':
        return Colors.orangeAccent;
      case 'ice':
        return Colors.lightBlueAccent;
      case 'fighting':
        return Colors.orange;
      case 'poison':
        return Colors.purpleAccent;
      case 'bug':
        return Colors.lightGreen;
      case 'ghost':
        return Colors.deepPurple;
      case 'dragon':
        return Colors.indigo;
      case 'dark':
        return Colors.grey;
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pinkAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
     final backgroundColor = pokemon.type.isNotEmpty
        ? _getBackgroundColor(pokemon.type.first)
        : Colors.grey;
    // Definindo o valor máximo que um status pode ter (pode ser ajustado)
    const int maxStatusValue = 255;

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name['english'] ?? 'Unknown'),
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exibindo a imagem do Pokémon
            if (pokemon.imgUrl != null)
              Center(
                child: Image.network(
                  pokemon.imgUrl!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 16),
            Text(
              "Base Status",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(height: 8),

            // Exibindo cada status como uma barra de progresso
            ...pokemon.base.entries.map((entry) {
              double progress = entry.value / maxStatusValue;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${entry.key}: ${entry.value}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: progress.clamp(0.0, 1.0),
                      minHeight: 8,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
