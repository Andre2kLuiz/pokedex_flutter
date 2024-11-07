import 'package:flutter/material.dart';

class PokemonHomepage extends StatelessWidget {
  const PokemonHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Homepage', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Ação para o botão Pokedex
                Navigator.pushReplacementNamed(context, '/pokemon_list');
              },
              child: Text(
                'Pokedex',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 50), // Tamanho médio do botão
              ),
              
            ),
            SizedBox(height: 20), // Espaçamento entre os botões
            ElevatedButton(
              onPressed: () {
                // Ação para o botão Encontro Diário
                Navigator.pushReplacementNamed(context, '/pokemon_encontro');
              },
              child: Text(
                'Encontro Diário',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 50),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ação para o botão Meus Pokémons
                Navigator.pushReplacementNamed(context, '/pokemon_lista');
              },
              child: Text(
                'Meus Pokémons',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
