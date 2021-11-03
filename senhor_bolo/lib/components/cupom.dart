import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../constants.dart';
import 'package:senhor_bolo/components/widgets/iconAppBar.dart';

class Cupom extends StatefulWidget {
  const Cupom({Key? key}) : super(key: key);

  @override
  _CupomState createState() => _CupomState();
}

class _CupomState extends State<Cupom> {
  static List _cupomName = ['5% OFF', '10% OFF', '5% OFF', '30% OFF'];
  static List _cupomDesc = [
    'Em todo app',
    'Compras acima de R\$20',
    'Em todo app',
    'Em todo app'
  ];
  int? cupomSelecionado;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: IconAppBar(
        appBarText: 'Meus cupons',
        appBarIcon: Icons.local_offer,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisExtent: 140,
                mainAxisSpacing: 20),
            itemCount: _cupomName.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                        cupomSelecionado = index;
                    });
                  },
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      width: 164,
                      height: 140,
                      decoration: BoxDecoration(
                        color: cupomSelecionado == index ? mainColor : Color(0xffE6E6E6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              _cupomName[index],
                              style: TextStyle(
                                  color: cupomSelecionado == index ?  mainTextColor : textSecondaryColor,
                                  fontFamily: 'Montserrat',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              _cupomDesc[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: cupomSelecionado == index ? mainTextColor : textSecondaryColor,
                                  fontSize: 15
                              ),
                            )
                          ],
                        ),
                      )));
            }),
      ),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 170,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Color(0xffF2F2F2),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary:  mainTextColor,
                          onPrimary: Colors.black),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Adicionar cupom",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Icon(Icons.add, size: 30)
                        ],
                      )),
                ),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: mainColor,
                          onPrimary:  mainTextColor),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Fechar Pedido",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("R\$20,00",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold))
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
