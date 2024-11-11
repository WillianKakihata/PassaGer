import 'package:flutter/material.dart';
import 'package:mobile/pages/senhasPageWidgets/model/senha.dart';

class PaginaAtualizarSenha extends StatefulWidget {
  @override
  _PaginaAtualizarSenhaState createState() => _PaginaAtualizarSenhaState();
}

class _PaginaAtualizarSenhaState extends State<PaginaAtualizarSenha> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  
  List<Usuario> usuarios = [];

  void atualizarSenha() {
    if (nomeController.text.isNotEmpty && senhaController.text.isNotEmpty) {
      setState(() {
        Usuario usuario = usuarios.first;
        Pasta pasta = usuario.pastas[0];
        Senha senhaExistente = pasta.senhas.firstWhere((senha) => senha.nome == nomeController.text, orElse: () => Senha(id: 0, nome: '', senha: ''));
        
        if (senhaExistente.id != 0) {
          senhaExistente.senha = senhaController.text;
        }
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar Senha'),
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
              decoration: InputDecoration(labelText: 'Nova Senha'),
              obscureText: true,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: atualizarSenha,
              child: Text('Atualizar Senha'),
            ),
          ],
        ),
      ),
    );
  }
}
