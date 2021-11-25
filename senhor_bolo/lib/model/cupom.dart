class Coupon{
  final int id;
  final int discountPercentage;
  final bool? status;

  Coupon({
    required this.id,
    required this.discountPercentage,
    this.status
  });

  factory Coupon.fromJson(Map<String, dynamic> json){
    return Coupon(
      id: json['id_cupons'],
      discountPercentage: json['valor_desc']
    );
  }
}