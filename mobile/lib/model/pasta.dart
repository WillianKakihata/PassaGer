import 'package:mobile/model/senha.dart';

class Pasta {
  String id;  // Alterado para String
  String nome;
  List<Senha> senhas;

  Pasta({required this.id, required this.nome, required this.senhas});

  factory Pasta.fromJson(Map<String, dynamic> json) {
    // Verifica se 'senhas' existe e é uma lista, caso contrário, usa uma lista vazia
    var list = json['senhas'] != null && json['senhas'] is List
        ? json['senhas'] as List
        : [];
    
    // Mapeia a lista de senhas
    List<Senha> senhasList = list.map((i) => Senha.fromJson(i)).toList();

    // Converte o 'id' para String (não é mais necessário fazer parse para int)
    return Pasta(
      id: json['id'].toString(), // Converte 'id' para String
      nome: json['nome'],
      senhas: senhasList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,  // O 'id' agora é uma String, então não precisa de conversão
      'nome': nome,
      'senhas': senhas.map((e) => e.toJson()).toList(),
    };
  }
}
