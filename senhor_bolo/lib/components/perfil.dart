import 'package:senhor_bolo/constants.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';


class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(464),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xffE6E6E6),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                  boxShadow: [
                BoxShadow(
                  color: Color(0x33000000),
                  offset: Offset(0, 2.0),
                  blurRadius: 4.0,
                )
              ]),
                padding: EdgeInsets.only(left: 20 ,right: 20),
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: 303,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                ),
            ),
              child: SafeArea(
              top: true,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(builder: (context){
                        return IconButton(
                            onPressed: () {Scaffold.of(context).openDrawer();},
                            iconSize: 40,
                            color: Colors.white,
                            icon: Icon(Icons.menu));
                      }),


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
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Image.asset('images/misaka10032.png', scale: 0.3,),
                            IconButton(onPressed: (){}, icon: Icon(Icons.home))
                          ],
                        ),
                        Text("Felipe Ribossomo")

                      ],
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
        height: size.height * 0.13,
        decoration: BoxDecoration(
            color: Color(0xffE6E6E6),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25)
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            simpleButton(175, 55, 'Adicionar', (){}, 25, 20, mainColor),
            simpleButton(175, 55, 'Limpar', (){}, 25, 20, redButtonColor),
          ],
        ),
      ),
    );
  }
}
