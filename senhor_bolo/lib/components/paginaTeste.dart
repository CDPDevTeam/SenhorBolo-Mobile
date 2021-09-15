import 'package:flutter/material.dart';
import 'package:senhor_bolo/constants.dart';

class PaginaTeste extends StatefulWidget {
  const PaginaTeste({Key? key}) : super(key: key);

  @override
  _PaginaTesteState createState() => _PaginaTesteState();
}

class _PaginaTesteState extends State<PaginaTeste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      toolbarHeight: 88,
      centerTitle: true,
      leading: InkWell(
        onTap:  () => Navigator.of(context).pop(),
        child: Icon(
          Icons.keyboard_arrow_left,
          color: Colors.white,
          size: 50,
        ),
      ),
      title: GestureDetector(
        onTap: () {
          print('Tocou no endereço');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: <Text>[
                Text(
                  'Entregar em',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'Rua Humaitá, 538',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w100,
                      color: Colors.white),
                ),
              ],
            ),
            Icon(
              Icons.location_on,
              color: Colors.white,
              size: 20,
            )
          ],
        ),
      ),
      actions: <Widget>[
        GestureDetector(
            onTap: () {
              print('Tocou na foto');
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 25,
                backgroundImage:
                AssetImage('images/ricardinho_betoneira.jpeg'),
              ),
            ))
      ],
    ),
    body: Container(
      width: double.infinity,
      height: 88,
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25)
        )
      ),
      child: Row(
        children: [
          Icon(
            Icons.shopping_cart
          )
        ],
      ),
    ),
    );
  }
}
