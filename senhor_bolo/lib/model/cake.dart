class Cake {
  final int id;
  final String name;
  final String category;
  final String image;
  final double price;
  int qtde;

  Cake({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    required this.qtde
  });

  factory Cake.fromJson(Map<String, dynamic> json){
    var preco = json['preco_catprod'].split('\$');
    return Cake(
        id: json['id_prod'] as int,
        name: json['nome_prod'] as String,
        image: json['foto_prod'] as String,
        category: json['categoria_prod_fk'] as String,
        price: double.parse(preco[1]),
        qtde: 0,
    );
  }
}