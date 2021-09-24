import 'package:flutter/cupertino.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/homepage.dart';
import 'package:senhor_bolo/components/addressPicker.dart';
import 'package:senhor_bolo/main.dart';

class Rastreio extends StatefulWidget {
  const Rastreio({Key? key}) : super(key: key);

  @override
  _RastreioState createState() => _RastreioState();
}

class _RastreioState extends State<Rastreio> {
  static List _enderecos = [
    "R. Tiro ao Pombo",
    "R. Borboletas Psicodélicas",
    "Rua zap"
  ];
  static List _cep = [
    "03080000",
    "04050000",
    "00000000"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(224),
          child:
          Container(
            height: 224,
            decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)
                )
            ),
            padding: EdgeInsets.only(left: 20 ,right: 20),
            child: SafeArea(
              top: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          iconSize: 40,

                          color: Colors.white,
                          icon: Icon(Icons.menu)),

                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 43,
                          height: 43,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('images/ricardinho_betoneira.jpeg'),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      )
                    ],
                  ),

                  Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.edit_location, color: textMainColor),
                              Text("Entregar em",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textMainColor),)
                            ],
                          ),
                          TextField(
                            style: TextStyle(color: textMainColor),
                            decoration: const InputDecoration(
                              hintText: "Rua Humaítá, 638",
                              hintStyle: TextStyle(color: textMainColorFade),
                              labelStyle: TextStyle(color: textMainColor),

                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          )


      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25)
          ),),
        width: MediaQuery.of(context).size.width,
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Seus endereços", style: TextStyle(color: textMainColor, fontSize: 20 ),),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _enderecos.length,
                itemBuilder:(context, index) {
                  return enderecoBlock(_enderecos[index], _cep[index]);
                },
              ),
            )

          ],
        ) ,
      ),
    );;
  }
}

