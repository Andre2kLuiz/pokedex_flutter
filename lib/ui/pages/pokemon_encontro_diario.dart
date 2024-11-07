import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/data/repository/pokemon_repository_impl.dart';
import 'package:pokedex_flutter/domain/pokemon.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonEncontroDiarioPage extends StatefulWidget {
  const PokemonEncontroDiarioPage({super.key});

  @override
  _PokemonEncontroDiarioPageState createState() =>
      _PokemonEncontroDiarioPageState();
}

class _PokemonEncontroDiarioPageState extends State<PokemonEncontroDiarioPage> {
  late final PokemonRepositoryImpl pokemonRepo;
  Pokemon? _pokemonSorteado;
  List<String> _capturados = [];
  String? _dataUltimaCaptura;

  @override
  void initState() {
    super.initState();
    pokemonRepo = Provider.of<PokemonRepositoryImpl>(context, listen: false);
    _loadCapturedPokemons();
  }

  Future<void> _loadCapturedPokemons() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _capturados = prefs.getStringList('capturados') ?? [];
      _dataUltimaCaptura = prefs.getString('dataUltimaCaptura');
    });
  }

   // Remover Pokémon da lista e atualizar o SharedPreferences
  Future<void> _removeCapturedPokemon(String pokemonId) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _capturados.remove(pokemonId);
    });
    await prefs.setStringList('capturados', _capturados);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pokémon removido com sucesso!')),
    );
  }

  Future<void> _saveCapturedPokemon(String pokemonId) async {
    final prefs = await SharedPreferences.getInstance();
    final hoje = DateTime.now().toIso8601String().split('T').first;

    if (_dataUltimaCaptura == hoje) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você já capturou um Pokémon hoje!')),
      );
    } else if (_capturados.length < 6) {
      _capturados.add(pokemonId);
      _dataUltimaCaptura = hoje;
      await prefs.setStringList('capturados', _capturados);
      await prefs.setString('dataUltimaCaptura', _dataUltimaCaptura!);

      // Notifica a página de captura para recarregar a lista
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pokémon capturado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você já capturou o máximo de Pokémon!')),
      );
    }
  }

  Future<void> _sorteioPokemon() async {
    final random = Random();
    final page = random.nextInt(80) + 1;
    final limit = random.nextInt(10) + 1;

    try {
      final pokemons = await pokemonRepo.getPokemons(page: page, limit: limit);
      if (pokemons.isNotEmpty) {
        setState(() {
          _pokemonSorteado = pokemons.first;
        });
      }
    } catch (e) {
      print('Erro ao buscar Pokémon: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Encontro Diário de Pokémon"),
        backgroundColor: Theme.of(context).primaryColorLight,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_pokemonSorteado == null) ...[ 
            const Text('Clique no botão para encontrar um Pokémon!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sorteioPokemon,
              child: const Text('Sortear Pokémon'),
            ),
          ] else ...[
            Image.network(
              _pokemonSorteado!.imgUrl ?? 'https://example.com/default-image.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            Text(
              _pokemonSorteado!.name.values.first,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              'Tipo(s): ${_pokemonSorteado!.type?.join(', ') ?? 'Desconhecido'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _pokemonSorteado = null;
                });
              },
              child: const Text('Voltar'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_pokemonSorteado != null) {
                  _saveCapturedPokemon(_pokemonSorteado!.id);
                }
              },
              child: const Text('Capturar'),
            ),
          ],
          const SizedBox(height: 20),
          const Text("Pokémons Capturados:", style: TextStyle(fontSize: 18)),
          Expanded(
            child: ListView.builder(
              itemCount: _capturados.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_capturados[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
