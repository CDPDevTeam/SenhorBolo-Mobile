import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senhor_bolo/components/TesteBolos.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/main.dart';

class Pesquisa extends StatefulWidget {
  const Pesquisa({Key? key}) : super(key: key);

  @override
  _PesquisaState createState() => _PesquisaState();
}

class _PesquisaState extends State<Pesquisa> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
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
                    CircleAvatar(
                      radius: 67,
                      backgroundImage: AssetImage('images/ricardinho_betoneira.jpeg'),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Lulz Ricardo',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Text(
                      'lricardosp@gmail.com',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              buildMenuItem(texto: 'Minha conta', icone: Icons.account_circle),
              buildMenuItem(texto: 'Meus pedidos', icone: Icons.cake),
              buildMenuItem(texto: 'Cupons', icone: Icons.local_offer),
              buildMenuItem(texto: 'Ajuda', icone: Icons.help),
              buildMenuItem(texto: 'Sobre nós', icone: Icons.info),
              Divider(color: Colors.white),
              buildMenuItem(texto: 'Logout', icone: Icons.logout)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: mainColor,
        child: Icon(Icons.shopping_cart),
      ),
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
                        bottomLeft: Radius.circular(25),
                      )
                  ),
                  padding: EdgeInsets.only(left: 20 ,right: 20, bottom: 20),
                  child: SafeArea(
                    top: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Builder(builder: (context){
                              return IconButton(
                                  onPressed: () {Scaffold.of(context).openDrawer();},
                                  iconSize: 40,
                                  color: Colors.white,
                                  icon: Icon(Icons.menu));
                            }),


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
                )])
      ),

    );
  }
}
Widget SearchResult (context, String nome, double preco, bool estoque, String imagem, String descricao){
  return Card(
    child: InkWell(
      child: SizedBox(
        width:MediaQuery.of(context).size.width ,
        height: 118,
        child: Row(
          children: [
            Container(
              height: 94, width: 120,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(imagem),fit: BoxFit.contain),
              ),
            ),
            Expanded(
                child: Column(
                  children: [
                    Text(nome, style: TextStyle(),),
                    Text(descricao,style: TextStyle(),)
                  ],
                )
                    
            ),
            Flexible(
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (estoque == true) ...[
                          Text("Em estoque"),
                          Icon(Icons.done, color: Colors.green,),
                        ] else ... [
                          Text("Esgotado"),
                          Icon(Icons.block, color: redButtonColor,),
                        ]
                      ],
                    ),
                    Text("R\$$preco", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),)
                  ],
                )
            )
          ],
        ),
      ),
    ),
  );
}