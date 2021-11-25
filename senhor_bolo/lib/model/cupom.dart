class Coupon{
  final int id;
  final int? expDate;
  final int discountPercentage;
  final bool? status;

  Coupon({
    required this.id,
    this.expDate,
    required this.discountPercentage,
    this.status
  });

  factory Coupon.fromJson(Map<String, dynamic> json){
    print(json['id_cupons']);
    print(int.parse(json['valor_desc']));
    return Coupon(
      id: 1,
      discountPercentage: 10
    );
  }
}