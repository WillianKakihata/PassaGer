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
    futureSenhas = widget.senhaService.getAllSenhas();
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

          // Garantir que filtramos senhas com pastaId correspondente, lidando com null
          List<Senha> senhas = snapshot.data!
              .where((senha) => senha.pastaId != null && senha.pastaId == widget.pasta.id.toString())
              .toList();

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
                  // Lógica para editar a senha
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
    final Senha novaSenha = Senha(id: "0", nome: 'Nova Senha', senha: '12345', pastaId: widget.pasta.id.toString());
    try {
      await widget.senhaService.criarSenha(novaSenha);
      setState(() {
        futureSenhas = widget.senhaService.getAllSenhas();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao criar senha: $e')),
      );
    }
  }

  void _excluirSenha(String id) async {
    try {
      await widget.senhaService.excluirSenha(id);
      setState(() {
        futureSenhas = widget.senhaService.getAllSenhas();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir senha: $e')),
      );
    }
  }
}
