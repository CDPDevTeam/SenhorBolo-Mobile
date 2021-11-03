import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/classes/shoppingCart.dart';
import 'package:senhor_bolo/components/widgets/iconAppBar.dart';
import 'package:senhor_bolo/constants.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<AnimatedListState> _cartListkey =
      GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: IconAppBar(
        appBarText: 'Meu carrinho',
        appBarIcon: Icons.shopping_cart,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              "Produtos",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          AnimatedList(
            key: _cartListkey,
            initialItemCount: ShoppingCart.cartItens.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index, animation) {
              return Column(
                children: [
                  cartItem(
                  context,
                  index,
                  animation,
                  ShoppingCart.cartItens[index].name,
                  ShoppingCart.cartItens[index].category,
                  ShoppingCart.cartItens[index].price,
                  ShoppingCart.cartItens[index].image,
                  1),
                  const SizedBox(height: 10)
                ],
              );
            },
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 230,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Color(0xffF2F2F2),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: 'Subtotal',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff9F9F9F)
                              ),
                              children: [
                                TextSpan(
                                    text: " R\$25,00",
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.black
                                    )
                                ),
                              ]
                          )
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'Frete',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff9F9F9F)
                              ),
                              children: [
                                TextSpan(
                                    text: " R\$7,00",
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.black
                                    )
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: mainTextColor,
                          onPrimary: Colors.black),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Adicionar cupom",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Icon(Icons.add, size: 30)
                        ],
                      )),
                ),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: mainColor,
                          onPrimary: mainTextColor),
                      onPressed: () => Navigator.pushNamed(context, 'checkout'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Fechar Pedido",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const Text("R\$32,00",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold))
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cartItem(
      BuildContext context,
      int index,
      animation,
      String nomeProduto,
      String categoriaProduto,
      int precoProduto,
      String imgProduto,
      int qtde) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset(0, 0))
          .animate(animation),
      child: Container(
        height: 104,
        margin: const EdgeInsets.only(left: 20, right: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 104,
              width: 104,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: mainColor,
              ),
              child: CachedNetworkImage(
                imageUrl: urlImagem + imgProduto,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      AutoSizeText(
                        nomeProduto,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        categoriaProduto,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 53,
                          height: 32,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xffF5F5F5),
                              border: Border.all(
                                  color: Color(0xffE6E6E6), width: 2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("1"),
                              Icon(Icons.keyboard_arrow_down)
                            ],
                          ),
                        ),
                      ),
                      Text(
                          "R\$ $precoProduto,00",
                          style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat')
                      )
                    ],
                  )
                ],
              ),
            )),
            InkWell(
              onTap: () {
                print(index);
                _cartListkey.currentState!.removeItem(
                    0, (_, animation) => cartItem(context, 0, animation,
                        nomeProduto,
                        categoriaProduto,
                        precoProduto,
                        imgProduto,
                        qtde),
                duration: const Duration(milliseconds: 150));
                ShoppingCart.removeItem(index);
              },
              child: Container(
                height: 33,
                width: 33,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xff88002A)),
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
