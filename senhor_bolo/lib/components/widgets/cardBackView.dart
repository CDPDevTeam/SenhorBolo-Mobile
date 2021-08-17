import 'dart:math';
import 'package:flutter/material.dart';
import '../../constants.dart';

class CardBackView extends StatelessWidget {

  Color corCartao;
  Size size;
  Color corTexto;
  String cvvText, img;


  CardBackView({Key? key, required this.corCartao, required this.size, required this.corTexto, required this.cvvText, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(pi * 1),
        origin: Offset(MediaQuery.of(context).size.width / 2, 0),
        child :Card(
          color: corCartao,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultRadius)),
          child: Container(
            width: size.width * 0.89,
            height: size.height * 0.25,
            padding: const EdgeInsets.only(top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: size.height * 0.048,
                  color: Colors.black,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      img,
                      width: 58,
                      height: 36,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assinatura autorizada',
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 8,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),
                        Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [
                            Container(
                              width: size.width * 0.61,
                              height: size.height * 0.04,
                              color: Colors.white,
                            ),
                            Text(
                              '$cvvText ',
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}
