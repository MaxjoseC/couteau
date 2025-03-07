import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/foto2x2.jpg'),
              radius: 50,
            ),
            SizedBox(height: 20),
            Text('Emanuel Crucel'),
            Text('Correo: Maxjose17@gmail.com'),
            Text('Teléfono: 829-505-6261'),
          ],
        ),
      ),
    );
  }
}