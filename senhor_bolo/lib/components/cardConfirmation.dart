

import "package:flutter/material.dart";
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/constants.dart';

class CardDenied extends StatelessWidget {
  CardDenied({Key? key}) : super(key: key);
  final String _resultConfirmacao = "Compra falhou";
  final Icon _resultIcon = Icon(Icons.error, size: 70, color: textMainColor);
  final Color _resultCor = Color(0xff88002A);
  var numPedido = "#000000";

  @override

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
                      color: _resultCor,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _resultIcon,
                        Text(_resultConfirmacao, style: TextStyle(color: textMainColor, fontWeight: FontWeight.bold, fontSize: 40 )),
                      ],
                    )
                ),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Text("Seu pedido $numPedido foi rejeitado",style: TextStyle(fontSize: 20),),],

              ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      simpleButtonIcon(368, 51, "Entre em contato", (){}, 25, 20, _resultCor, Icon(Icons.chat_bubble), FontWeight.normal),
                      simpleButtonIcon(368, 51, "Voltar", (){}, 25, 20, mainColor, Icon(Icons.arrow_back), FontWeight.normal)
                    ],
                ),

            )




          ],
        )
    );

  }
}
class CardConfirmed extends StatelessWidget {
  CardConfirmed({Key? key}) : super(key: key);
  final String _resultConfirmacao = "Compra concluída";
  final Icon _resultIcon = Icon(Icons.check_circle, size: 70, color: textMainColor);
  final Color _resultCor = Color(0xff008824);
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
                  color: _resultCor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _resultIcon,
                    Text(_resultConfirmacao, style: TextStyle(color: textMainColor, fontWeight: FontWeight.bold, fontSize: 40 )),
                  ],
                )
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text("Seu pedido #zapzap foi rejeitado",style: TextStyle(fontSize: 20),),],

              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  simpleButtonIcon(368, 51, "Entre em contato", (){}, 25, 20, _resultCor, Icon(Icons.chat_bubble), FontWeight.normal),
                  simpleButtonIcon(368, 51, "Voltar", (){}, 25, 20, mainColor, Icon(Icons.arrow_back), FontWeight.normal)
                ],
              ),

            )




          ],
        )
    );

  }
}
