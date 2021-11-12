import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/model/address.dart';
import 'package:senhor_bolo/model/creditcard.dart';
import 'package:senhor_bolo/model/cupom.dart';
import 'package:senhor_bolo/classes/shoppingCart.dart';
import 'package:senhor_bolo/classes/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Order{
  static bool haveCoupon = false;
  static Coupon? orderCoupon;
  static Address? orderAddress;
  static CreditCard? creditCard;

  static double getTotalPrice(){
    double subTotal = ShoppingCart.getCartPrice();
    double total = (subTotal * getCouponDiscount()) + 10;
    return total;
  }

  static double getCouponDiscount(){
    if (haveCoupon){
      return 1 - (orderCoupon!.discountPercentage / 100);
    } else {
      return 1;
    }
  }

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
  }
}