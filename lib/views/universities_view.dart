import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UniversitiesView extends StatefulWidget {
  const UniversitiesView({super.key});

  @override
  _UniversitiesViewState createState() => _UniversitiesViewState();
}

class _UniversitiesViewState extends State<UniversitiesView> {
  String country = '';
  List<dynamic> universities = [];

  Future<void> fetchUniversities() async {
    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    if (response.statusCode == 200) {
      setState(() {
        universities = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades por País'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  country = value;
                });
              },
              decoration: InputDecoration(labelText: 'País'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchUniversities,
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: universities.length,
                itemBuilder: (context, index) {
                  final university = universities[index];
                  return ListTile(
                    title: Text(university['name']),
                    subtitle: Text('Dominio: ${university['domains'][0]}'),
                    trailing: IconButton(
                      icon: Icon(Icons.open_in_new),
                      onPressed: () {
                        // Abrir enlace web
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}