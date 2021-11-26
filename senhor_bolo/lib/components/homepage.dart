import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:senhor_bolo/classes/order.dart';
import 'package:senhor_bolo/classes/shoppingCart.dart';
import 'package:senhor_bolo/classes/user.dart';
import 'package:senhor_bolo/components/widgets/shimmerProdutoVertical.dart';
import 'package:senhor_bolo/model/cake.dart';
import 'package:senhor_bolo/services/cakeService.dart';
import 'package:senhor_bolo/components/searchResult.dart';
import 'package:senhor_bolo/components/widgets/produtoVertical.dart';
import 'package:senhor_bolo/services/creditcardService.dart';
import '../constants.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = User();
    return Scaffold(
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
                                'https://thespacefox.github.io/SenhorBolo-Imagens/images/usuario/${User.image}',
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
                      User.username,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    AutoSizeText(
                      User.email,
                      maxLines: 1,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              BuildMenuItem(
                  texto: 'Minha conta',
                  icone: Icons.account_circle,
                  onTap: () => Navigator.pushNamed(context, 'userProfile')),
              BuildMenuItem(
                  texto: 'Meus pedidos',
                  icone: Icons.cake,
                  onTap: () => Navigator.pushNamed(context, 'orders')),
              BuildMenuItem(
                  texto: 'Cupons',
                  icone: Icons.local_offer,
                  onTap: () => Navigator.pushNamed(context, 'cupons')),
              BuildMenuItem(
                  texto: 'Ajuda',
                  icone: Icons.help,
                  onTap: () => Navigator.pushNamed(context, 'help')),
              BuildMenuItem(
                  texto: 'Sobre nós',
                  icone: Icons.info,
                  onTap: () => Navigator.pushNamed(context, 'aboutUs')),
              Divider(color: Colors.white),
              BuildMenuItem(texto: 'Sair', icone: Icons.logout, onTap: () {
                final storage = FlutterSecureStorage();
                storage.delete(key: 'email');
                storage.delete(key: 'password');
                storage.delete(key: 'key');
                storage.delete(key: 'bdPassword');
                CreditcardService.instance.deleteDB();
                Navigator.pushReplacementNamed(context, 'welcomePage');
              })
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
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  size: 40,
                ),
              ),
            ),
            title: InkWell(
              onTap: () => Navigator.pushNamed(context, 'addressPicker'),
              child: Column(
                children: <Widget>[
                  Text(
                    'Entregar em',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Consumer<Order> (
                      builder: (context, order, child) {
                        late String endereco;
                        if (order.orderAddress == null){
                          endereco = 'Selecione um endereço';
                        } else {
                          endereco = order.orderAddress!.rua + ', '
                              + order.orderAddress!.num;
                        }
                        return Text(
                          endereco,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                              color: Colors.white),
                        );
                      }
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
                          'https://thespacefox.github.io/SenhorBolo-Imagens/images/usuario/${User.image}',
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
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Image(
                        image: AssetImage('images/banner_teste.png'),
                      ),
                    )
                  )),
              const SizedBox(height: 15),
              HomeSection(categoria: 'Bolo Tradicional'),
              const SizedBox(height: 15),
              HomeSection(categoria: 'Bolo recheado'),
              const SizedBox(height: 15),
              HomeSection(categoria: 'Piscina'),
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
        onPressed: () => Navigator.pushNamed(context, 'shoppingCart'),
        backgroundColor: mainColor,
        label: Text(' Carrinho'),
        icon: Badge(
          toAnimate: true,
          animationType: BadgeAnimationType.slide,
          badgeContent: Consumer<ShoppingCart> (
            builder: (context, shoppingCart, child){
              return Text(
                shoppingCart.cartItens.length.toString(),
                style: TextStyle(color: mainTextColor, fontFamily: 'Roboto'),
              );
            },
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
}

class BuildMenuItem extends StatelessWidget {

  final String texto;
  final IconData icone;
  final VoidCallback onTap;

  const BuildMenuItem({Key? key,
    required this.texto,
    required this.icone,
    required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      hoverColor: Color(0xff14A8A2),
      onTap: onTap,
    );
  }
}

class HomeSection extends StatefulWidget {
  final String categoria;

  const HomeSection({Key? key, required this.categoria}) : super(key: key);

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {

  CakeService api = CakeService();
  late Future<List<Cake>> bolos;

  @override
  void initState() {
    super.initState();
    bolos = api.getCakeByCategory(widget.categoria);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 34),
          child: Text(
            widget.categoria,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ),
        SizedBox(height: 10),
        FutureBuilder<List<Cake>>(
          future: bolos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                  child: SizedBox(
                    height: 242,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ProdutoVertical(
                          nomeProduto: snapshot.data![index].name,
                          categoriaProduto: snapshot.data![index].category,
                          precoProduto: snapshot.data![index].price,
                          imgProduto: snapshot.data![index].image,
                          idProduto: snapshot.data![index].id,
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
            return Center(
                child: SizedBox(
                  height: 227,
                  child: ListView.separated(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return shimmerProdutoVertical();
                    },
                    separatorBuilder: (context, int index) {
                      return SizedBox(width: 20);
                    },
                  ),
                )
            );
          },
        ),
      ],
    );
  }
}
