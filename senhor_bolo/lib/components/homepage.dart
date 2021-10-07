import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/searchResult.dart';
import 'package:senhor_bolo/components/widgets/produtoVertical.dart';
import '../constants.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
    'Formigueiro',
    'Bolo de nada',
    'Laranja',
    'Chocolate',
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

  static List<String> _bolosNovidade = ['Portuguesa', 'Mesclado', 'Cocada'];

  static List<String> _categoriaNovidades = [
    'Bolo gourmet',
    'Bolo doce',
    'Bolo doce',
  ];

  static List<String> _imagensNovidade = [
    'baba_portuguesa.png',
    'bolo_mesclado.png',
    'cocada.png',
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int cartItens = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Material(
          color: mainColor,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () =>
                            Navigator.pushReplacementNamed(context, 'userProfile'),
                        child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: CachedNetworkImage(
                                imageUrl: 'https://thespacefox.github.io/SenhorBolo-Imagens/images/usuario/ricardinho_betoneira.jpeg',
                                imageBuilder: (context, imageProvider) => Container(
                                  width: 134,
                                  height: 134,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fitWidth)),
                                )
                            )
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Lulz Ricardo',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      'lricardosp@gmail.com',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              buildMenuItem(
                  texto: 'Minha conta',
                  icone: Icons.account_circle,
                  onTap: () => Navigator.pushNamed(context, 'userProfile')),
              buildMenuItem(
                  texto: 'Meus pedidos',
                  icone: Icons.cake,
                  onTap: () => Navigator.pushNamed(context, 'orders')),
              buildMenuItem(
                texto: 'Cupons',
                icone: Icons.local_offer,
                onTap: () {}
              ),
              buildMenuItem(texto: 'Ajuda', icone: Icons.help, onTap: () {}),
              buildMenuItem(texto: 'Sobre nós', icone: Icons.info, onTap: () {}),
              Divider(color: Colors.white),
              buildMenuItem(texto: 'Logout', icone: Icons.logout, onTap: () {})
            ],
          ),
        ),
      ),
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
                onTap: () => _scaffoldKey.currentState!.openDrawer(),
                child: Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 40,
                  ),
                )),
            title: InkWell(
              onTap: () => Navigator.pushNamed(context, 'addressPicker'),
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
              InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, 'userProfile'),
                  child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: CachedNetworkImage(
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
                  )
              )
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
                      textInputAction: TextInputAction.go,
                      onSubmitted: (searchText){
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context) => SearchResult(searchText: searchText,)));
                      },
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
          GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'customCake'),
              child: Center(
                child: Image(
                  image: AssetImage('images/banner_teste.png'),
                ),
              )),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            cartItens++;
          });
        },
        backgroundColor: mainColor,
        label: Text(' Carrinho'),
        icon:  Badge(
          toAnimate: true,
          animationType: BadgeAnimationType.slide,
          badgeContent: Text(cartItens.toString(), style: TextStyle(color: textMainColor, fontFamily: 'Roboto'),),
          child: Icon(
            Icons.shopping_cart,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String texto,
    IconData? icone,
    required final VoidCallback onTap,
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
      onTap: onTap,
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
