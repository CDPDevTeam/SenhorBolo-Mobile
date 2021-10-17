import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/iconAppBar.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IconAppBar(appBarText: 'Carrinho', appBarIcon: Icons.shopping_cart,),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [

        ],
      ),
    );
  }
}
