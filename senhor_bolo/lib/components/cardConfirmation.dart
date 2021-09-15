

import "package:flutter/material.dart";
import 'package:senhor_bolo/constants.dart';

class CardConfirmation extends StatefulWidget {
  const CardConfirmation({Key? key}) : super(key: key);

  @override
  _CardConfirmationState createState() => _CardConfirmationState();
}

class _CardConfirmationState extends State<CardConfirmation> {
  String _resultConfirmacao = "Sua compra..";
  Icon _resultIcon = Icon(Icons.help_rounded, size: 70, color: textMainColor);
  Color _resultCor = mainColor;
  var numPedido = "#000000";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
                Container(
                    padding: EdgeInsets.fromLTRB(20, 80, 20, 80),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.40,
                    decoration: BoxDecoration(
                      color: _resultCor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _resultIcon,
                        Text(_resultConfirmacao, style: TextStyle(color: textMainColor, fontWeight: FontWeight.bold, fontSize: 40 )),
                      ],
                    )
                ),
              Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("Seu pedido #zapzap foi rejeitado",style: TextStyle(fontSize: 20),),
                  ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: (){},
                          child: Text("zap"))
                    ],
                ),

            )




          ],
        )
    );

  }
}
