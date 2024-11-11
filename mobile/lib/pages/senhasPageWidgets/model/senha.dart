class Senha {
  int id;
  String nome;
  String senha;

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

class Pasta {
  int id;
  String nome;
  List<Senha> senhas;

  Pasta({required this.id, required this.nome, required this.senhas});

  factory Pasta.fromJson(Map<String, dynamic> json) {
    var list = json['senhas'] as List;
    List<Senha> senhasList = list.map((i) => Senha.fromJson(i)).toList();

    return Pasta(
      id: json['id'],
      nome: json['nome'],
      senhas: senhasList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'senhas': senhas.map((senha) => senha.toJson()).toList(),
    };
  }
}

class Usuario {
  int id;
  String nome;
  String senha;
  List<Pasta> pastas;

  Usuario({required this.id, required this.nome, required this.senha, required this.pastas});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    var list = json['pastas'] as List;
    List<Pasta> pastasList = list.map((i) => Pasta.fromJson(i)).toList();

    return Usuario(
      id: json['id'],
      nome: json['nome'],
      senha: json['senha'],
      pastas: pastasList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'senha': senha,
      'pastas': pastas.map((pasta) => pasta.toJson()).toList(),
    };
  }
}
