import 'package:senhor_bolo/components/model/cake.dart';

class ShoppingCart{
  static List<Cake> cartItens = [];

  void addItem(Cake bolo){
    cartItens.add(bolo);
  }

  void removeItem(int indexBolo){
    cartItens.removeAt(indexBolo);
  }
}