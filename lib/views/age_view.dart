import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgeView extends StatefulWidget {
  const AgeView({super.key});

  @override
  _AgeViewState createState() => _AgeViewState();
}

class _AgeViewState extends State<AgeView> {
  String name = '';
  int age = 0;
  String ageGroup = '';
  String imageUrl = '';

  Future<void> predictAge() async {
    final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        age = data['age'];
        if (age < 30) {
          ageGroup = 'Joven';
          imageUrl = 'assets/young.jpg';
        } else if (age >= 30 && age < 60) {
          ageGroup = 'Adulto';
          imageUrl = 'assets/adult.jpg';
        } else {
          ageGroup = 'Anciano';
          imageUrl = 'assets/old.jpg';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Determinar Edad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: predictAge,
              child: Text('Determinar Edad'),
            ),
            SizedBox(height: 20),
            Text('Edad: $age'),
            Text('Grupo de Edad: $ageGroup'),
            if (imageUrl.isNotEmpty) Image.asset(imageUrl, width: 200, height: 200),
          ],
        ),
      ),
    );
  }
}