import 'package:flutter/material.dart';
import 'package:mobile/pages/senhasPageWidgets/paginaCriarSenha.dart';
import 'paginaAtualizarSenha.dart';

class PaginaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial de Senhas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaCriarSenha()),
                );
              },
              child: Text('Criar Senha'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaAtualizarSenha()),
                );
              },
              child: Text('Atualizar Senha'),
            ),
          ],
        ),
      ),
    );
  }
}
