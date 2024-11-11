import 'package:flutter/material.dart';
import 'package:mobile/model/pasta.dart';
import 'package:mobile/model/senha.dart';
import 'package:mobile/service/senha_service.dart';

class SenhasPage extends StatefulWidget {
  final Pasta pasta;
  final SenhaService senhaService;

  SenhasPage({required this.pasta, required this.senhaService});

  @override
  _SenhasPageState createState() => _SenhasPageState();
}

class _SenhasPageState extends State<SenhasPage> {
  late Future<List<Senha>> futureSenhas;

  @override
  void initState() {
    super.initState();
    futureSenhas = widget.senhaService.getSenhasByPastaId(widget.pasta.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Senhas de ${widget.pasta.nome}'),
      ),
      body: FutureBuilder<List<Senha>>(
        future: futureSenhas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma senha encontrada.'));
          }

          List<Senha> senhas = snapshot.data!;

          return ListView.builder(
            itemCount: senhas.length,
            itemBuilder: (context, index) {
              Senha senha = senhas[index];
              return ListTile(
                title: Text(senha.nome),
                subtitle: Text(senha.senha),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _excluirSenha(senha.id);
                  },
                ),
                onTap: () {
                  _editarSenha(senha);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _criarSenha,
        child: Icon(Icons.add),
      ),
    );
  }

  void _criarSenha() async {
    final Senha novaSenha = Senha(
      id: "0",
      nome: 'Nova Senha',
      senha: '12345',
      pastaId: widget.pasta.id,
    );
    try {
      await widget.senhaService.criarSenha(widget.pasta.id, novaSenha);
      setState(() {
        futureSenhas = widget.senhaService.getSenhasByPastaId(widget.pasta.id);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao criar senha: $e')),
      );
    }
  }

  void _excluirSenha(String senhaId) async {
    try {
      await widget.senhaService.excluirSenha(widget.pasta.id, senhaId);
      setState(() {
        futureSenhas = widget.senhaService.getSenhasByPastaId(widget.pasta.id);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir senha: $e')),
      );
    }
  }

  void _editarSenha(Senha senha) async {
    final nomeController = TextEditingController(text: senha.nome);
    final senhaController = TextEditingController(text: senha.senha);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Senha'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: senhaController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Senha senhaAtualizada = Senha(
                  id: senha.id,
                  nome: nomeController.text,
                  senha: senhaController.text,
                  pastaId: senha.pastaId,
                );
                try {
                  await widget.senhaService.atualizarSenha(widget.pasta.id, senhaAtualizada);
                  setState(() {
                    futureSenhas = widget.senhaService.getSenhasByPastaId(widget.pasta.id);
                  });
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao editar senha: $e')),
                  );
                }
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
