import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 88,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: 50,
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: 370,

              /// Mudar dps
              decoration: BoxDecoration(
                  color: Color(0xffE6E6E6),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x33000000),
                      offset: Offset(0, 2.0),
                      blurRadius: 4.0,
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width,
                    height: 220,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CachedNetworkImage(
                                imageUrl: 'https://thespacefox.github.io/SenhorBolo-Imagens/images/usuario/ricardinho_betoneira.jpeg',
                                imageBuilder: (context, imageProvider) => Container(
                                  width: 156,
                                  height: 156,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fitWidth)),
                                )
                            ),
                            Container(
                              decoration: ShapeDecoration(
                                shape: CircleBorder(),
                                color: Colors.white,
                              ),
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    size: 30,
                                    color: mainColor,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Lulz Ricardo',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: textMainColor),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        color: Color(0xff707070),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'thespacefox@protonmail.com',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff707070)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pin,
                        color: Color(0xff707070),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '420.180.868-80',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff707070)),
                      ),
                    ],
                  ),
                  simpleButton(
                      127, 41, 'Editar', () {}, 10, 17, Color(0xff707070)),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Métodos de Pagamento',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: textSecondaryColor),
                  ),
                  Container(
                    height: 80,
                    child: Row(
                      children: [
                        Card(
                          elevation: 2,
                          color: Color(0xff818181),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            splashColor: textMainColorFade,
                            onTap: () => Navigator.pushNamed(context, 'addCreditCard'),
                            child: Container(
                              height: 64,
                              width: 64,
                              child: Icon(
                                Icons.add,
                                color: textMainColor,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Align(
                                    alignment: Alignment.center,
                                    child: cardCard(2103, "visa"),
                                  );
                                }))
                      ],
                    ),
                  ),
                  Text(
                    'Endereços',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: textSecondaryColor),
                  ),
                  Container(
                    height: 80,
                    child: Row(
                      children: [
                        Card(
                          elevation: 2,
                          color: Color(0xff818181),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            splashColor: textMainColorFade,
                            onTap: () {},
                            child: Container(
                              height: 64,
                              width: 64,
                              child: Icon(
                                Icons.add,
                                color: textMainColor,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Align(
                                    alignment: Alignment.center,
                                    child: cardCard(2103, "visa"),
                                  );
                                }))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.13,
        decoration: BoxDecoration(
            color: Color(0xffE6E6E6),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25), topLeft: Radius.circular(25))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            simpleButtonIcon(177, 55, "Suporte", () {}, 25, 20, mainColor,
                Icon(Icons.headset), FontWeight.bold),
            simpleButtonIcon(177, 55, "Deletar", () {}, 25, 20, redButtonColor,
                Icon(Icons.delete), FontWeight.bold),
          ],
        ),
      ),
    );
  }
}

Widget cardCard(int digit, String issuer) {
  return Card(
      elevation: 1,
      color: Color(0xffE6E6E6),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          splashColor: textMainColorFade,
          onTap: () {},
          child: SizedBox(
              height: 64,
              width: 123,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (issuer == 'visa') ...[
                    FaIcon(
                      FontAwesomeIcons.ccVisa,
                      color: Color(0xff0855A3),
                      size: 35,
                    ),
                    Text("$digit",
                        style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'))
                  ],
                  if (issuer == 'master') ...[
                    FaIcon(
                      FontAwesomeIcons.ccMastercard,
                      color: Color(0xff0855A3),
                      size: 35,
                    ),
                    Text("$digit",
                        style: TextStyle(fontSize: 18, fontFamily: 'Roboto'))
                  ]
                ],
            ))));
}
