import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NYTimesView extends StatefulWidget {
  const NYTimesView({super.key});

  @override
  _NYTimesViewState createState() => _NYTimesViewState();
}

class _NYTimesViewState extends State<NYTimesView> {
  List<dynamic> articles = [];
  bool isLoading = true;
  String errorMessage = '';

  // Reemplaza con tu clave de API de NYT
  final String apiKey = 'Pn51OnEnOkC5SSgdb5Ll8N42pR1UHhLb';

  Future<void> fetchArticles() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.nytimes.com/svc/topstories/v2/home.json?api-key=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          // Tomamos solo las primeras 3 noticias
          articles = data['results'].take(3).toList();
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
    fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Últimas 3 Noticias de NY Times'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return ListTile(
                      title: Text(article['title']),
                      subtitle: Text(article['abstract']),
                      leading: article['multimedia'] != null && article['multimedia'].isNotEmpty
                          ? Image.network(
                              article['multimedia'][0]['url'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : null,
                      onTap: () {
                        if (article['url'] != null) {
                          // Usar url_launcher para abrir el enlace
                        }
                      },
                    );
                  },
                ),
    );
  }
}