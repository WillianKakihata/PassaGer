import 'package:flutter/material.dart';
import 'package:mobile/model/pasta.dart';
import 'package:mobile/service/pasta_service.dart';
import 'package:http/http.dart' as http;

class PaginaPastas extends StatefulWidget {
  @override
  _PaginaPastasState createState() => _PaginaPastasState();
}

class _PaginaPastasState extends State<PaginaPastas> {
  late PastaService pastaService;
  late Future<List<Pasta>> futurePastas;

  @override
  void initState() {
    super.initState();
    pastaService = PastaService(http.Client());
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
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editarPasta(context, pasta);
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

  void _criarPasta() async {
    final Pasta novaPasta = Pasta(id: 0, nome: 'Nova Pasta', senhas: []);
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

  void _excluirPasta(int id) async {
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


void _editarPasta(BuildContext context, Pasta pasta) async {
  TextEditingController nomeController = TextEditingController(text: pasta.nome);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Editar Pasta"),
        content: TextField(
          controller: nomeController,
          decoration: InputDecoration(hintText: "Nome da Pasta"),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              pasta.nome = nomeController.text;  
              try {
                await pastaService.atualizarPasta(pasta);  
                setState(() {
                  futurePastas = pastaService.getAllPastas();  
                });
                Navigator.of(context).pop();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Erro ao atualizar pasta: $e')),
                );
              }
            },
            child: Text("Salvar"),
          ),
        ],
      );
    },
  );
}

}
