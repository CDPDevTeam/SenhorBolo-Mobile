import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/homepage.dart';
import 'package:senhor_bolo/components/widgets/iconAppBar.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import '../constants.dart';

class CustomCake extends StatefulWidget {
  const CustomCake({Key? key}) : super(key: key);

  @override
  _CustomCakeState createState() => _CustomCakeState();
}

class _CustomCakeState extends State<CustomCake> {
  String txtBtnVermelho = 'Cancelar';
  int indexPagina = 0;
  bool isFirstPage = true;

  Widget paginaSelecionada() {
    if (indexPagina == 1) {
      return FillingFlavour();
    } else if (indexPagina == 2) {
      return CakeTopping();
    } else {
      return CakeFlavour();
    }
  }

  void prosseguir() {
    if (indexPagina < 3) {
      setState(() {
        indexPagina++;
        txtBtnVermelho = 'Voltar';
      });
    }
  }

  void voltar() {
    if (indexPagina > 0) {
      indexPagina--;
      setState(() {});
      if (indexPagina == 0) {
        txtBtnVermelho = 'Cancelar';
        setState(() {});
      }
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Homepage()));
    }
  }

  void cancelar() {
    print('Voltei');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: IconAppBar(
          appBarIcon: Icons.cake,
          appBarText: 'Bolo personalizado',
        ),
        body: buildOpcoes(),
        bottomNavigationBar: Container(
          height: size.height * 0.13,
          decoration: BoxDecoration(
              color: Color(0xffE6E6E6),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              simpleButton(
                  175, 55, 'Prosseguir', prosseguir, 25, 20, mainColor),
              simpleButton(
                  175, 55, txtBtnVermelho, voltar, 25, 20, redButtonColor),
            ],
          ),
        ));
  }

  Widget buildOpcoes() => PageTransitionSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: (child, animation, secondaryAnimation) =>
            SharedAxisTransition(
                child: child,
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal),
        child: paginaSelecionada(),
      );
}

class CakeFlavour extends StatefulWidget {
  const CakeFlavour({Key? key}) : super(key: key);

  @override
  _CakeFlavourState createState() => _CakeFlavourState();
}

class _CakeFlavourState extends State<CakeFlavour> {
  List<String> sabores = ["Abacaxi", "Cenoura", "Chocolate", "Coco", "Laranja"];

  String saborSelecionado = "";

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(height: 15),
        Text(
          'Selecione o sabor da massa',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, color: textSecondaryColor),
        ),
        SizedBox(height: 15),

        Center(
          child: SizedBox(
            width: 350,
            child: ListView.separated(
              itemCount: sabores.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      setState(() {
                        saborSelecionado = sabores[index];
                        print(saborSelecionado);
                      });
                    },
                  child: CachedNetworkImage(
                      imageUrl: 'https://thespacefox.github.io/SenhorBolo-Imagens/images/sabores/' + sabores[index].toLowerCase() + '.png',
                      imageBuilder: (context, imageProvider) => Container(
                        height: 89,
                        padding: EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
                        ),
                        child: Text(
                          sabores[index],
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                  )
                );
              } ,
              separatorBuilder: (context, int index){
                return SizedBox(height: 10);
              },
            ),
          ),
        )
      ],
    );
  }
}

class FillingFlavour extends StatefulWidget {
  const FillingFlavour({Key? key}) : super(key: key);

  @override
  _FillingFlavourState createState() => _FillingFlavourState();
}

class _FillingFlavourState extends State<FillingFlavour> {
  List<String> recheios = [
    "Brigadeiro",
    "Doce de leite",
    "Geleia",
    "Goiabada",
  ];

  String recheioSelecionado = "";

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [

        SizedBox(height: 15),
        Text(
          'Selecione o tipo de recheio',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, color: textSecondaryColor),
        ),
        SizedBox(height: 15),

        Center(
          child: SizedBox(
            width: 350,
            child: ListView.separated(
              itemCount: recheios.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      setState(() {
                        recheioSelecionado = recheios[index];
                        print(recheioSelecionado);
                      });
                    },
                    child: CachedNetworkImage(
                      imageUrl: 'https://thespacefox.github.io/SenhorBolo-Imagens/images/recheios/' + recheios[index].toLowerCase() + '.png',
                      imageBuilder: (context, imageProvider) => Container(
                        height: 89,
                        padding: EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
                        ),
                        child: Text(
                          recheios[index],
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    )
                );
              } ,
              separatorBuilder: (context, int index){
                return SizedBox(height: 10);
              },
            ),
          ),
        )
      ],
    );
  }
}

class CakeTopping extends StatefulWidget {
  const CakeTopping({Key? key}) : super(key: key);

  @override
  _CakeToppingState createState() => _CakeToppingState();
}

class _CakeToppingState extends State<CakeTopping> {
  List<String> coberturas = [
    "Chocolate",
    "Doce de leite",
    "Glacê",
    "Goiabada",
    "Limão",
  ];

  String? coberturaSelecionada = "";

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [

        SizedBox(height: 15),
        Text(
          'Selecione o tipo de recheio',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, color: textSecondaryColor),
        ),
        SizedBox(height: 15),

        Center(
          child: SizedBox(
            width: 350,
            child: ListView.separated(
              itemCount: coberturas.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      setState(() {
                        coberturaSelecionada = coberturas[index];
                        print(coberturaSelecionada);
                      });
                    },
                    child: CachedNetworkImage(
                      imageUrl: 'https://thespacefox.github.io/SenhorBolo-Imagens/images/coberturas/' + coberturas[index].toLowerCase() + '.png',
                      imageBuilder: (context, imageProvider) => Container(
                        height: 89,
                        padding: EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
                        ),
                        child: Text(
                          coberturas[index],
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    )
                );
              } ,
              separatorBuilder: (context, int index){
                return SizedBox(height: 10);
              },
            ),
          ),
        )
      ],
    );
  }
}
