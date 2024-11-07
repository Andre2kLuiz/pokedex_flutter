import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/domain/pokemon.dart';
import 'package:pokedex_flutter/ui/pages/pokemon_info.dart';

class PokemonEquipeCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonEquipeCard({super.key, required this.pokemon});

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
        return Colors.grey; // Cor padrão se o tipo não for reconhecido
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = pokemon.type.isNotEmpty
        ? _getBackgroundColor(pokemon.type.first)
        : Colors.grey;

    return Card(
      elevation: 5,
      color: backgroundColor,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PokemonInfo(pokemon: pokemon),
            ),
          );
        },
        child: Row(
          children: [
            if (pokemon.imgUrl != null)
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 100,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(imageUrl: pokemon.imgUrl!),
                ),
              ),
            )
          else
            const Icon(
              Icons.image_not_supported,
              size: 100,
              color: Colors.black,
            ),
            Flexible(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.name['english'] ?? 'Unknown',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white, // Cor do texto ajustada para visibilidade
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pokemon.type.join(', '),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white, // Cor do texto ajustada para visibilidade
                        ),
                  ),
                ],
              ),
            ),
          ),
          ],
        ),
      )
    );
  }
}