import 'package:flutter/material.dart';
import 'package:pokedex_flutter/core/di/configure_providers.dart';
import 'package:pokedex_flutter/ui/pages/pokemon_encontro_diario.dart';
import 'package:pokedex_flutter/ui/pages/pokemon_equipe.dart';
import 'package:pokedex_flutter/ui/pages/pokemon_homepage.dart';
import 'package:pokedex_flutter/ui/pages/pokemon_list_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final data = await ConfigureProviders.createDependencyTree();

  runApp(AppRoot(data: data));
}

class AppRoot extends StatelessWidget {
  final ConfigureProviders data;

  const AppRoot({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: data.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Pokedex",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const PokemonHomepage(),
          '/pokemon_list': (context) => PokemonListPage(),
          '/pokemon_encontro': (context) => PokemonEncontroDiarioPage(),
          '/pokemon_lista': (context) => const PokemonEncontroPage(),
        },
      ),
    );
  }
}


