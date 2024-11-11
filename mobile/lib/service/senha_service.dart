import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/model/senha.dart';

class SenhaService {
  final String baseUrl;
  final http.Client client;

  SenhaService({required this.baseUrl, required this.client});

  Future<List<Senha>> getAllSenhas(int pastaId) async {
    final response = await client.get(Uri.parse('$baseUrl/pastas/$pastaId/senhas'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Senha.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar senhas');
    }
  }

  Future<void> criarSenha(Senha senha) async {
    final response = await client.post(
      Uri.parse('$baseUrl/senhas'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(senha.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Erro ao criar senha');
    }
  }

  Future<void> atualizarSenha(int id, Senha senha) async {
    final response = await client.put(
      Uri.parse('$baseUrl/senhas/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(senha.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar senha');
    }
  }

  Future<void> excluirSenha(int id) async {
    final response = await client.delete(Uri.parse('$baseUrl/senhas/$id'));
    if (response.statusCode != 200) {
      throw Exception('Erro ao excluir senha');
    }
  }
}
