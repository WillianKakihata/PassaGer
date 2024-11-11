import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/model/pasta.dart';

const String baseUrl = "http://localhost:3000/pastas";

class PastaService {
  final http.Client client;

  PastaService(this.client);

  Future<List<Pasta>> getAllPastas() async {
    final response = await client.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => Pasta.fromJson(e)).toList();
    } else {
      throw Exception("Erro ao carregar pastas");
    }
  }

  Future<void> criarPasta(Pasta pasta) async {
  final response = await client.post(
    Uri.parse(baseUrl),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(pasta.toJson()),
  );

  if (response.statusCode == 201) {
    var responseJson = json.decode(response.body);
    pasta.id = responseJson['id'].toString(); // Atualiza o ID gerado pelo servidor
  } else {
    throw Exception("Erro ao criar pasta");
  }
}

  Future<void> atualizarPasta(Pasta pasta) async {
    final response = await client.put(
      Uri.parse('$baseUrl/${pasta.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pasta.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Erro ao atualizar pasta");
    }
  }

  Future<void> excluirPasta(String id) async {
    final response = await client.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception("Erro ao excluir pasta");
    }
  }

  Future<void> excluirSenha(String pastaId, int senhaId) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/$pastaId/senhas/$senhaId'),
    );
    if (response.statusCode != 200) {
      throw Exception("Erro ao excluir senha");
    }
  }
}
