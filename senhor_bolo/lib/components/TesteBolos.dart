import 'package:flutter/material.dart';

import '../constants.dart';

class Teste extends StatefulWidget {
  const Teste({Key? key}) : super(key: key);

  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {

  List<String> sabores = [
    "Abacaxi",
    "Cenoura",
    "Chocolate",
    "Coco",
    "Laranja"
  ];


  String saborSelecionado = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Selecione o sabor da massa',
                  style: TextStyle(
                      fontSize: 25,
                      color: textSecondaryColor
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                    child: SizedBox(
                      width: 332,
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: sabores.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                saborSelecionado = sabores[index];
                                print(saborSelecionado);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                              height: 89,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  image: DecorationImage(image: NetworkImage('https://thespacefox.github.io/SenhorBolo-Imagens/images/sabores/' + sabores[index].toLowerCase() + '.png'),
                                      fit: BoxFit.none)
                              ),
                              child: Text(
                                sabores[index],
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, int index){
                          return SizedBox(height: 15,);
                        },
                      ),
                    )
                )
              ]
          ))
    );
  }
}
