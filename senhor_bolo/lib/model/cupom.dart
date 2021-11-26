class Coupon{
  final int id;
  final int discountPercentage;

  Coupon({
    required this.id,
    required this.discountPercentage,
  });

  factory Coupon.fromJson(Map<String, dynamic> json){
    return Coupon(
      id: json['id_cupons'],
      discountPercentage: json['valor_desc']
    );
  }
}