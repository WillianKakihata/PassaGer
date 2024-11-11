class Senha {
  final int id;
  final String nome;
  final String senha;

  Senha({required this.id, required this.nome, required this.senha});

  factory Senha.fromJson(Map<String, dynamic> json) {
    return Senha(
      id: json['id'],
      nome: json['nome'],
      senha: json['senha'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'senha': senha,
    };
  }
}
