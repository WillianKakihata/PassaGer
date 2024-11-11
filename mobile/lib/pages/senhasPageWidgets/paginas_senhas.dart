import 'package:flutter/material.dart';
import 'package:mobile/model/pasta.dart';

class PaginaSenhas extends StatelessWidget {
  final Pasta pasta;

  PaginaSenhas({required this.pasta});  // Recebendo a pasta

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pasta.nome),  // Mostrando o nome da pasta
      ),
      body: ListView.builder(
        itemCount: pasta.senhas.length,  // Contando as senhas
        itemBuilder: (context, index) {
          var senha = pasta.senhas[index];
          return ListTile(
            title: Text(senha.nome),  // Exibindo o nome da senha
            subtitle: Text(senha.senha),  // Exibindo a senha
          );
        },
      ),
    );
  }
}
