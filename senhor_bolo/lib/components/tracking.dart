import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/addressPicker.dart';

/// TODO: Mudar para uma tela de Tracking estilo Amazon

class Tracking extends StatefulWidget {
  const Tracking({Key? key}) : super(key: key);

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  static List _enderecos = [
    "R. Tiro ao Pombo",
    "R. Borboletas Psicodélicas",
    "Rua zap"
  ];
  static List _cep = ["03080000", "04050000", "00000000"];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.20),
        child: Column(
          children: [
            Container(
              height: size.height * 0.22,
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25))),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SafeArea(
                top: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            iconSize: 40,
                            color: Colors.white,
                            icon: Icon(Icons.arrow_back_ios)),
                        CachedNetworkImage(
                            imageUrl:
                                'https://thespacefox.github.io/SenhorBolo-Imagens/images/usuario/ricardinho_betoneira.jpeg',
                            imageBuilder: (context, imageProvider) => Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fitWidth)),
                                ))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Seu pedido',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), topLeft: Radius.circular(25)),
        ),
        width: MediaQuery.of(context).size.width,
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Seus endereços",
              style: TextStyle(color: textMainColor, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _enderecos.length,
                itemBuilder: (context, index) {
                  return enderecoBlock(_enderecos[index], _cep[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
