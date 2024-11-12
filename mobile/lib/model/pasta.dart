import 'package:mobile/model/senha.dart';

class Pasta {
  String id;  
  String nome;
  List<Senha> senhas;

  Pasta({required this.id, required this.nome, required this.senhas});

  factory Pasta.fromJson(Map<String, dynamic> json) {
    var list = json['senhas'] != null && json['senhas'] is List
        ? json['senhas'] as List
        : [];
    
    List<Senha> senhasList = list.map((i) => Senha.fromJson(i)).toList();

    return Pasta(
      id: json['id'].toString(), 
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
