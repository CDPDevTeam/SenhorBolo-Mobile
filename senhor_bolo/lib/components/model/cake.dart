class Cake {
  final String name;
  final String category;
  final String image;
  final int price;

  Cake({
    required this.name,
    required this.category,
    required this.image,
    required this.price});

  factory Cake.fromJson(Map<String, dynamic> json){
    return Cake(
        name: json['nome'] as String,
        category: json['categoria'] as String,
        image: json['imagem'] as String,
        price: json['preco'] as int
    );
  }
}