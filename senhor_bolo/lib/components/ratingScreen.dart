import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:senhor_bolo/components/widgets/produtoHorizontal.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/components/widgets/starRating.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/main.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _rating = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                              icon: Icon(Icons.arrow_back_ios)),

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
                        child: Text(
                          'Avalie seu pedido',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )  ,
        ),
        body:
            /*SingleChildScrollView(
              padding: EdgeInsets.only(left: 20 ,right: 20),
              child:*/
        Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Pedido #0000",style: TextStyle(fontSize: 25), ),
                  //SizedBox(height: 10),
                  ProdutoHorizontal(nomeProduto: "Bolo Crente", categoriaProduto: "", precoProduto: "999", imgProduto: "images/davi.png"),
                  //SizedBox(height: 10),
                  Text("Dê uma nota ao produto:",style: TextStyle(color: textSecondaryColor,fontSize: 17, fontWeight: FontWeight.w700),),
                  //SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Rating((rating){
                      setState(() {
                        _rating = rating;
                      });
                    }),
                      Text("$_rating/5", style: TextStyle(fontSize: 30),)

                  ],),
                  //SizedBox(height: 10),
                  Scrollbar(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              reverse: true,
                              child:
                                  SizedBox(
                                    //height: 224,
                                    child: TextField(
                                      maxLines: 8,
                                      decoration: const InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(),
                                          hintText: "Escreva o que achou do bolo"
                                      ),
                                    ),
                                  )

                            ),
                          ) ,
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
                                    onTap: (){

                                    },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Hero(
                                          tag: 'ImageViewer',
                                          child: Image.asset("images/davi.png", ),
                                        )
                                    ),
                                  ),

                                  SizedBox(width: 5,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset("images/davi.png", ),
                                  ),
                                  SizedBox(width: 5,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset("images/davi.png", ),
                                  ),
                                  SizedBox(width: 5,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset("images/davi.png", ),
                                  ),
                                  SizedBox(width: 5,),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset("images/davi.png", ),
                                  ),
                                ],
                              ),
                            )
                        ),
                        SizedBox(width: 10,),
                        simpleButtonIconeOnly(85, 55, (){}, 10, 10, mainColor, Icon(Icons.add_a_photo), FontWeight.normal)
                        //simpleButtonIcon(83, 55, "", (){}, 25, 0, mainColor, Icon(Icons.camera), FontWeight.normal)

                      ],
                    ),
                  ),
                  ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width ,
                        minHeight: 55,
                      ),
                    child: simpleButtonIcon(368, 51, "Enviar Feedback", (){}, 25, 20, mainColor, Icon(Icons.edit), FontWeight.normal),
                  ),
                  /*Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                      ],
                    )

                  ),*/

                ],
              ),
        )
            //),




    );

  }
}

