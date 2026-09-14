class Bg3Class {
  final String nome;
  final String atributos;
  final String subclasseRecomendada;
  final String motivo;
  final String imagem;

  Bg3Class({
    required this.nome,
    required this.atributos,
    required this.subclasseRecomendada,
    required this.motivo,
    required this.imagem,
  });

  factory Bg3Class.fromJson(Map<String, dynamic> json) {
    return Bg3Class(
      nome: json['nome'],
      atributos: json['atributos'],
      subclasseRecomendada: json['subclasseRecomendada'],
      motivo: json['motivo'],
      imagem: json['imagem'],
    );
  }
}