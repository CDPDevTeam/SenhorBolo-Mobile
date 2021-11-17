import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:senhor_bolo/classes/order.dart';
import 'package:senhor_bolo/classes/shoppingCart.dart';
import 'package:senhor_bolo/components/widgets/produtoHorizontal.dart';
import 'package:senhor_bolo/components/widgets/shimmerProdutoHorizontal.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/model/cake.dart';
import '../services/cakeService.dart';

class CakeDetail extends StatefulWidget {

  final int idProduto;
  final String nomeProduto;
  final String categoriaProduto;
  final String imgProduto;
  final double precoProduto;

  const CakeDetail({Key? key,
    required this.nomeProduto,
    required this.categoriaProduto,
    required this.imgProduto,
    required this.precoProduto,
    required this.idProduto}) : super(key: key);

  @override
  _CakeDetailState createState() => _CakeDetailState();
}

class _CakeDetailState extends State<CakeDetail> {

  CakeService api = CakeService();
  late Future<List<Cake>> _recommendedCakes;
  int _qtdeItem = 1;

  void _adicionarCarrinho() {
    var shoppingCart = context.read<ShoppingCart>();
    Cake bolo = Cake(
        id: widget.idProduto,
        name: widget.nomeProduto,
        category: widget.categoriaProduto,
        image: widget.imgProduto,
        price: widget.precoProduto,
        qtde: _qtdeItem
    );
    shoppingCart.addItem(bolo);
  }

  @override
  void initState() {
    super.initState();
    _recommendedCakes = api.recommendedCake();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 88,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
            size: 50,
          ),
        ),
        title: InkWell(
          onTap: () => Navigator.pushNamed(context, 'addressPicker'),
          child:Column(
            children: <Widget>[
              const Text(
                'Entregar em',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Consumer<Order> (
                  builder: (context, order, child) {
                    late String endereco;
                    if (order.orderAddress == null){
                      endereco = 'Selecione um endereço';
                    } else {
                      endereco = order.orderAddress!.rua + ', '
                          + order.orderAddress!.num;
                    }
                    return Text(
                      endereco,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                    );
                  }
              )
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'searchPage'),
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          ),
          Badge(
            position: BadgePosition.topEnd(top: 18, end: 6),
            badgeContent: Consumer<ShoppingCart> (
              builder: (context, shoppingCart, child){
                return Text(
                  shoppingCart.cartItens.length.toString(),
                  style: const TextStyle(color: mainTextColor, fontFamily: 'Roboto'),
                );
              },
            ),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, 'shoppingCart'),
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          Container(
            width: screenSize.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                        color: const Color(0xff64CBC7),
                        borderRadius: BorderRadius.circular(25),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: urlImagem + '/bolos/' + widget.imgProduto,
                      errorWidget: (context, url, error) => const Center(
                        child: Text(
                          'Erro ao carregar a imagem :(',
                          style: TextStyle(
                            color: mainTextColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, bottom: 30),
                      child: SizedBox(
                        width: 237,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              widget.nomeProduto,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  height: 0.95
                              ),
                            ),
                            Text(
                              widget.categoriaProduto,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textSecondaryColor
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Descrição simples do bolo, olha que bolo bonito esse, não quer comprar?',
                              style: TextStyle(
                                fontSize: 14,
                                color: textSecondaryColor
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Tabela nutricional >',
                              style: TextStyle(
                                fontSize: 15,
                                color: mainColor
                              ),
                            )
                          ],
                        ),
                      )
                    ),
                    Container(
                      width: 108,
                      height: 81,
                      decoration: const BoxDecoration(
                          color: Color(0xff00A59F),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25))),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'R\$',
                                      style: TextStyle(fontSize: 25)),
                                  TextSpan(
                                      text: (widget.precoProduto.toInt()).toString(),
                                      style: TextStyle(fontSize: 35)),
                                ]),
                          ),
                        )
                    )
                  ],
                )
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Text(
              'Outros produtos',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder<List<Cake>>(
            future: _recommendedCakes,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return Center(
                    child: SizedBox(
                      width: 328,
                      child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ProdutoHorizontal(
                              nomeProduto: snapshot.data![index].name,
                              categoriaProduto: snapshot.data![index].category,
                              precoProduto: snapshot.data![index].price.toDouble(),
                              imgProduto: snapshot.data![index].image,
                              idProduto: snapshot.data![index].id);
                        },
                        separatorBuilder: (context, int index) {
                          return const SizedBox(height: 20);
                        },
                      ),
                    )
                );
              } else if (snapshot.hasError){
                return Text('${snapshot.error}');
              }
              return Center(
                  child: SizedBox(
                    width: 328,
                    child: ListView.separated(
                      itemCount: 4,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return const ShimmerProdutoHorizontal();
                      },
                      separatorBuilder: (context, int index) {
                        return const SizedBox(height: 20);
                      },
                    ),
                  )
              );
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Você chegou ao fim ^_^',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 20),
        ],
      ),

        bottomNavigationBar: Container(
          height: 90,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_qtdeItem > 1) {
                    HapticFeedback.selectionClick();
                    setState(() {
                      _qtdeItem--;
                    });
                  }
                },
                child: const Icon(
                  Icons.remove,
                  size: 30,
                  color: Colors.black,
                ),
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xffF5F5F5),
                    shape: const CircleBorder(),
                    minimumSize: const Size(48.0, 48.0)),
              ),
              Text(
                '$_qtdeItem',
                style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  HapticFeedback.selectionClick();
                  setState(() {
                    _qtdeItem++;
                  });
                },
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.black,
                ),
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xffF5F5F5),
                    shape: const CircleBorder(),
                    minimumSize: const Size(48.0, 48.0)),
              ),
              simpleButton(199, 39, 'Adicionar ao carrinho', _adicionarCarrinho,
                  10, 16, mainColor)
            ],
          ),
        )
    );
  }
}