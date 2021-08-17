import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/produtoVertical.dart';
import '../constants.dart';

class Homepage extends StatelessWidget {
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
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 34),
                child: Text(
                  'Promoções',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Produtos(),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 34),
                child: Text(
                  'Promoções',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Produtos(),
              SizedBox(height: 22),
            ]))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print('Carrinho pressionado!');
        },
        backgroundColor: mainColor,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}

class Produtos extends StatefulWidget {
  const Produtos({Key? key}) : super(key: key);

  @override
  _ProdutosState createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  List<String> _bolosPromocao = [
    'Brigadeiro',
    'Cocada',
    'Crocante',
    'Portuguesa'
  ];
  List<String> _categoriaBolos = [
    'Bolo doce',
    'Bolo doce',
    'Bolo doce',
    'Bolo gourmet'
  ];
  List<String> _precoProduto = [
    '12,00 - 32,00',
    '12,00 - 32,00',
    '12,00 - 32,00',
    '12,00 - 32,00',
  ];
  List<String> _imagensBolo = [
    'images/brigadeiro.png',
    'images/cocada.png',
    'images/crocante.png',
    'images/baba_portuguesa.png'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 227,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 20);
        },
        scrollDirection: Axis.horizontal,
        itemCount: _bolosPromocao.length,
        itemBuilder: (context, index) {
          return ProdutoVertical(
            nomeProduto: _bolosPromocao[index],
            categoriaProduto: _categoriaBolos[index],
            precoProduto: _precoProduto[index],
            imgProduto: _imagensBolo[index],
          );
        },
      ),
    );
  }
}
