import 'package:flutter/material.dart';
import 'package:mobile/pages/senhasPageWidgets/model/senha.dart';

class PaginaCriarSenha extends StatefulWidget {
  @override
  _PaginaCriarSenhaState createState() => _PaginaCriarSenhaState();
}

class _PaginaCriarSenhaState extends State<PaginaCriarSenha> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  
  List<Usuario> usuarios = [];

  void criarSenha() {
    if (nomeController.text.isNotEmpty && senhaController.text.isNotEmpty) {
      setState(() {
        Usuario usuario = usuarios.first;
        Pasta pasta = usuario.pastas[0];
        Senha novaSenha = Senha(id: pasta.senhas.length + 1, nome: nomeController.text, senha: senhaController.text);
        pasta.senhas.add(novaSenha);
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Senha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome da Senha'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: criarSenha,
              child: Text('Salvar Senha'),
            ),
          ],
        ),
      ),
    );
  }
}
