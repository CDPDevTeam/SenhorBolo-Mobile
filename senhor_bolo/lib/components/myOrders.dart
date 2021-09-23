import 'package:flutter/material.dart';
import '../../constants.dart';

class MeusPedidos extends StatelessWidget {
  const MeusPedidos({Key? key}) : super(key: key);

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
                          bottomLeft: Radius.circular(25)
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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              children: [
                Card()
              ],
            )
          ],
        ),
      )
    );
  }
}
