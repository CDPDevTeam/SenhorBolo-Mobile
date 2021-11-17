class OpcaoBoloPersonalizado{
  final String nome;
  final String img;

  OpcaoBoloPersonalizado({
    required this.nome,
    required this.img
  });

  factory OpcaoBoloPersonalizado.fromJson(Map<String, dynamic> json){
    return OpcaoBoloPersonalizado(
      nome: json['nome_opcao'],
      img: json['imagem']
    );
  }
}