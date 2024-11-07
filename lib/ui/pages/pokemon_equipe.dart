import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonEncontroPage extends StatefulWidget {
  const PokemonEncontroPage({super.key});

  @override
  _PokemonEncontroPageState createState() => _PokemonEncontroPageState();
}

class _PokemonEncontroPageState extends State<PokemonEncontroPage> {
  List<String> _capturados = [];

  @override
  void initState() {
    super.initState();
    _loadCapturedPokemons();
  }

  // Carregar Pokémon capturados do SharedPreferences
  Future<void> _loadCapturedPokemons() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _capturados = prefs.getStringList('capturados') ?? [];
    });
  }

  // Remover Pokémon da lista e atualizar o SharedPreferences
  Future<void> _removeCapturedPokemon(String pokemonId) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _capturados.remove(pokemonId);
    });

    // Remover a data da última captura, pois o Pokémon foi removido
    await prefs.remove('dataUltimaCaptura');

    // Atualizar a lista de Pokémon capturados no SharedPreferences
    await prefs.setStringList('capturados', _capturados);

    // Feedback para o usuário
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pokémon removido com sucesso! Agora você pode capturar outro Pokémon.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémons Capturados'),
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
      body: _capturados.isEmpty
          ? const Center(child: Text('Você ainda não capturou nenhum Pokémon!'))
          : ListView.builder(
              itemCount: _capturados.length,
              itemBuilder: (context, index) {
                final pokemonId = _capturados[index];
                return ListTile(
                  title: Text(pokemonId),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _removeCapturedPokemon(pokemonId);
                    },
                  ),
                );
              },
            ),
    );
  }
}
