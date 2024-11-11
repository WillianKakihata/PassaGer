import 'package:flutter/material.dart';
import 'package:mobile/model/senha.dart';
import 'package:mobile/service/senha_service.dart';
import 'package:http/http.dart' as http;

class FormularioSenha extends StatefulWidget {
  final Senha senha;

  const FormularioSenha({Key? key, required this.senha}) : super(key: key);

  @override
  _FormularioSenhaState createState() => _FormularioSenhaState();
}

class _FormularioSenhaState extends State<FormularioSenha> {
  late TextEditingController _nomeController;
  late TextEditingController _senhaController;
  late SenhaService senhaService;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.senha.nome);
    _senhaController = TextEditingController(text: widget.senha.senha);
    senhaService = SenhaService(baseUrl: 'http://localhost:3000', client: http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.senha.id == 0 ? 'Criar Senha' : 'Editar Senha')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome da Senha'),
            ),
            TextField(
              controller: _senhaController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarSenha,
              child: Text(widget.senha.id == 0 ? 'Criar' : 'Salvar'),
            ),
          ],
        ),
      ),
    );
  }

  void _salvarSenha() async {
    final Senha novaSenha = Senha(
      id: widget.senha.id == 0 ? DateTime.now().millisecondsSinceEpoch : widget.senha.id,
      nome: _nomeController.text,
      senha: _senhaController.text,
    );

    try {
      if (widget.senha.id == 0) {
        await senhaService.criarSenha(novaSenha);
      } else {
        await senhaService.atualizarSenha(widget.senha.id, novaSenha);
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar senha: $e')),
      );
    }
  }
}
