import 'dart:math';
import 'package:pokedex_flutter/data/database/dao/pokemon_dao.dart';
import 'package:pokedex_flutter/data/database/database_mapper.dart';
import 'package:pokedex_flutter/data/database/entity/pokemon_database_entity.dart';
import 'package:pokedex_flutter/data/network/client/api_client.dart';
import 'package:pokedex_flutter/data/network/network_mapper.dart';
import 'package:pokedex_flutter/data/repository/pokemon_repository.dart';
import '../../domain/pokemon.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final ApiClient apiClient;
  final NetworkMapper networkMapper;
  final PokemonDao pokemonDao;
  final DatabaseMapper databaseMapper;

  PokemonRepositoryImpl({
    required this.pokemonDao,
    required this.databaseMapper,
    required this.apiClient,
    required this.networkMapper,
  });

  @override
  Future<List<Pokemon>> getPokemons({required int page, required int limit}) async {
    // Tentar carregar a partir do banco de dados
    final dbEntities = await pokemonDao.selectAll(limit: limit, offset: (page * limit) - limit);

    // Se o dado já existe, carregar esse dado
    if (dbEntities.isNotEmpty) {
      // Mapear as entidades do banco para os objetos Pokemon e adicionar a URL da imagem
      final pokemonsFromDb = databaseMapper.toPokemons(dbEntities);
      return _addImageUrlsToPokemons(pokemonsFromDb);
    }

    // Caso contrário, buscar pela API remota
    final networkEntity = await apiClient.getPokemons(page: page, limit: limit);
    final pokemons = networkMapper.toPokemons(networkEntity);

    // Adicionar a URL das imagens
    final pokemonsWithImages = _addImageUrlsToPokemons(pokemons);

    // Salvar os dados no banco local para cache
    pokemonDao.insertAll(databaseMapper.toPokemonDatabaseEntities(pokemonsWithImages));

    return pokemonsWithImages;
  }

  Future<PokemonDatabaseEntity?> fetchPokemonById(String id) async {
  final PokemonDao pokemonDao = PokemonDao();
  final pokemon = await pokemonDao.getPokemonForId(id);
  return pokemon;
}

  // Função para adicionar a URL das imagens
  List<Pokemon> _addImageUrlsToPokemons(List<Pokemon> pokemons) {
    return pokemons.map((pokemon) {
      final formatedId = pokemon.id.padLeft(3, '0');
      final imgUrl = 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$formatedId.png';  // Modifique o caminho de acordo com seu repositório
      return pokemon.copyWith(imgUrl: imgUrl);  // Atualiza o Pokemon com a URL da imagem
    }).toList();
  }

  // Função para obter um Pokémon aleatório
  Future<Pokemon> getRandomPokemon() async {
    // Obter a lista de pokémons já salvos no banco
    final allPokemons = await pokemonDao.selectAll();

    // Se não houver pokémons, buscar pela API
    if (allPokemons.isEmpty) {
      final networkEntity = await apiClient.getPokemons(page: 1, limit: 10); // Pode ser ajustado conforme necessário
      final pokemons = networkMapper.toPokemons(networkEntity);
      final pokemonsWithImages = _addImageUrlsToPokemons(pokemons);
      pokemonDao.insertAll(databaseMapper.toPokemonDatabaseEntities(pokemonsWithImages));
      return pokemonsWithImages[Random().nextInt(pokemonsWithImages.length)];
    } else {
      // Selecionar aleatoriamente um Pokémon do banco
      final randomIndex = Random().nextInt(allPokemons.length);
      final randomPokemonEntity = allPokemons[randomIndex];
      final pokemon = databaseMapper.toPokemon(randomPokemonEntity);
      return pokemon.copyWith(imgUrl: _generateImageUrl(pokemon.id));
    }
  }

  // Função para gerar a URL da imagem do Pokémon
  String _generateImageUrl(String pokemonId) {
    final formattedId = pokemonId.padLeft(3, '0');
    return 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$formattedId.png';
  }

  // Função para verificar se o usuário pode capturar um Pokémon
  Future<bool> canCapturePokemon() async {
    final pokemons = await pokemonDao.selectAll();
    return pokemons.length < 6;  // Limite de 6 Pokémons
  }

  // Função para salvar o Pokémon no banco de dados
  Future<void> saveCapturedPokemon(Pokemon pokemon) async {
    await pokemonDao.insert(databaseMapper.toPokemonDatabaseEntity(pokemon));
  }
}
