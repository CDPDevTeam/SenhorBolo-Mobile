import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:senhor_bolo/main.dart';
import '../../constants.dart';

class MeusPedidos extends StatelessWidget {
  const MeusPedidos({Key? key}) : super(key: key);

  static List _abertosNome = [
    "Haro Gay Estrogen",
    "nicolas"
  ];
  static List _abertosPreco = [
    "90,00",
    "50,00"
  ];
  static List _abertosImg = [
    "images/ricardinho_betoneira.jpeg",
    "images/cocada.png"
  ];
  static List _Nome = [
    "Bolo Crente",
    "BoloZap",
    "Bolo Nicolas"
  ];
  static List _Preco = [
    "90,00",
    "69,00",
    "99,00"
  ];
  static List _Img = [
    "images/ricardinho_betoneira.jpeg",
    "images/baba_portuguesa.png",
    "images/garma.jpeg"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
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
                          bottomLeft: Radius.circular(25),
                      )
                  ),
                  padding: EdgeInsets.only(left: 20 ,right: 20),
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
                                icon: Icon(Icons.menu)),
                            GestureDetector(
                                child: Row(
                                    children: [
                                      Column(
                                          children: <Widget>[
                                            Text(
                                              'Entregar em',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white
                                              ),
                                            ),
                                            Text(
                                              'Rua Humaitá, 538',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ]),
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    ]
                                )
                            ),

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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                                Icon(Icons.receipt, color: textMainColor, size: 40,),
                                Text(
                                  'Meus Pedidos',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                            ],
                          ),

                        )
                      ],
                    ),
                  ),
                )])
      ),
      body:  ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text("Em aberto:", style: TextStyle(fontSize: 25),),
            ),

            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
                itemCount: _abertosNome.length,
                itemBuilder: (context, index){
                return openOrder(_abertosNome[index], _abertosPreco[index], _abertosImg[index], context);
                }

            ),
            Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text("Concluídos:", style: TextStyle(fontSize: 25),),
            ),

          ],
        ),




    );
  }
}
Widget openOrder (String nome, String preco, String img, BuildContext context){
  return Card(
    //color: mainColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Material(
          child: Ink(
            decoration:BoxDecoration(color: mainColor,borderRadius: BorderRadius.all(Radius.circular(25))) ,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),

              splashColor: textMainColorFade,
              onTap: (){},
              child: Container(
                //decoration: BoxDecoration(color: mainColor,borderRadius: BorderRadius.all(Radius.circular(25))),
                padding: EdgeInsets.all(10),
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                height: 192,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Rastrear", style: TextStyle(color: textMainColor, fontSize: 25),),
                    Icon(Icons.near_me, size: 25, color: textMainColor,)
                  ],
                ),
              ) ,
            ),
          ),
        ),

        LayoutBuilder(builder: (ctx, constraints){
        return  Container(
          padding: EdgeInsets.all(20),
          width: constraints.maxWidth,
          height: 146,
          decoration: BoxDecoration(
            color: Color(0xffE6E6E6),
            borderRadius: BorderRadius.all(Radius.circular(25)
            ),),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pedido #0000",style: TextStyle(color: Color(0xff8E8E8E), fontSize: 25)),
              Container(
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        child: Image.asset(img, height: 75, width: 100, fit: BoxFit.fill,),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(nome,style: TextStyle(color: Color(0xff000000), fontSize: 17)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.local_shipping, color: Color(0xff575757),),
                                SizedBox(width: 10,),
                                Text("A caminho",style: TextStyle(color: Color(0xff575757), fontSize: 17)),
                              ],
                            ),
                          ],
                        ),
                    ),

                    ),
                    Container(
                      width: 70,
                      child: Text(preco, textAlign: TextAlign.center, style: TextStyle(color: Color(0xff000000), fontSize: 20, fontWeight: FontWeight.bold),) ,
                    )



                  ],
                ),
              )

            ],
          ));

        }),


      ],
    ),
  );
}