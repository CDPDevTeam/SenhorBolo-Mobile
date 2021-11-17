import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:senhor_bolo/model/address.dart';
import 'package:senhor_bolo/model/creditcard.dart';
import 'package:senhor_bolo/model/cupom.dart';

class Order extends ChangeNotifier{
 static double cartSubtotal = 0;
 Coupon? _orderCoupon;
 CreditCard? _creditCard;
 Address? _orderAddress;
 late LatLng _addressLatLng;

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
    double total = (cartSubtotal * getCouponDiscount()) + 10;
    return total;
  }

  getCouponDiscount(){
    if (_orderCoupon != null){
      return 1 - (_orderCoupon!.discountPercentage / 100);
    } else {
      return 1;
    }
  }

/*
  Future<bool> submitOrder() async{
    FlutterSecureStorage storage = FlutterSecureStorage();
    String? jwtKey = await storage.read(key: 'key');
    var body = jsonEncode(
        {
          'email': User.email,
          "endereco": orderAddress,
          "cupom": orderCoupon!.id,
          "statusCompra": "Pedido recebido",
          "ecommerce": true
        }
    );
    http.Response responseOrder = await http.post(
      Uri.parse(urlAPIBD + '/pedido'),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwtKey'
      },
      body: body
    );
    if(responseOrder.statusCode == 200){
      final parsed = jsonDecode(responseOrder.body);
      int orderID = parsed['idPedido'];
      for(int i = 0; i < ShoppingCart.cartItens.length; i++){
        var itemBody = jsonEncode(
            {
              'idProduto': orderID,
              'idPedido': 1,
              'valorUnitario': ShoppingCart.cartItens[i].price,
              'qtde': ShoppingCart.cartItens[i].qtde
            }
        );
        http.post(
          Uri.parse(urlAPIBD + '/pedido/item'),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $jwtKey'
          },
          body: itemBody
        );
      }
      return true;
    } else {
      return false;
    }
  }*/
}