import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  String weatherDescription = '';
  String temperature = '';
  bool isLoading = true;
  String errorMessage = '';

  // Reemplaza con tu clave de API de OpenWeatherMap
  final String apiKey = '';

  Future<void> fetchWeather() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Santo%20Domingo&appid=$apiKey&units=metric'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          weatherDescription = data['weather'][0]['description'];
          temperature = data['main']['temp'].toString();
          isLoading = false;
        });
      } else if (response.statusCode == 401) {
        setState(() {
          errorMessage = 'Error: Clave de API inválida. Verifica tu clave.';
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Error: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error de conexión: $e';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en Santo Domingo'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Clima: $weatherDescription',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Temperatura: $temperature°C',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
    );
  }
}
