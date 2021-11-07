import 'package:senhor_bolo/model/cake.dart';

class ShoppingCart{
  static List<Cake> cartItens = [];

  static bool addItem(Cake bolo){
      for(int i = 0; i < cartItens.length; i++){
        if (cartItens[i].id == bolo.id){
          cartItens[i].qtde += bolo.qtde;
          return true;
        }
      }
      cartItens.add(bolo);
      return true;
  }

  static void removeItem(int indexBolo){
    cartItens.removeAt(indexBolo);
  }

  static double getCartPrice(){
    double precoTotal = 0;
    for(int i = 0; i < cartItens.length; i++){
      precoTotal += cartItens[i].qtde * cartItens[i].price;
    }
    return precoTotal;
  }
}
