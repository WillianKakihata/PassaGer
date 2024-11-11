import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/model/senha.dart';

class SenhaService {
  final http.Client client;
  final String baseUrl;

  SenhaService(this.client, {this.baseUrl = "http://localhost:3000"});

  Future<List<Senha>> getAllSenhas() async {
    final response = await client.get(Uri.parse('$baseUrl/senhas'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['senhas'];
      return data.map((e) => Senha.fromJson(e)).toList();
    } else {
      throw Exception("Erro ao carregar senhas");
    }
  }

  Future<List<Senha>> getSenhasByPastaId(String pastaId) async {
    final response = await client.get(Uri.parse('$baseUrl/pastas/$pastaId/senhas'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['senhas'];
      return data.map((e) => Senha.fromJson(e)).toList();
    } else {
      throw Exception("Erro ao carregar senhas da pasta");
    }
  }

  Future<void> criarSenha(String pastaId, Senha senha) async {
    final response = await client.post(
      Uri.parse('$baseUrl/pastas/$pastaId/senhas'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(senha.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Erro ao criar senha");
    }
  }

  Future<void> atualizarSenha(String pastaId, Senha senha) async {
    final response = await client.put(
      Uri.parse('$baseUrl/pastas/$pastaId/senhas/${senha.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(senha.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Erro ao atualizar senha");
    }
  }

  Future<void> excluirSenha(String pastaId, String senhaId) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/pastas/$pastaId/senhas/$senhaId'),
    );
    if (response.statusCode != 200) {
      throw Exception("Erro ao excluir senha");
    }
  }
}
