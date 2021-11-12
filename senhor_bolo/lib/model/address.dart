class Address{
  final int id;
  final String rua;
  final String bairro;
  final String num;
  final String cep;
  final String? complemento;
  final String? observacao;

  Address( {
      required this.id,
      required this.rua,
      required this.bairro,
      required this.num,
      required this.cep,
      this.complemento,
      this.observacao
  });

  factory Address.fromJson(Map<String, dynamic> json){
    return Address(
        id: json['id_endereco'] as int,
        rua: json['rua'] as String,
        bairro: json['bairro'] as String,
        num: json['numero'] as String,
        cep: json['cep'] as String,
        complemento: json['complemento'] as String?,
        observacao: json['observacao'] as String?,
    );

  }
}