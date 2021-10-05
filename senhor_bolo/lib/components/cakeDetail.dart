import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/produtoHorizontal.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/components/widgets/testAppBar.dart';
import 'package:senhor_bolo/constants.dart';

class CakeDetail extends StatefulWidget {

  final String nomeProduto;
  final String categoriaProduto;
  final String imgProduto;

  const CakeDetail({Key? key, required this.nomeProduto,
    required this.categoriaProduto, required this.imgProduto}) : super(key: key);

  @override
  _CakeDetailState createState() => _CakeDetailState();
}

class _CakeDetailState extends State<CakeDetail> {

  List<String> _tamanhos = ['250g', '500g', '1Kg'];
  int _defaultChoice = 0;
  String _precoItem = '12';
  int qtdeItem = 1;

  void adicionarCarrinho() {
    // Parte do SQL?
    print('Preço do item: $_precoItem');
    print('Qtde do item: $qtdeItem');
    print('Adicionado ao carrinho!');
  }

  static List<String> _bolosChocolate = [
    'Brigadeiro',
    'Raimunda',
    'Francesa',
    'Crocante'
  ];

  static List<String> _categoriaBolosChocolate = [
    'Bolo doce',
    'Bolo doce',
    'Torta doce',
    'Bolo doce'
  ];

  static List<double> _precoBoloChocolate = [
    12.00,
    12.00,
    24.00,
    12.00,
  ];

  static List<String> _imagensBoloChocolate = [
    'brigadeiro.png',
    'raimunda.png',
    'francesa_chocolate.png',
    'crocante.png'
  ];

  @override
  Widget build(BuildContext context) {
    print('Produto feito');
    return Scaffold(
        appBar: const TestAppBar(),
        body: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
              Stack(
                children: [
                  Container(
                    // Caixa do produto
                    height: 514,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: widget.nomeProduto,
                           child: CachedNetworkImage(
                               imageUrl: 'https://thespacefox.github.io/SenhorBolo-Imagens/images/' + widget.imgProduto,
                               imageBuilder: (context, imageProvider) => Container(
                                   height: 291,
                                   decoration: BoxDecoration(
                                       color: Color(0xff64CBC7),
                                       borderRadius: BorderRadius.circular(25),
                                       image: DecorationImage(
                                           image: imageProvider,
                                           fit: BoxFit.contain))
                               )
                           )
                        ),
                        Container(
                          // Informações do produto
                          width: 237,
                          height: 180,
                          margin: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.nomeProduto,
                                style: TextStyle(
                                    fontSize: 36, fontWeight: FontWeight.w900),
                              ),
                              Text(
                                widget.categoriaProduto,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: textSecondaryColor),
                              ),
                              tamanhosBolo(),
                              Text(
                                'Descrição do bolo, olha que bolo bonito esse, não quer comprar?',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: textSecondaryColor,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Tabela nutricional >',
                                style:
                                    TextStyle(fontSize: 15, color: mainColor),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 108,
                    right: 0,
                    child: Container(
                        width: 108,
                        height: 81,
                        decoration: BoxDecoration(
                            color: Color(0xff00A59F),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(25))),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'R\$',
                                      style: TextStyle(fontSize: 25)),
                                  TextSpan(
                                      text: _precoItem,
                                      style: TextStyle(fontSize: 35)),
                                ]),
                          ),
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),

              Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text(
                  'Outros produtos',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

            Center(
              child: SizedBox(
                width: 328,
                child: ListView.separated(
                  itemCount: _bolosChocolate.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ProdutoHorizontal(
                        nomeProduto: _bolosChocolate[index],
                        categoriaProduto: _categoriaBolosChocolate[index],
                        precoProduto: _precoBoloChocolate[index],
                        imgProduto: _imagensBoloChocolate[index]
                    );
                  } ,
                  separatorBuilder: (context, int index){
                    return SizedBox(height: 20);
                  },
                ),
              ),
            )

            ],
        ),

        bottomNavigationBar: Container(
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (qtdeItem > 1) {
                    setState(() {
                      qtdeItem--;
                    });
                  }
                },
                child: Icon(
                  Icons.remove,
                  size: 30,
                  color: Colors.black,
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffF5F5F5),
                    shape: CircleBorder(),
                    minimumSize: Size(48.0, 48.0)),
              ),
              Text(
                '$qtdeItem',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    qtdeItem++;
                  });
                },
                onLongPress: (){
                  setState(() {
                    qtdeItem++;
                  });
                },
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.black,
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xffF5F5F5),
                    shape: CircleBorder(),
                    minimumSize: Size(48.0, 48.0)),
              ),
              simpleButton(199, 39, 'Adicionar ao carrinho', adicionarCarrinho,
                  10, 16, mainColor)
            ],
          ),
        ));
  }

  Widget tamanhosBolo() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index){
          return SizedBox(width: 10);
        },
        scrollDirection: Axis.horizontal,
        itemCount: _tamanhos.length,
        itemBuilder: (BuildContext context, int index) {
          return ChoiceChip(
            onSelected: (bool selected) {
              setState(() {
                _defaultChoice = selected ? index : 0;
                if (_defaultChoice == 0){
                  _precoItem = '12';
                } else if (_defaultChoice == 1){
                  _precoItem = '24';
                } else {
                  _precoItem = '30';
                }
              });
            },
            selected: _defaultChoice == index,
            selectedColor: Color(0xffBABABA),
            padding: const EdgeInsets.symmetric(
                horizontal: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
            label: Text(_tamanhos[index]),
            labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                color: Colors.black),
          );
        },
      ),
    );
  }

}

