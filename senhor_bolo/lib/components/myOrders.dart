import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:senhor_bolo/components/widgets/iconAppBar.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MeusPedidos extends StatefulWidget {
  const MeusPedidos({Key? key}) : super(key: key);

  @override
  _MeusPedidosState createState() => _MeusPedidosState();
}

class _MeusPedidosState extends State<MeusPedidos> {
  static List _abertosNome = ["Haro Gay Estrogen", "Nicolas"];
  static List _abertosPreco = ["90,00", "50,00"];
  static List _abertosImg = [
    "https://thespacefox.github.io/SenhorBolo-Imagens/images/baba_portuguesa.png",
    "https://thespacefox.github.io/SenhorBolo-Imagens/images/cocada.png"
  ];
  static List _nome = ["Bolo Crente", "BoloZap", "Bolo Nicolas"];
  static List _preco = ["90,00", "69,00", "99,00"];
  static List _img = [
    "https://thespacefox.github.io/SenhorBolo-Imagens/images/cocada.png",
    "https://thespacefox.github.io/SenhorBolo-Imagens/images/cocada.png",
    "https://thespacefox.github.io/SenhorBolo-Imagens/images/baba_portuguesa.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: IconAppBar(
        appBarText: 'Meus pedidos',
        appBarIcon: Icons.local_shipping,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            const Text(
              "Pedidos em aberto",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _abertosNome.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Pedido #0000",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ProdutoPedido(qtde: 32, nomeProduto: _abertosNome[index], categoriaProduto: "Bolo comum", precoProduto: _abertosPreco[index], imgProduto: _abertosImg[index]),
                        const SizedBox(height: 10),
                        simpleButtonIcon(306, 47, 'Rastrear', (){}, 10, 25, mainColor, Icon(Icons.near_me), FontWeight.bold),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  );
                }),
            const Text(
              "Concluído",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _nome.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Pedido #0000",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ProdutoPedido(qtde: 32, nomeProduto: _nome[index], categoriaProduto: "Bolo comum", precoProduto: _preco[index], imgProduto: _img[index]),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                }),
          ],
        ),
      )
    );
  }
}

class ProdutoPedido extends StatelessWidget {
  final String nomeProduto;
  final String categoriaProduto;
  final String precoProduto;
  final String imgProduto;
  final int qtde;
  const ProdutoPedido(
      {Key? key,
        required this.qtde,
        required this.nomeProduto,
        required this.categoriaProduto,
        required this.precoProduto,
        required this.imgProduto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 104,
            height: 104,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: mainColor,
            ),
            child: CachedNetworkImage(
              imageUrl: imgProduto,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
              child: Padding (
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nomeProduto,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          categoriaProduto,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(text: "qtde ", style: TextStyle(fontSize: 12)),
                                  TextSpan(text: "32")
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(text: "total ", style: TextStyle(fontSize: 12)),
                                  TextSpan(text: "R\$ $precoProduto")
                                ]
                            )
                        ),
                      ],
                    )
                  ],
                ) ,
              )
          )
        ],
      ),
    );
  }
}