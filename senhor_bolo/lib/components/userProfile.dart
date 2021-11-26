import 'dart:async';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:senhor_bolo/components/creditcard.dart';
import 'package:senhor_bolo/components/updateAddress.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/classes/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senhor_bolo/model/address.dart';
import 'package:senhor_bolo/model/creditcard.dart';
import 'package:senhor_bolo/services/addressService.dart';
import 'package:senhor_bolo/services/creditcardService.dart';
import 'package:url_launcher/url_launcher.dart';


class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  final _ccStreamController = StreamController<List<CreditCard>>();
  final _addressStreamController = StreamController<List<Address>>();

  void _openSupport() async{
    final email = 'realsenhorbolo@gmail.com';
    final subject = Uri.encodeFull('Preciso de ajuda!');
    final message = Uri.encodeFull('Me ajuda por favor eu to tendo um derramjhlkrhkehhseuirykajvbffsbjs');
    final url = 'mailto:$email?subject=$subject&body=$message';
    if(await canLaunch(url)) {
      await launch(url);
    }
  }

  void _updateUser(){
    Navigator.pushNamed(context, 'updateUser');
  }

  void _deleteUserInfo() async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    final storage = FlutterSecureStorage();
    storage.delete(key: 'email');
    storage.delete(key: 'password');
    storage.delete(key: 'key');
    storage.delete(key: 'bdPassword');
    await CreditcardService.instance.deleteDB();
    Navigator.pushReplacementNamed(context, 'welcomePage');
  }

  void _deleteAccount(){
    CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        title: 'Deseja sair ?',
        cancelBtnText: 'Cancelar',
        confirmBtnColor: mainColor,
        onConfirmBtnTap: () => _deleteUserInfo()
    );
  }

  void _editCard(CreditCard card){
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => FormCartao(
        card: card)));
  }

  void _editAddress(Address address){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => UpdateAddress(endereco: address)));
  }
  
  void _deleteCard(CreditCard card) async{
    CoolAlert.show(
        context: context, 
        type: CoolAlertType.confirm,
        title: 'Deseja apagar esse cartão?',
        cancelBtnText: 'Cancelar',
        confirmBtnText: 'Deletar',
        confirmBtnColor: redButtonColor,
        onConfirmBtnTap: () async {
          await CreditcardService.instance.delete(card);
          Navigator.pop(context);
        }
    );
  }

  void _deleteAddress(int id) async {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        title: 'Deletar esse endereço?',
        cancelBtnText: 'Cancelar',
        confirmBtnText: 'Deletar',
        confirmBtnColor: redButtonColor,
        onConfirmBtnTap: () async {
          await AddressService().deleteAddress(id);
          Navigator.pop(context);
        }
    );
  }

  _loadCreditCards() async {
    List<CreditCard> creditcards = await CreditcardService.instance.selectAll();
    _ccStreamController.add(creditcards);
  }

  _loadAdresses() async {
    List<Address> adresses = await AddressService().getAll();
    _addressStreamController.add(adresses);
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 500), (_) => _loadCreditCards());
    Timer.periodic(Duration(milliseconds: 900), (_) => _loadAdresses());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 88,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
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
                                imageUrl: 'https://thespacefox.github.io/SenhorBolo-Imagens/images/usuario/${User.image}',
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
                                  onPressed: () {
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.warning,
                                      title: 'Não é possível mudar sua foto, ainda!',
                                    );
                                  },
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
                          User.username,
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
                        User.email,
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
                        User.cpf,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 15, color: Color(0xff707070)),
                      ),
                    ],
                  ),
                  simpleButton(
                      127, 41, 'Editar', _updateUser, 10, 17, Color(0xff707070)),
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
                        StreamBuilder<List<CreditCard>>(
                          stream: _ccStreamController.stream,
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              if(snapshot.data!.length != 0){
                                return Expanded(
                                    child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {

                                          CreditCard card = snapshot.data![index];
                                          String cardNumber = card.num.toString();

                                          return CCCard(
                                              digit: cardNumber.substring(12, 16),
                                              issuer: card.carrier,
                                              onTap: () => _editCard(card),
                                              onLongPress: () => _deleteCard(card)
                                          );
                                        })
                                );
                              } else {
                                return Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Sem cartões adicionados',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const Text(
                                        'Adicione um cartão no botão ao lado',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: textSecondaryColor
                                        ),
                                      )
                                    ],
                                  )
                                );
                              }
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return Expanded(
                              child: Center(
                                child: CircularProgressIndicator()
                              ),
                            );
                          },
                        )
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
                    StreamBuilder<List<Address>>(
                        stream: _addressStreamController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if(snapshot.data!.isEmpty){
                              return Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Sem endereços adicionados',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const Text(
                                        'Adicione um endereço no botão ao lado',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: textSecondaryColor
                                        ),
                                      )
                                    ],
                                  )
                              );
                            } else {
                              return Expanded(
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return AddressCard(
                                            endereco: snapshot.data![index].rua,
                                            cep: snapshot.data![index].cep,
                                            onTap: () => _editAddress(snapshot.data![index]),
                                            onLongPress: () => _deleteAddress(snapshot.data![index].id)
                                        );
                                      }));
                            }
                          } else if (snapshot.hasError){
                            return Text('${snapshot.error}', style: TextStyle(fontSize: 5),);
                          }
                          return Expanded(
                            child: Center(child: CircularProgressIndicator()),
                          );
                        })
                  ],
                )
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
            simpleButtonIcon(177, 55, "Suporte", _openSupport, 25, 20, mainColor,
                Icon(Icons.headset), FontWeight.bold),
            simpleButtonIcon(177, 55, "Sair", _deleteAccount, 25, 20, redButtonColor,
                Icon(Icons.logout), FontWeight.bold),
          ],
        ),
      ),
    );
  }
}


class CCCard extends StatelessWidget {

  final String digit;
  final String issuer;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const CCCard({Key? key,
    required this.digit,
    required this.issuer,
    required this.onTap,
    required this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xffE6E6E6),
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            splashColor: cardTextColor,
            onTap: onTap,
            onLongPress: onLongPress,
            child: SizedBox(
                height: 54,
                width: 123,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FaIcon(
                      issuer == 'Visa' ? FontAwesomeIcons.ccVisa : FontAwesomeIcons.ccMastercard,
                      color: issuer == 'Visa' ? Color(0xff0855A3) : Color(0xffFF5F00),
                      size: 35,
                    ),
                    Text(
                        digit,
                        style: TextStyle(fontSize: 18, fontFamily: 'Montserrat')
                    ),
                  ],
                )
            )
        )
    );
  }
}

class AddressCard extends StatelessWidget {
  final String endereco;
  final String cep;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const AddressCard({Key? key,
    required this.endereco,
    required this.cep,
    required this.onTap,
    required this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      color: cardTextColor,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        onTap: onTap,
        onLongPress: onLongPress,
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
                        endereco,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        cep,
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
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
}