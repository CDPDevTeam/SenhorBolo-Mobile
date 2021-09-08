import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/produtoVertical.dart';
import '../constants.dart';

class Homepage extends StatelessWidget {
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

  static List<double> _precoProdutoChocolate = [
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

  static List<String> _bolosSimples = [
    'Bolo de nada',
    'Laranja',
    'Chocolate',
    'Formigueiro'
  ];

  static List<String> _categoriaBolosSimples = [
    "Bolo simples",
    "Bolo simples",
    "Bolo simples",
    "Bolo simples",
  ];

  static List<double> _precoBoloSimples = [
    12.00,
    12.00,
    12.00,
    12.00,
  ];

  static List<String> _imagensBolosSimples = [
    'bolo_nada.png',
    'laranja.png',
    'chocolate.png',
    'formigueiro.png'
  ];

  static List<String> _bolosNovidade = [
    'Portuguesa',
    'Formigueiro',
    'Mesclado',
    'Cocada'
  ];

  static List<String> _categoriaNovidades = [
    'Bolo gourmet',
    'Bolo doce',
    'Bolo doce',
    'Bolo doce'
  ];

  static List<String> _imagensNovidade = [
    'baba_portuguesa.png',
    'bolo_mesclado.png',
    'cocada.png',
    'formigueiro.png'
  ];

  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
            pinned: true,
            toolbarHeight: 88,
            centerTitle: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            leading: InkWell(
                onTap: () {
                  print('Tocou no menu');
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 40,
                  ),
                )),
            title: GestureDetector(
              onTap: () {
                print('Tocou no endereço');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: <Text>[
                      Text(
                        'Entregar em',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        'Rua Humaitá, 538',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                  onTap: () {
                    print('Tocou na foto');
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 18),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage('images/ricardinho_betoneira.jpeg'),
                    ),
                  ))
            ],
            expandedHeight: 311,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: EdgeInsets.fromLTRB(34, 110, 34, 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'O que gostaria de pedir?',
                      style: TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    TextField(
                      //controller: controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: 'Bolo de miiiiiiiiiiiiiiiiiiiiiiiilhooo',
                          filled: true,
                          fillColor: Color(0xffE6E6E6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB5B5B5)),
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
              ),
            )),
        SliverList(
            delegate: SliverChildListDelegate(<Widget>[
          SizedBox(height: 22),
          Center(
            child: Image(
              image: AssetImage('images/banner_teste.png'),
            ),
          ),
          ListBolos(
              nomeLista: 'Produtos com chocolate',
              nomes: _bolosChocolate,
              categorias: _categoriaBolosChocolate,
              precos: _precoProdutoChocolate,
              imagens: _imagensBoloChocolate),
          ListBolos(
              nomeLista: 'Bolos simples',
              nomes: _bolosSimples,
              categorias: _categoriaBolosSimples,
              precos: _precoBoloSimples,
              imagens: _imagensBolosSimples),
          ListBolos(
              nomeLista: 'Novidades',
              nomes: _bolosNovidade,
              categorias: _categoriaNovidades,
              precos: _precoBoloSimples,
              imagens: _imagensNovidade),
          SizedBox(
            height: 30,
          ),
          Text(
            'Você chegou ao fim ^_^',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 20,
          ),
        ]))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Carrinho pressionado!');
        },
        backgroundColor: mainColor,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}

class ListBolos extends StatelessWidget {
  final String nomeLista;
  final List<String> nomes;
  final List<String> categorias;
  final List<double> precos;
  final List<String> imagens;

  const ListBolos(
      {Key? key,
      required this.nomeLista,
      required this.nomes,
      required this.categorias,
      required this.precos,
      required this.imagens})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.only(left: 34),
          child: Text(
            nomeLista,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 227,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 20);
            },
            scrollDirection: Axis.horizontal,
            itemCount: nomes.length,
            itemBuilder: (context, index) {
              return ProdutoVertical(
                nomeProduto: nomes[index],
                categoriaProduto: categorias[index],
                precoProduto: precos[index],
                imgProduto: imagens[index],
              );
            },
          ),
        )
      ],
    );
  }
}