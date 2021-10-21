import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/iconAppBar.dart';
import '../../constants.dart';

/// TODO: Mudar o design para algo estilo Amazon/ML

class MeusPedidos extends StatefulWidget {
  const MeusPedidos({Key? key}) : super(key: key);

  @override
  _MeusPedidosState createState() => _MeusPedidosState();
}

class _MeusPedidosState extends State<MeusPedidos> {
  static List _abertosNome = ["Haro Gay Estrogen", "nicolas"];
  static List _abertosPreco = ["90,00", "50,00"];
  static List _abertosImg = [
    "https://thespacefox.github.io/SenhorBolo-Imagens/images/usuario/ricardinho_betoneira.jpeg",
    "https://thespacefox.github.io/SenhorBolo-Imagens/images/cocada.png"
  ];
  static List _nome = ["Bolo Crente", "BoloZap", "Bolo Nicolas"];
  static List _preco = ["90,00", "69,00", "99,00"];
  static List _img = [
    "https://thespacefox.github.io/SenhorBolo-Imagens/images/usuario/ricardinho_betoneira.jpeg",
    "https://thespacefox.github.io/SenhorBolo-Imagens/images/cocada.png",
    "https://thespacefox.github.io/SenhorBolo-Imagens/images/baba_portuguesa.png"
  ];

  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IconAppBar(
        appBarText: 'Meus pedidos',
        appBarIcon: Icons.local_shipping,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              "Em aberto:",
              style: TextStyle(fontSize: 25),
            ),
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _abertosNome.length,
              itemBuilder: (context, index) {
                return openOrder(_abertosNome[index], _abertosPreco[index],
                    _abertosImg[index], context);
              }),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(
              "Concluídos:",
              style: TextStyle(fontSize: 25),
            ),
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _nome.length,
              itemBuilder: (context, index) {
                return closedOrder(
                    _nome[index], _preco[index], _img[index], "01/04/04");
              }),
        ],
      ),
    );
  }
}

Widget closedOrder(String nome, String preco, String img, String status) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25))),
    child: LayoutBuilder(builder: (ctx, constraints) {
      return Container(
          padding: EdgeInsets.all(20),
          width: constraints.maxWidth,
          height: 146,
          decoration: BoxDecoration(
            color: Color(0xffE6E6E6),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pedido #0000",
                  style: TextStyle(color: Color(0xff8E8E8E), fontSize: 25)),
              Container(
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        child: Image.network(
                          img,
                          height: 75,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(nome,
                                style: TextStyle(
                                    color: Color(0xff000000), fontSize: 17)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.done,
                                  color: Color(0xff575757),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text("Entregue em $status",
                                      style: TextStyle(
                                          color: Color(0xff575757),
                                          fontSize: 17)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      child: Text(
                        preco,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          ));
    }),
  );
}

Widget buildMenuItem({
  required String texto,
  IconData? icone,
}) {
  final hoverColor = Color(0xff14A8A2);
  return ListTile(
    leading: Icon(
      icone,
      color: Colors.white,
      size: 30,
    ),
    title: Text(
      texto,
      style: TextStyle(fontSize: 22, color: Colors.white),
    ),
    hoverColor: hoverColor,
    onTap: () {},
  );
}

Widget openOrder(String nome, String preco, String img, BuildContext context) {
  return Card(
    //color: mainColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25))),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Material(
          borderRadius: BorderRadius.circular(25),
          child: Ink(
            decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              splashColor: cardTextColor,
              onTap: () {},
              child: Container(
                //decoration: BoxDecoration(color: mainColor,borderRadius: BorderRadius.all(Radius.circular(25))),
                padding: EdgeInsets.all(10),
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                height: 192,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Rastrear",
                      style: TextStyle(color: mainTextColor, fontSize: 25),
                    ),
                    Icon(
                      Icons.near_me,
                      size: 25,
                      color: mainTextColor,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        LayoutBuilder(builder: (ctx, constraints) {
          return GestureDetector(
            onTap: () {
              print("$nome");
            },
            child: Container(
                padding: EdgeInsets.all(20),
                width: constraints.maxWidth,
                height: 146,
                decoration: BoxDecoration(
                  color: Color(0xffE6E6E6),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pedido #0000",
                        style:
                            TextStyle(color: Color(0xff8E8E8E), fontSize: 25)),
                    Container(
                      height: 75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              child: Image.network(
                                img,
                                height: 75,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(nome,
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontSize: 17)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.local_shipping,
                                        color: Color(0xff575757),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("A caminho",
                                          style: TextStyle(
                                              color: Color(0xff575757),
                                              fontSize: 17)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 70,
                            child: Text(
                              preco,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          );
        }),
      ],
    ),
  );
}
