class SenhaModel {
  final int id;
  final String descricao;
  final String usuario;
  final String valor;

  SenhaModel({
    required this.id,
    required this.descricao,
    required this.usuario,
    required this.valor,
  });

  factory SenhaModel.fromJson(Map<String, dynamic> json) {
    return SenhaModel(
      id: int.parse(json['id'].toString()), // Converte o id para int
      descricao: json['descricao'],
      usuario: json['usuario'],
      valor: json['valor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'usuario': usuario,
      'valor': valor,
    };
  }
}
