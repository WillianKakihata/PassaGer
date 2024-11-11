import 'package:flutter/material.dart';
import 'package:mobile/pages/armazemPageWidgets/paginaPastas.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'BEM - VINDO AO PASSAGER',
              style: TextStyle(fontSize: 40.0, color: Color(0xFF259DF2)),
            ),
            SizedBox(height: 20),
            Botaohomepage(),
          ],
        ),
      ),
    );
  }
}

class Botaohomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PaginaPastas()),
        );
      },
      child: Text('Ir para Pastas'),
    );
  }
}
