import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:senhor_bolo/classes/user.dart';
import 'package:senhor_bolo/model/address.dart';
import 'package:senhor_bolo/model/cake.dart';
import 'package:senhor_bolo/model/creditcard.dart';
import 'package:senhor_bolo/model/cupom.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class Order extends ChangeNotifier{

 static double cartSubtotal = 0;
 Coupon? _orderCoupon;
 CreditCard? _creditCard;
 Address? _orderAddress;

 Coupon? get orderCoupon => _orderCoupon;
 CreditCard? get creditCard => _creditCard;
 Address? get orderAddress => _orderAddress;

  set orderCoupon(Coupon? value) {
    _orderCoupon = value;
    notifyListeners();
  }

 set orderAddress(Address? value) {
   _orderAddress = value;
   notifyListeners();
 }

 set creditCard(CreditCard? value) {
   _creditCard = value;
   notifyListeners();
 }

 void setSubtotal(double subtotal){
    cartSubtotal = subtotal;
    notifyListeners();
 }

 double getOrderPrice(){
   double total = (cartSubtotal - getCouponDiscount()) + 10;
   return total;
 }

 getCouponDiscount(){
   if (_orderCoupon != null){
     double porcentagemDesconto = (_orderCoupon!.discountPercentage / 100);
     double valorDesconto = ((cartSubtotal + 10) * porcentagemDesconto);
     return valorDesconto;
   } else {
     return 0;
   }
 }

  Future<bool> submitOrder(List<Cake> produtos) async{
    late int? idCupom;
    FlutterSecureStorage storage = FlutterSecureStorage();
    String? key = await storage.read(key: 'key');

    if(orderCoupon == null){
      idCupom = null;
    } else {
      idCupom = orderCoupon!.id;
    }

    var body = jsonEncode(
        {
          'email': User.email,
          "endereco": orderAddress!.id,
          "cupom": idCupom,
          "produtos": produtos
        }
    );

    http.Response response = await http.post(
        Uri.parse(urlAPIBD + '/pedido'),
        headers: {
          'Authorization' : 'Bearer $key'
        },
        body: body
    );

    print(body);
    print(response.statusCode == 200);

    return true;
  }
}