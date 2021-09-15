import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:senhor_bolo/components/homepage.dart';
import 'package:senhor_bolo/components/widgets/cardBackView.dart';
import 'package:senhor_bolo/components/widgets/cardFrontView.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:credit_card_validator/credit_card_validator.dart';

import 'widgets/maskedTextBox.dart';


class FormCartaoTeste extends StatefulWidget {
  const FormCartaoTeste({Key? key}) : super(key: key);

  @override
  _FormCartaoTesteState createState() => _FormCartaoTesteState();
}

class _FormCartaoTesteState extends State<FormCartaoTeste>
    with SingleTickerProviderStateMixin{

  final _formKey = GlobalKey<FormState>();
  Color corCartao = Color(0xffE6E6E6);
  String imgCard = 'images/card.png';
  Color corTextoCartao = textSecondaryColor;

  TextEditingController _txtNumCard = TextEditingController();
  TextEditingController _txtCardName = TextEditingController();
  TextEditingController _txtExpirationDate = TextEditingController();
  TextEditingController _txtCVV = TextEditingController();

  FocusNode _cvvFocus = FocusNode();

  late AnimationController _flipAnimationController;
  late Animation <double> _flipAnimation;

  var maskNumCard = MaskTextInputFormatter(mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')});
  var maskCardName = FilteringTextInputFormatter.allow(RegExp('[a-z ' ' A-Z]'));
  var maskExpirationDate = MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')});
  var maskCVV = MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});

  String _cardNumber = '0000 0000 0000 0000';
  String _cardName = 'Marcia X';
  String _cardExpiration = '00/00';
  String _cardCVV = '000';

  void addCreditCard() {
    if (_formKey.currentState!.validate()) {
      CreditCardValidator _ccValidator = CreditCardValidator();
      var ccNumResults = _ccValidator.validateCCNum(_cardNumber);
      var expDateResults = _ccValidator.validateExpDate(_cardExpiration);
      var cvvResults = _ccValidator.validateCVV(_cardCVV, ccNumResults.ccType);
      if(ccNumResults.isValid && expDateResults.isValid && cvvResults.isValid){
        _confirmation();
      } else {
        _fakeCC();
      }
    }
  }

  void _confirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cartão clonado com sucesso!'),
          content: Text('O comando vermelho agradece.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok')),
          ],
        );
      },
    );
  }

  void _fakeCC() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Essa porra ai é falsa!'),
          content: Text('Tente novamente'),
          actions: [
            TextButton(
                onPressed: () {
                  cleanText();
                  Navigator.of(context).pop();
                },
                child: Text('Ok')),
          ],
        );
      },
    );
  }

  void cleanText(){
    _txtCardName.clear();
    _txtNumCard.clear();
    _txtExpirationDate.clear();
    _txtCVV.clear();
    setState(() {
      _cardNumber = '0000 0000 0000 0000';
      _cardName = 'Marcia X';
      _cardExpiration = '00/00';
      _cardCVV = '000';
    });
  }
  
  String getInitials(String cardNumber) => cardNumber.isNotEmpty
      ? cardNumber.trim().split(' ').map((l) => l[0]).take(1).join()
      : '';

  @override
  void initState(){
    super.initState();

    _flipAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    _flipAnimation =
    Tween<double>(begin: 0, end: 1).animate(_flipAnimationController)
      ..addListener(() {
        setState(() {});
      });

    _cvvFocus.addListener(() {
      _cvvFocus.hasFocus
          ? _flipAnimationController.forward()
          : _flipAnimationController.reverse();
    });

    _txtNumCard.addListener(() {
      _cardNumber = _txtNumCard.text;
      if(getInitials(_cardNumber).isNotEmpty) {
        String cardCarrier = getInitials(_cardNumber);
        corTextoCartao = Colors.white;
        if (cardCarrier == '4') {
          corCartao = Color(0xff0855A3);
          imgCard = 'images/visa.png';
        } else {
          corCartao = Color(0xffFF5100);
          imgCard = 'images/mastercard.png';
        }
      } else {
        corCartao = Color(0xffE6E6E6);
        imgCard = 'images/card.png';
        corTextoCartao = textSecondaryColor;
      }
      setState(() {
      });
    });

    _txtCardName.addListener(() {
      _cardName = _txtCardName.text;
      setState(() {
      });
    });

    _txtExpirationDate.addListener(() {
      _cardExpiration = _txtExpirationDate.text;
      setState(() {
      });
    });

    _txtCVV.addListener(() {
      _cardCVV = _txtCVV.text;
      setState(() {
      });
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            onTap:  () => Navigator.of(context).pop(),
            child: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: 50,
            ),
          ),
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FormCartaoTeste()));
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
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cadastrar cartão',
                    style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          )),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(math.pi * _flipAnimation.value),
                        origin: Offset(MediaQuery.of(context).size.width / 2, 0),
                        child: _flipAnimation.value < 0.5
                            ? CardFrontView(
                            corCartao, size, _cardNumber, corTextoCartao, _cardName,_cardExpiration, imgCard
                        )
                            : CardBackView(
                          corCartao: corCartao, size: size, corTexto: corTextoCartao, cvvText: _cardCVV, img: imgCard,
                        ),
                      ),


                      SizedBox(height: 20),

                      Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              maskedTextBox(txtLabel: 'Número do cartão', txtController: _txtNumCard, inputType: TextInputType.number, mask: maskNumCard),

                              SizedBox(height: 15),

                              maskedTextBox(txtLabel: 'Nome do titular', txtController: _txtCardName, inputType: TextInputType.text, mask: maskCardName),

                              SizedBox(height: 15),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  maskedTextBox(txtLabel: 'Data de vencimento', txtController: _txtExpirationDate, inputType: TextInputType.number, mask: maskExpirationDate, widthButton: 180),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'CVV',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: textSecondaryColor
                                        ),
                                      ),

                                      SizedBox(height: 4),

                                      SizedBox(
                                          width: 150,
                                          child: TextFormField(
                                            focusNode: _cvvFocus,
                                            textInputAction: TextInputAction.next,
                                            controller: _txtCVV,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [maskCVV],
                                            validator: (String? cvv){

                                            },
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(left: 15),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(11),
                                                borderSide: BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  )
                                ],
                              )
                            ],
                          ))
                    ],
                  )
              )
            ],
          ),
          )]),

        bottomNavigationBar: Container(
          height: size.height * 0.13,
          decoration: BoxDecoration(
              color: Color(0xffE6E6E6),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25)
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              simpleButton(175, 55, 'Adicionar', addCreditCard, 25, 20, mainColor),
              simpleButton(175, 55, 'Limpar', cleanText, 25, 20, redButtonColor),
            ],
          ),
        )
    );
  }
  Widget buildMenuItem({
    required String texto,
    IconData? icone,
  }){
    final hoverColor = Color(0xff14A8A2);
    return ListTile(
      leading: Icon(icone, color: Colors.white, size: 30,),
      title: Text(
        texto,
        style: TextStyle(
            fontSize: 22,
            color: Colors.white
        ),
      ),
      hoverColor: hoverColor,
      onTap: (){},
    );
  }
}