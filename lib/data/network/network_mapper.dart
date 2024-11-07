import 'package:pokedex_flutter/domain/exception/mapper_exception.dart';
import 'package:pokedex_flutter/domain/pokemon.dart';

import 'entity/http_paged_result.dart';

class NetworkMapper {
  Pokemon toPokemon(PokemonEntity entity) {
    try {
      return Pokemon(
        id: entity.id,
        name: {
          'english': entity.name.english
        }, // Usando apenas a tradução em inglês
        type: entity.type,
        base: {
          'HP': entity.base.HP,
          'Attack': entity.base.Attack,
          'Defense': entity.base.Defense,
          'Sp. Attack': entity.base.SpAttack,
          'Sp. Defense': entity.base.SpDefense,
          'Speed': entity.base.Speed,
        },
       // Convertendo o Map em uma String
        imgUrl: entity.url,
      );
    } catch (e) {
      throw MapperException<PokemonEntity, Pokemon>(e.toString());
    }
  }

  List<Pokemon> toPokemons(List<PokemonEntity> entities) {
    final List<Pokemon> pokemons = [];
    for (var pokemonEntity in entities) {
      pokemons.add(toPokemon(pokemonEntity));
    }
    return pokemons;
  }
}
