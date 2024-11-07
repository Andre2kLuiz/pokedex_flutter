
import 'package:pokedex_flutter/data/database/entity/pokemon_database_entity.dart';
import 'package:pokedex_flutter/domain/exception/mapper_exception.dart';
import 'package:pokedex_flutter/domain/pokemon.dart';

class DatabaseMapper {
  Pokemon toPokemon(PokemonDatabaseEntity entity) {
    try{    
      return Pokemon(
        id: entity.id,
        name: entity.name,
        type: entity.type,
        base: entity.base,
        imgUrl: entity.img_url,
      );
    } catch (e) {
      throw MapperException<PokemonDatabaseEntity, Pokemon>(e.toString());
    }
  }

  List<Pokemon> toPokemons(List<PokemonDatabaseEntity> entities){
    final List<Pokemon> pokemons = [];
    for (var pokemonEntity in entities) {
      pokemons.add(toPokemon(pokemonEntity));
    }
    return pokemons;
  }

   PokemonDatabaseEntity toPokemonDatabaseEntity(Pokemon pokemon){
    try{
      return PokemonDatabaseEntity(
          id: pokemon.id,
          name: pokemon.name,
          type: pokemon.type,
          base: pokemon.base,
          imgUrl: pokemon.imgUrl,
      );
    }catch (e){
      throw MapperException<PokemonDatabaseEntity, Pokemon>(e.toString());
    }
  }

  List<PokemonDatabaseEntity> toPokemonDatabaseEntities(List<Pokemon> pokemon){
    final List<PokemonDatabaseEntity> pokemonDatabaseEntities = [];
    for (var m in pokemon) {
      pokemonDatabaseEntities.add(toPokemonDatabaseEntity(m));
    }
    return pokemonDatabaseEntities;
  }
}