import 'package:mobile/model/senha.dart';

class Pasta {
  int id;
  String nome;
  List<Senha> senhas;

  Pasta({required this.id, required this.nome, required this.senhas});

  factory Pasta.fromJson(Map<String, dynamic> json) {
    var list = json['senhas'] as List;
    List<Senha> senhasList = list.map((i) => Senha.fromJson(i)).toList();

    return Pasta(
      id: json['id'] is String ? int.parse(json['id']) : json['id'],
      nome: json['nome'],
      senhas: senhasList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'senhas': senhas.map((e) => e.toJson()).toList(),
    };
  }
}
