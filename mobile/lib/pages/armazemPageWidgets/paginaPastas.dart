import 'package:flutter/material.dart';
import 'package:mobile/model/pasta.dart';
import 'package:mobile/pages/senhasPageWidgets/senhas_page.dart';
import 'package:mobile/service/pasta_service.dart';
import 'package:mobile/service/senha_service.dart';
import 'package:http/http.dart' as http;

class PaginaPastas extends StatefulWidget {
  @override
  _PaginaPastasState createState() => _PaginaPastasState();
}

class _PaginaPastasState extends State<PaginaPastas> {
  late PastaService pastaService;
  late SenhaService senhaService;
  late Future<List<Pasta>> futurePastas;

  @override
  void initState() {
    super.initState();
    pastaService = PastaService(http.Client());
    senhaService = SenhaService(http.Client());
    futurePastas = pastaService.getAllPastas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Pastas'),
      ),
      body: FutureBuilder<List<Pasta>>(
        future: futurePastas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma pasta encontrada'));
          }

          List<Pasta> pastas = snapshot.data!;

          return ListView.builder(
            itemCount: pastas.length,
            itemBuilder: (context, index) {
              Pasta pasta = pastas[index];
              return ListTile(
                title: Text(pasta.nome),
                subtitle: Text('${pasta.senhas.length} senhas'),
                onTap: () {
                  _navegarParaSenhas(context, pasta);
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editarPasta(pasta);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _excluirPasta(pasta.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _criarPasta,
        child: Icon(Icons.add),
      ),
    );
  }

  void _navegarParaSenhas(BuildContext context, Pasta pasta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SenhasPage(
          pasta: pasta,
          senhaService: senhaService,
        ),
      ),
    );
  }

  void _criarPasta() async {
    final Pasta novaPasta = Pasta(id: '0', nome: 'Nova Pasta', senhas: []);
    try {
      await pastaService.criarPasta(novaPasta);
      setState(() {
        futurePastas = pastaService.getAllPastas();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao criar pasta: $e')),
      );
    }
  }

  void _excluirPasta(String id) async {
    try {
      await pastaService.excluirPasta(id);
      setState(() {
        futurePastas = pastaService.getAllPastas();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir pasta: $e')),
      );
    }
  }

  void _editarPasta(Pasta pasta) async {
    final nomeController = TextEditingController(text: pasta.nome);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Pasta'),
          content: TextField(
            controller: nomeController,
            decoration: InputDecoration(labelText: 'Nome da Pasta'),
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
                Pasta pastaAtualizada = Pasta(
                  id: pasta.id,
                  nome: nomeController.text,
                  senhas: pasta.senhas,
                );

                try {
                  await pastaService.atualizarPasta(pastaAtualizada);
                  setState(() {
                    futurePastas = pastaService.getAllPastas();
                  });
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao editar pasta: $e')),
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
