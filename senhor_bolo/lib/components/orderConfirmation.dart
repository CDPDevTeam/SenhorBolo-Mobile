import "package:flutter/material.dart";
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/constants.dart';

class CardDenied extends StatelessWidget {
  CardDenied({Key? key}) : super(key: key);
  final String _resultConfirmacao = "Compra falhou";
  final Icon _resultIcon = Icon(Icons.error, size: 70, color: mainTextColor);
  final Color _resultCor = Color(0xff88002A);
  final String numPedido = "#000000";

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 285,
                decoration: BoxDecoration(
                  color: _resultCor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _resultIcon,
                    Text(_resultConfirmacao, style: TextStyle(
                        color: mainTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 40)),
                  ],
                )
            ),
            Expanded(
                child: Center(
                    child: Text(
                      "Seu cartão não foi aprovado, tente novamente!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),
                )
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  simpleButtonIcon(
                      368,
                      51,
                      "Entre em contato", () {},
                      10,
                      20,
                      _resultCor,
                      Icon(Icons.chat_bubble),
                      FontWeight.normal),
                  simpleButtonIcon(
                      368,
                      51,
                      "Voltar", () {},
                      10,
                      20,
                      mainColor,
                      Icon(Icons.arrow_back),
                      FontWeight.normal)
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
  final Icon _resultIcon = Icon(
      Icons.check_circle, size: 70, color: mainTextColor);
  final Color _resultCor = Color(0xff008824);
  final String numPedido = "#000000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 285,
                decoration: BoxDecoration(
                  color: _resultCor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _resultIcon,
                    Text(_resultConfirmacao, style: TextStyle(
                        color: mainTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 40)),
                  ],
                )
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Seu pedido já está a caminho :)!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  simpleButtonIcon(
                      368,
                      51,
                      "Ver pedido", () {},
                      20,
                      20,
                      Color(0xff089C97),
                      Icon(Icons.cake),
                      FontWeight.normal),
                  simpleButtonIcon(
                      368,
                      51,
                      "Voltar", () => Navigator.pushReplacementNamed(context, 'homepage'),
                      20,
                      20,
                      mainColor,
                      Icon(Icons.arrow_back),
                      FontWeight.normal)
                ],
              ),
            )
          ],
        )
    );
  }
}
