import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senhor_bolo/constants.dart';
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
          leading: IconButton(
            onPressed: () {Navigator.pop(context);},
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: 50,
            )
          )
      ),
      body: ListView(
          children: [
            Container(
              width: size.width,
              height: 370,
              decoration: const BoxDecoration(
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
                    decoration: const BoxDecoration(
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
                                  decoration:  BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fitWidth)),
                                )
                            ),
                            Container(
                              decoration: const ShapeDecoration(
                                shape: CircleBorder(),
                                color: Colors.white,
                              ),
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 30,
                                    color: mainColor,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Lulz Ricardo',
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: mainTextColor),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.email,
                        color: Color(0xff707070),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'thespacefox@protonmail.com',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 15, color: Color(0xff707070)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.pin,
                        color: Color(0xff707070),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '420.180.868-80',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 15, color: Color(0xff707070)),
                      ),
                    ],
                  ),
                  simpleButton(
                      127, 41, 'Editar', () {}, 10, 17, Color(0xff707070)),
                  const SizedBox(height: 10)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
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
                          color: Color(0xff818181),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: InkWell(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            splashColor: cardTextColor,
                            onTap: () => Navigator.pushNamed(context, 'addCreditCard'),
                            child: Container(
                              height: 64,
                              width: 64,
                              child: const Icon(
                                Icons.add,
                                color: mainTextColor,
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
                                  return cardCard(2103, "visa");
                                }))
                      ],
                    ),
                  ),
                  const Text(
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
                          color: Color(0xff818181),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            splashColor: cardTextColor,
                            onTap: () => Navigator.pushNamed(context, 'addAddress'),
                            child: Container(
                              height: 64,
                              width: 64,
                              child: const Icon(
                                Icons.add,
                                color: mainTextColor,
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
                                  return enderecoBlock('Rua valê do Cariri', '02317-060');
                                }))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.13,
        decoration: const BoxDecoration(
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
      color: Color(0xffE6E6E6),
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          splashColor: cardTextColor,
          onTap: () {},
          child: SizedBox(
              height: 54,
              width: 123,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FaIcon(
                    issuer == 'visa' ? FontAwesomeIcons.ccVisa : FontAwesomeIcons.ccMastercard,
                    color: issuer == 'visa' ? Color(0xff0855A3) : Color(0xffFF5F00),
                    size: 35,
                  ),
                  Text(
                      "$digit",
                      style: TextStyle(fontSize: 18, fontFamily: 'Montserrat')
                  ),
                ],
            )
          )
      )
  );
}

Widget enderecoBlock(String endereco, String cep) {
  return Card(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    color: cardTextColor,
    child: InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onTap: () {},
      child: Container(
        width: 148,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.home,
              size: 40,
              color: Colors.black54,
            ),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$endereco",
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$cep",
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    ),
  );
}
