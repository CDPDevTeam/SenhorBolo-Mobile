import "package:flutter/material.dart";
import 'package:senhor_bolo/components/widgets/produtoHorizontal.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/main.dart';

class PedidoEntregue extends StatelessWidget {
  PedidoEntregue({Key? key}) : super(key: key);
  var numPedido = "#000000";

  @override

  Widget build(BuildContext context) {
    return  Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 285,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_shipping, size: 70, color: textMainColor),
                    Text("Seu pedido foi entregue!", textAlign: TextAlign.center ,style: TextStyle(color: textMainColor, fontWeight: FontWeight.bold, fontSize: 30 )),
                  ],
                )
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Seu pedido $numPedido foi entregue",style: TextStyle(fontSize: 20),),
                  ProdutoHorizontal(nomeProduto: "Bolo Crente", categoriaProduto: "", precoProduto: "999", imgProduto: "images/davi.png")
                ],

              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  simpleButtonIcon(368, 51, "Deixar uma avaliação", (){}, 25, 20, Color(0xffDFA41B), Icon(Icons.star_rate), FontWeight.normal),
                  simpleButtonIcon(368, 51, "Reportar um problema", (){}, 25, 20, Color(0xff88002A), Icon(Icons.chat_bubble), FontWeight.normal),
                  simpleButtonIcon(368, 51, "Voltar", (){}, 25, 20, mainColor, Icon(Icons.arrow_back), FontWeight.normal)
                ],
              ),

            )




          ],
        )
    );

  }
}
