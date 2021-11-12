import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:senhor_bolo/components/widgets/cardBackView.dart';
import 'package:senhor_bolo/components/widgets/cardFrontView.dart';
import 'package:senhor_bolo/components/widgets/maskedTextField.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:senhor_bolo/model/creditcard.dart';
import 'package:senhor_bolo/services/creditcardService.dart';

class FormCartao extends StatefulWidget {

  final CreditCard? card;

  const FormCartao({Key? key, this.card}) : super(key: key);

  @override
  _FormCartaoState createState() => _FormCartaoState();
}

class _FormCartaoState extends State<FormCartao>
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

  late String _cardNumber;
  late String _cardName;
  late String _cardExpiration;
  late String _cardCVV;
  late String _cardCarrier;

  void setCardColor(){
    String cardCarrier = getInitials(_cardNumber);
    corTextoCartao = Colors.white;
    if (cardCarrier == '4') {
      _cardCarrier = 'Visa';
      corCartao = Color(0xff0855A3);
      imgCard = 'images/visa.png';

    } else {
      _cardCarrier = 'Mastercard';
      corCartao = Color(0xffFF5100);
      imgCard = 'images/mastercard.png';
    }
  }

  void setCardNumbers() {
    if(widget.card != null){

      // Pega o número do cartão que está como INT e separa novamente
      String cardNum = widget.card!.num.toString();
      cardNum = cardNum.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");

      _cardNumber = cardNum;
      _cardName = widget.card!.name;
      _cardExpiration = widget.card!.expDate;
      _cardCVV = widget.card!.cvv.toString();
      setCardColor();
      _txtNumCard.text = _cardNumber;
      _txtCardName.text = _cardName;
      _txtCVV.text = _cardCVV;
      _txtExpirationDate.text = _cardExpiration;
    } else {
      _cardNumber = '0000 0000 0000 0000';
      _cardName = 'Marcia X';
      _cardExpiration = '00/00';
      _cardCVV = '000';
    }
  }

  bool isCCValid(){
    CreditCardValidator _ccValidator = CreditCardValidator();
    var ccNumResults = _ccValidator.validateCCNum(_cardNumber);
    var expDateResults = _ccValidator.validateExpDate(_cardExpiration);
    var cvvResults = _ccValidator.validateCVV(_cardCVV, ccNumResults.ccType);
    return ccNumResults.isValid && expDateResults.isValid && cvvResults.isValid;
  }

  Future<void> updateCreditCard() async{
    if (isCCValid()){
      print('teste');
      String aux = _txtNumCard.text.replaceAll(' ', '');
      CreditCard newCard = CreditCard(
          num: int.parse(aux),
          name: _txtCardName.text,
          expDate: _txtExpirationDate.text,
          cvv: int.parse(_txtCVV.text),
          carrier: _cardCarrier
      );
      await CreditcardService.instance.update(newCard);
      _confirmation();
    } else {
      _fakeCC();
    }
  }

  Future<void> addCreditCard() async {
    if (_formKey.currentState!.validate()) {
      if(isCCValid()){
        String aux = _txtNumCard.text.replaceAll(' ', '');
        CreditCard newCard = CreditCard(
            num: int.parse(aux),
            name: _txtCardName.text,
            expDate: _txtExpirationDate.text,
            cvv: int.parse(_txtCVV.text),
            carrier: _cardCarrier
        );
        await CreditcardService.instance.create(newCard);
        _confirmation();
      } else {
        _fakeCC();
      }
    }
  }

  void _confirmation() {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      title: 'Cartão cadastrado',
      text: 'Seu cartão foi cadastrado com sucesso!',
      confirmBtnColor: mainColor,
      onConfirmBtnTap: (){
        Navigator.pop(context);
        Navigator.pop(context);
      }
    );
  }

  void _fakeCC() {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      title: 'Erro ao cadastrar',
      text: 'Verifique os dados do cartão',
      confirmBtnColor: mainColor,
      onConfirmBtnTap: (){
        cleanText();
        Navigator.of(context).pop();
      }
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

    setCardNumbers();

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
      if(_txtNumCard.text == ''){
        _cardNumber = '0000 0000 0000 0000';
        corCartao = Color(0xffE6E6E6);
        imgCard = 'images/card.png';
        corTextoCartao = textSecondaryColor;
      } else {
        _cardNumber = _txtNumCard.text;
        corTextoCartao = Colors.white;
        setCardColor();
      }
      setState(() {});
    });

    _txtCardName.addListener(() {
      if(_txtCardName.text == ''){
        _cardName = 'Marcia X';
      } else {
        _cardName = _txtCardName.text;
      }
      setState(() {});
    });

    _txtExpirationDate.addListener(() {
      if(_txtExpirationDate.text == ''){
        _cardExpiration = '00/00';
      } else {
        _cardExpiration = _txtExpirationDate.text;
      }
      setState(() {});
    });

    _txtCVV.addListener(() {
      if(_txtCVV.text == ''){
        _cardExpiration = '000';
      } else {
        _cardCVV = _txtCVV.text;
      }
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 88,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.keyboard_arrow_left,
              size: 50,
            ),
          ),
          title: Text(
            widget.card == null ? 'Adicionar cartão de crédito' : 'Editar cartão de crédito',
            style: const TextStyle(
                color: mainTextColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                            ? cardFrontView(
                            corCartao, size, _cardNumber, corTextoCartao, _cardName,_cardExpiration, imgCard
                        )
                            : CardBackView(
                          corCartao: corCartao, size: size, corTexto: corTextoCartao, cvvText: _cardCVV, img: imgCard,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              maskedTextField(textFieldName: 'Número do cartão', txtController: _txtNumCard, textInputType: TextInputType.number, inputFormatter: maskNumCard),

                              SizedBox(height: 15),

                              maskedTextField(textFieldName: 'Nome do titular', txtController: _txtCardName, textInputType: TextInputType.text, inputFormatter: maskCardName),

                              SizedBox(height: 15),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                  maskedTextField(textFieldName: 'Validade', txtController: _txtExpirationDate, textInputType: TextInputType.number, inputFormatter: maskExpirationDate, textFieldWidth: 180),

                                  SizedBox(
                                    width: 150,
                                    child: TextFormField(
                                      focusNode: _cvvFocus,
                                      controller: _txtCVV,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [maskCVV],
                                      validator: (value){
                                        return value == null || value.isEmpty
                                            ? 'Preencha o campo CVV'
                                            : null;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(left: 15),
                                        labelText: 'CVV',
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(11),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        labelStyle: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: textSecondaryColor
                                        ),
                                      ),
                                    ),
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
        ),

        bottomNavigationBar: Container(
          height: size.height * 0.13,
          decoration: const BoxDecoration(
              color: Color(0xffE6E6E6),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25)
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              simpleButton(175, 55,
                  widget.card == null ? 'Adicionar' : 'Salvar',
                  widget.card == null ? addCreditCard : updateCreditCard,
                  25, 20, mainColor
              ),
              simpleButton(175, 55, 'Limpar', cleanText, 25, 20, redButtonColor),
            ],
          ),
        )
    );
  }
}