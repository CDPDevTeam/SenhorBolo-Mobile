import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:senhor_bolo/main.dart';
import '../../constants.dart';

class MeusCupons extends StatefulWidget {
  const MeusCupons({Key? key}) : super(key: key);

  @override
  _MeusCuponsState createState() => _MeusCuponsState();
}

class _MeusCuponsState extends State<MeusCupons> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: Material(
          color: mainColor,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 67,
                      backgroundImage: AssetImage('images/ricardinho_betoneira.jpeg'),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Lulz Ricardo',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Text(
                      'lricardosp@gmail.com',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              buildMenuItem(texto: 'Minha conta', icone: Icons.account_circle),
              buildMenuItem(texto: 'Meus pedidos', icone: Icons.cake),
              buildMenuItem(texto: 'Cupons', icone: Icons.local_offer),
              buildMenuItem(texto: 'Ajuda', icone: Icons.help),
              buildMenuItem(texto: 'Sobre nós', icone: Icons.info),
              Divider(color: Colors.white),
              buildMenuItem(texto: 'Logout', icone: Icons.logout)
            ],
          ),
        ),
      ),
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
      /*body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
          itemBuilder: (context, index){
            return ;
          }) ,*/




    );
  }
}
//Widget cupomTile (String desconto, String descricao)