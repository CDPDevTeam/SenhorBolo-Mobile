import 'package:flutter/material.dart';
import 'package:senhor_bolo/classes/order.dart';
import 'package:senhor_bolo/model/cake.dart';

class ShoppingCart extends ChangeNotifier{

  /*
   * Como não dá para pegar o valor do carrinho na classe Order,
   * já que ela não é um widget, ent não tem context, esse _teste
   * serve para setar o valor do subtotal, possivelmente tem um
   * jeito melhor de fazer isso.
   */

  Order _teste = Order();
  List<Cake> _cartItens = [];
  List<Cake> get cartItens => _cartItens;

  _updateSubtotal(){
    _teste.setSubtotal(total);
  }

  bool addItem(Cake bolo){
    for(int i = 0; i < _cartItens.length; i++){
      if (_cartItens[i].id == bolo.id){
        _cartItens[i].qtde += bolo.qtde;
        _updateSubtotal();
        notifyListeners();
        return true;
      }
    }
    _cartItens.add(bolo);
    _updateSubtotal();
    notifyListeners();
    return true;
  }

  removeItem(int indexBolo){
    _cartItens.removeAt(indexBolo);
    _updateSubtotal();
    notifyListeners();
  }

  updateItem(int indexBolo, int qtde){
    _cartItens[indexBolo].qtde = qtde;
    _updateSubtotal();
    notifyListeners();
  }

  double get total{
    double precoTotal = 0;
    for(int i = 0; i < cartItens.length; i++){
      precoTotal += cartItens[i].qtde * cartItens[i].price;
    }
    return precoTotal;
  }
}
