class Senha {
  final String id;
  final String nome;
  final String senha;
  final String pastaId;  

  Senha({
    required this.id,
    required this.nome,
    required this.senha,
    required this.pastaId,  
  });


  factory Senha.fromJson(Map<String, dynamic> json) {
    return Senha(
      id: json['id'],
      nome: json['nome'],
      senha: json['senha'],
      pastaId: json['pastaId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'senha': senha,
      'pastaId': pastaId,
    };
  }
}
