import 'package:flutter/material.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:senhor_bolo/components/imageViewer.dart';
import 'package:senhor_bolo/components/widgets/produtoHorizontal.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';

class DeliveryProblem extends StatefulWidget {
  const DeliveryProblem({Key? key}) : super(key: key);

  @override
  _DeliveryProblemState createState() => _DeliveryProblemState();
}

class _DeliveryProblemState extends State<DeliveryProblem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(160),
          child: AppBar(
            elevation: 0,
            toolbarHeight: 88,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            leading: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
                size: 50,
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'userProfile'),
                  child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lulz Ricardo',
                            style:
                                TextStyle(fontSize: 16, color: mainTextColor),
                          ),
                          SizedBox(width: 10),
                          CachedNetworkImage(
                              imageUrl: 'https://thespacefox.github.io/SenhorBolo-Imagens/images/usuario/ricardinho_betoneira.jpeg',
                              imageBuilder: (context, imageProvider) => Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fitWidth)),
                              )
                          )
                        ],
                      )))
            ],
            bottom: PreferredSize(
              //Exigido por causa do null safety, mas aqui não faz diferença
              preferredSize: Size.fromHeight(0),
              child: Container(
                  width: double.infinity,
                  height: 70,
                  child: Text(
                    'O que houve de errado ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: mainTextColor),
                  )),
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Container(
            height: size.height * 0.70,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pedido #0000",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color(0xff8E8E8E)
                  ),
                ),

                ProdutoHorizontal(
                    nomeProduto: "Brigadeiro",
                    categoriaProduto: "Bolo doce",
                    precoProduto: 12,
                    imgProduto: 'brigadeiro.png'),

                Text(
                  "Diga-nos o que aconteceu:",
                  style: TextStyle(
                      color: textSecondaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),

                TextField(
                  maxLines: 8,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Container(
                            height: 100,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => ImageViewer()));
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Hero(
                                        tag: 'ImageViewer',
                                        child: Image.asset(
                                          "images/davi.png",
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "images/davi.png",
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      simpleButtonIconeOnly(85, 55, () {}, 10, 10, mainColor,
                          Icon(Icons.add_a_photo), FontWeight.normal)
                      //simpleButtonIcon(83, 55, "", (){}, 25, 0, mainColor, Icon(Icons.camera), FontWeight.normal)
                    ],
                  ),
                ),

                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: 55,
                  ),
                  child: simpleButtonIcon(368, 51, "Enviar Feedback", () {}, 25,
                      20, mainColor, Icon(Icons.edit), FontWeight.normal),
                ),
              ],
            ),
          ),
        )
    );
  }
}
