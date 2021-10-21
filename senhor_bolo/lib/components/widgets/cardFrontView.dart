import 'package:flutter/material.dart';
import '../../constants.dart';

Widget cardFrontView(Color corCartao, Size size, String cardNumber, Color corTextoCartao, String cardName, String _cardExpiration, String img){
  return Card(
    color: corCartao,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultButtonRadius)),
    child: Container(
      width: size.width * 0.89,
      height: size.height * 0.25,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Image>[
              Image.asset(
                img,
                width: 58,
                height: 36,
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/card.png',
                width: 49,
                height: 30,
              ),
              SizedBox(height: 5),
              Text(
                cardNumber,
                style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 20,
                    color: corTextoCartao
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nome',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 8,
                      color: corTextoCartao,
                    ),
                  ),
                  Text(
                    cardName,
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 18,
                        color: corTextoCartao
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'valido até',
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 8,
                        color: corTextoCartao
                    ),
                  ),
                  Text(
                    _cardExpiration,
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 18,
                        color: corTextoCartao
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}