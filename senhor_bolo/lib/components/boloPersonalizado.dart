import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/homepage.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import '../constants.dart';

class BoloPersonalizado extends StatefulWidget {
  const BoloPersonalizado({Key? key}) : super(key: key);

  @override
  _BoloPersonalizadoState createState() => _BoloPersonalizadoState();
}

class _BoloPersonalizadoState extends State<BoloPersonalizado> {

  String txtBtnVermelho = 'Cancelar';
  int indexPagina = 0;
  bool isFirstPage = true;

  Widget paginaSelecionada(){
    if (indexPagina == 1){
      return saborRecheio();
    } else if (indexPagina == 2){
      return coberturaBolo();
    } else {
      return saborBolo();
    }
  }

  void prosseguir(){
    if (indexPagina < 4){
      setState(() {
        indexPagina++;
        txtBtnVermelho = 'Voltar';
      });
    }
  }

  void voltar(){
    if (indexPagina > 0){
      indexPagina--;
      setState(() {
      });
      if (indexPagina == 0){
        txtBtnVermelho = 'Cancelar';
        setState(() {
        });
      }
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Homepage()));
    }
  }

  void cancelar(){
    print('Voltei');
  }

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
              child: SafeArea(
                top: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      child: Text(
                        'Bolo Personalizado',
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
            )])
        ),
        body: buildOpcoes(),
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
              simpleButton(175, 55, 'Prosseguir', prosseguir, 25, 20, mainColor),
              simpleButton(175, 55, txtBtnVermelho, voltar, 25, 20, redButtonColor),
            ],
          ),
        )
    );}

    Widget buildOpcoes() => PageTransitionSwitcher(
      duration: Duration(milliseconds: 800),
      transitionBuilder: (child, animation, secondaryAnimation) =>
          SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal
          ),
      child: paginaSelecionada(),
      //child: isFirstPage ? saborBolo() : saborRecheio(),
    );
}



class saborBolo extends StatefulWidget {
  const saborBolo({Key? key}) : super(key: key);

  @override
  _saborBoloState createState() => _saborBoloState();
}

class _saborBoloState extends State<saborBolo> {

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
    return SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: backgroundColor,
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
                  SizedBox(
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
                  ),
                ]
            )
        ));
  }
}

class saborRecheio extends StatefulWidget {
  const saborRecheio({Key? key}) : super(key: key);

  @override
  _saborRecheioState createState() => _saborRecheioState();
}

class _saborRecheioState extends State<saborRecheio> {

  List<String> recheios = [
    "Brigadeiro",
    "Doce de leite",
    "Geleia",
    "Goiabada",
  ];

  String saborSelecionado = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            color: backgroundColor,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Selecione o recheio',
                    style: TextStyle(
                        fontSize: 25,
                        color: textSecondaryColor
                    ),
                  ),
                  SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      saborSelecionado = 'Sem recheio';
                      print(saborSelecionado);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                    width: 332,
                    height: 89,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xffE9E9E9)
                    ),
                    child: Text(
                      'Sem recheio',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: textSecondaryColor
                      ),
                    ),
                  ),
                ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 332,
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: recheios.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              saborSelecionado = recheios[index];
                              print(saborSelecionado);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                            height: 89,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(image: NetworkImage('https://thespacefox.github.io/SenhorBolo-Imagens/images/recheios/' + recheios[index].toLowerCase() + '.png'),
                                    fit: BoxFit.none)
                            ),
                            child: Text(
                              recheios[index],
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
                  ),
                ]
            )
        ));
  }
}

class coberturaBolo extends StatefulWidget {
  const coberturaBolo({Key? key}) : super(key: key);

  @override
  _coberturaBoloState createState() => _coberturaBoloState();
}

class _coberturaBoloState extends State<coberturaBolo> {

  List<String> coberturas = [
    "Chocolate",
    "Doce de leite",
    "Glacê",
    "Goiabada",
    "Limão",
  ];

  String? saborSelecionado = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            color: backgroundColor,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Selecione a cobertura',
                    style: TextStyle(
                        fontSize: 25,
                        color: textSecondaryColor
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        saborSelecionado = null;
                        print(saborSelecionado);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                      width: 332,
                      height: 89,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xffE9E9E9)
                      ),
                      child: Text(
                        'Sem cobertura',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: textSecondaryColor
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 332,
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: coberturas.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              saborSelecionado = coberturas[index];
                              print(saborSelecionado);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                            height: 89,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(image: NetworkImage('https://thespacefox.github.io/SenhorBolo-Imagens/images/coberturas/' + coberturas[index].toLowerCase() + '.png'),
                                    fit: BoxFit.none)
                            ),
                            child: Text(
                              coberturas[index],
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
                  ),
                ]
            )
        ));
  }
}



