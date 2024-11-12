import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/model/senha.dart';

class SenhaService {
  final http.Client client;
  final String baseUrl;

  SenhaService(this.client, {this.baseUrl = "http://localhost:3000/senhas"});

  Future<List<Senha>> getAllSenhas() async {
    final response = await client.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => Senha.fromJson(e)).toList();
    } else {
      throw Exception("Erro ao carregar senhas");
    }
  }

  Future<void> criarSenha(Senha senha) async {
    final response = await client.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(senha.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Erro ao criar senha");
    }
  }

  Future<void> atualizarSenha(Senha senha) async {
    final response = await client.put(
      Uri.parse('$baseUrl/${senha.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(senha.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Erro ao atualizar senha");
    }
  }

  Future<void> excluirSenha(String senhaId) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/$senhaId'),
    );
    if (response.statusCode != 200) {
      throw Exception("Erro ao excluir senha");
    }
  }
}
