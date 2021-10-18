import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/classes/api.dart';
import 'package:senhor_bolo/components/classes/shoppingCart.dart';
import 'package:senhor_bolo/components/searchResult.dart';
import 'package:senhor_bolo/components/widgets/produtoVertical.dart';
import '../constants.dart';
import 'model/cake.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  API api = API();
  Future<List<Cake>>? recommendedCakes1;
  Future<List<Cake>>? recommendedCakes2;
  Future<List<Cake>>? recommendedCakes3;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int cartItens = 0;

  @override
  void initState() {
    super.initState();
    recommendedCakes1 = api.searchCake('Chocolate');
    recommendedCakes2 = api.searchCakeByCategory('Bolo piscina');
    recommendedCakes3 = api.searchCakeByCategory('Bolo recheado');
  }

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
                        onTap: () => Navigator.pushReplacementNamed(
                            context, 'userProfile'),
                        child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: CachedNetworkImage(
                                imageUrl:
                                    'https://thespacefox.github.io/SenhorBolo-Imagens/images/usuario/ricardinho_betoneira.jpeg',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      width: 134,
                                      height: 134,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fitWidth)),
                                    )))),
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
                  texto: 'Cupons', icone: Icons.local_offer, onTap: () {}),
              buildMenuItem(texto: 'Ajuda', icone: Icons.help, onTap: () {}),
              buildMenuItem(
                  texto: 'Sobre nós', icone: Icons.info, onTap: () {}),
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
            leading: IconButton(
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 40,
              ),
            ),
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
                  onTap: () => Navigator.pushNamed(context, 'userProfile'),
                  child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: CachedNetworkImage(
                          imageUrl:
                              'https://thespacefox.github.io/SenhorBolo-Imagens/images/usuario/ricardinho_betoneira.jpeg',
                          imageBuilder: (context, imageProvider) => Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain)),
                              ))))
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
                      onSubmitted: (searchText) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchResult(
                                      searchText: searchText,
                                    )));
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
          const SizedBox(height: 22),
          GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'customCake'),
              child: Center(
                child: Image(
                  image: AssetImage('images/banner_teste.png'),
                ),
              )),
          const SizedBox(height: 15),
          buildHomeSection(recommendedCakes1, 'Bolos de chocolate'),
          const SizedBox(height: 15),
          buildHomeSection(recommendedCakes2, 'Bolos Piscina'),
          const SizedBox(height: 15),
          buildHomeSection(recommendedCakes3, 'Bolo recheado'),
          const SizedBox(height: 30),
          const Text(
            'Você chegou ao fim ^_^',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 20),
        ]))
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: mainColor,
        label: Text(' Carrinho'),
        icon: Badge(
          toAnimate: true,
          animationType: BadgeAnimationType.slide,
          badgeContent: Text(
            ShoppingCart.cartItens.length.toString(),
            style: TextStyle(color: textMainColor, fontFamily: 'Roboto'),
          ),
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

  Widget buildHomeSection(Future<List<Cake>>? cakes, String sectionName){
    print('Seção build');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 34),
          child: Text(
            sectionName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),),
        SizedBox(height: 10),
        FutureBuilder<List<Cake>>(
          future: cakes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                  child: SizedBox(
                    height: 227,
                    child: ListView.separated(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ProdutoVertical(
                          nomeProduto: snapshot.data![index].name,
                          categoriaProduto: snapshot.data![index].category,
                          precoProduto: snapshot.data![index].price,
                          imgProduto: snapshot.data![index].image,
                        );
                      },
                      separatorBuilder: (context, int index) {
                        return SizedBox(width: 20);
                      },
                    ),
                  ));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
