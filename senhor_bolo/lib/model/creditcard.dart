class CreditCard{
  final int num;
  final String name;
  final String expDate;
  final int cvv;
  final String carrier;

  CreditCard({
    required this.num,
    required this.name,
    required this.expDate,
    required this.cvv,
    required this.carrier
  });

  Map<String, dynamic> toMap(){
    return{
      'num': num,
      'name': name,
      'expDate': expDate,
      'cvv': cvv,
      'carrier': carrier
    };
  }
}