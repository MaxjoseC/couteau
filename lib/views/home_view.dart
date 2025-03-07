import 'package:flutter/material.dart';
import 'gender_view.dart';
import 'age_view.dart';
import 'universities_view.dart';
import 'weather_view.dart';
import 'pokemon_view.dart';
import 'wordpress_view.dart';
import 'about_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Couteau App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/toolbox.jpg', width: 200, height: 200),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenderView()),
                );
              },
              child: Text('Predecir Género'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AgeView()),
                );
              },
              child: Text('Determinar Edad'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UniversitiesView()),
                );
              },
              child: Text('Universidades por País'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherView()),
                );
              },
              child: Text('Clima en RD'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PokemonView()),
                );
              },
              child: Text('Buscar Pokémon'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NYTimesView()),
                );
              },
              child: Text('Noticias de WordPress'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutView()),
                );
              },
              child: Text('Acerca de'),
            ),
          ],
        ),
      ),
    );
  }
}