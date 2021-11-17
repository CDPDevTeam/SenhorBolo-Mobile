import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senhor_bolo/classes/order.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/classes/shoppingCart.dart';
import 'package:senhor_bolo/components/widgets/iconAppBar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';


class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  final listKey = GlobalKey<AnimatedListState>();
  late bool cartHasProduct;
  late ShoppingCart carrinho;
  late Order order;

  void _goToCheckout(){
    if(order.orderAddress == null){
      CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        title: 'Selecione um endereço de entrega!',
      );
    } else {
      print('teste');
      Navigator.pushNamed(context, 'checkout');
    }
  }

  void removeItemAnimation(int index){
    final removedCake = carrinho.cartItens[index];
    carrinho.removeItem(index);
    listKey.currentState!.removeItem(
      index,
          (context, animation) => CakeCartItem(
        index: index,
        animation: animation,
        imgProduto: removedCake.image,
        nomeProduto: removedCake.name,
        categoriaProduto: removedCake.category,
        qtdeProduto: removedCake.qtde,
        precoProduto: removedCake.price,
        onClicked: (){},
        deleteProduto: true,
      ),
      duration: Duration(milliseconds: 200),
    );
  }

  void removeItem(int index){
    if(carrinho.cartItens.length - 1 == 0){
      removeItemAnimation(index);
      setState(() {
        cartHasProduct = false;
      });
    } else {
      removeItemAnimation(index);
    }
  }
  @override
  Widget build(BuildContext context) {

    carrinho = context.watch<ShoppingCart>();
    order = context.watch<Order>();
    cartHasProduct = carrinho.cartItens.isNotEmpty;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: IconAppBar(
        appBarText: 'Meu carrinho',
        appBarIcon: Icons.shopping_cart,
      ),
      body: cartHasProduct ? productList() : ListView(
        children: [
          const SizedBox(height: 20),
          const Text(
            'O seu carrinho está vazio!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Não sabe o que comprar? \nTemos vários bolos que esperam por você!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: textSecondaryColor
            ),
          )
        ],
      ),
      bottomNavigationBar: cartHasProduct ? Container(
        width: MediaQuery.of(context).size.width,
        height: 230,
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
          padding: const EdgeInsets.all(20),
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
                            style: const TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                color: Color(0xff9F9F9F)
                            ),
                            children: [
                              TextSpan(
                                  text: ' R\$' + carrinho.total.toStringAsFixed(2),
                                  style: const TextStyle(
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
                            style: const TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                color: Color(0xff9F9F9F)
                            ),
                            children: [
                              TextSpan(
                                  text: ' R\$10.00',
                                  style: const TextStyle(
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
                    onPressed: _goToCheckout,
                    child: Consumer<Order>(
                      builder: (context, order, child){
                        if(order.orderCoupon == null){
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Adicionar cupom",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold)),
                              const Icon(Icons.add, size: 30)
                            ],
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Cupom",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold)),
                              RichText(
                                text: TextSpan(
                                    text: '${order.orderCoupon!.discountPercentage}%',
                                    style: const TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 19,
                                        color: textSecondaryColor
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '${order.getCouponDiscount()}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black
                                          )
                                      )
                                    ]
                                ),
                              )
                            ],
                          );
                        }
                      },
                    ),
              )),
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
                    onPressed: _goToCheckout,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Fechar Pedido",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Consumer<Order>(
                          builder: (context, order, child){
                            return Text(
                                'R\$' + order.getOrderPrice().toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold));
                          },
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ) : null,
    );
  }

  Widget productList(){
    return ListView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: const Text(
            "Produtos",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
        AnimatedList(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          key: listKey,
          initialItemCount: carrinho.cartItens.length,
          itemBuilder: (context, index, animation){
            return CakeCartItem(
              index: index,
              animation: animation,
              imgProduto: carrinho.cartItens[index].image,
              nomeProduto: carrinho.cartItens[index].name,
              categoriaProduto: carrinho.cartItens[index].category,
              qtdeProduto: carrinho.cartItens[index].qtde,
              precoProduto: carrinho.cartItens[index].price,
              onClicked: () => removeItem(index),
              deleteProduto: false,
            );
          },
        )
      ],
    );
  }
}

class CakeCartItem extends StatelessWidget {
  final int index;
  final String imgProduto;
  final String nomeProduto;
  final String categoriaProduto;
  final int qtdeProduto;
  final double precoProduto;
  final VoidCallback? onClicked;
  final animation;
  final bool deleteProduto;

  const CakeCartItem({Key? key,
    required this.index,
    required this.imgProduto,
    required this.nomeProduto,
    required this.categoriaProduto,
    required this.qtdeProduto,
    required this.precoProduto,
    required this.animation,
    this.onClicked, required this.deleteProduto}) : super(key: key);

  List<DropdownMenuItem<int>> loadData() {
    List<DropdownMenuItem<int>> listDrop = [];
    for(int i = 1; i <= 10; i++){
      listDrop.add(DropdownMenuItem(
        child: Text(i.toString()),
        value: i,
      ));
    }
    return listDrop;
  }

  @override
  Widget build(BuildContext context) {

    final carrinho = context.watch<ShoppingCart>();

    return SlideTransition(
      key: ValueKey(imgProduto),
      position: Tween<Offset>(
          begin: Offset(-1,0),
          end: Offset.zero
      ).animate(animation),
      child: Container(
        height: 104,
        margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
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
                imageUrl: urlImagem + '/bolos/' + imgProduto,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          AutoSizeText(
                            nomeProduto,
                            maxLines: 2,
                            minFontSize: 15,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                          DropdownButton(
                            value: qtdeProduto,
                            items: loadData(),
                            hint: Consumer<ShoppingCart>(
                              builder: (context, produto, child){
                                if(deleteProduto){
                                  return Text(' ');
                                } else {
                                  return Text(produto.cartItens[index].qtde.toString());
                                }
                              },
                            ),
                            onChanged: (int? qtde){
                              carrinho.updateItem(index, qtde!);
                            },
                          ),
                          Text(
                              "R\$" + precoProduto.toStringAsPrecision(4),
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
              onTap: onClicked,
              child: Container(
                height: 33,
                width: 33,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xff88002A)),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}