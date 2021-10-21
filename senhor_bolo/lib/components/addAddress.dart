import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _keyCEP = GlobalKey<FormState>();
  var cpfMask = MaskTextInputFormatter(
      mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});

  TextEditingController _txtCEP = TextEditingController();
  TextEditingController _txtNumber = TextEditingController();
  TextEditingController _txtAdicionalInfo = TextEditingController();
  TextEditingController _txtRemark = TextEditingController();

  String street = '';
  String district = '';

  void _showErrorDialog(){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Erro ao buscar o CEP',
              style: TextStyle(fontWeight: FontWeight.bold)),
            content: Text('Entregamos somente na cidade de São Paulo!'),
            actions: [
              TextButton(
                  onPressed: (){
                    _txtCEP.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text('OK')
              )
            ],
          );
        }
    );
  }

  void _getAddress() async {
    if (_keyCEP.currentState!.validate()) {
      String cepAPI = _txtCEP.text.replaceAll(RegExp(r'[^0-9]'), '');
      final response = await http
          .get(Uri.parse('https://viacep.com.br/ws/' + cepAPI + '/json/'));
      Map<String, dynamic> addressData = json.decode(response.body);
      if(addressData['localidade'] != 'São Paulo' || response.body.isEmpty){
        _showErrorDialog();
      } else {
        street = addressData['logradouro'];
        district = addressData['bairro'];
        setState(() {
          cepInserido = !cepInserido;
        });
      }
    }
  }

  void _putAddress(){
    /// TODO: Trocar para a conexão com o BD dps
    print('Rua: $street \nBairro: $district \nCEP: ${_txtCEP.text}'
    '\nNúmero: ${_txtNumber.text} \nComplemento: ${_txtRemark.text} \n'
        'Informações adicionais: ${_txtAdicionalInfo.text}');
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white,),
                SizedBox(width: 15),
                Expanded(child: Text('Endereço adicionado com sucesso!'))
              ],
            )));
    Navigator.of(context).pop();
  }

  bool cepInserido = false;

  @override
  Widget build(BuildContext context) {
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
          title: const Text(
            'Adicionar endereço',
            style: TextStyle(
                color: mainTextColor,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: PageTransitionSwitcher(
          duration: Duration(milliseconds: 800),
          transitionBuilder: (child, animation, secondaryAnimation) =>
              SharedAxisTransition(
                  child: child,
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal
              ),
          child: cepInserido ? completeAddress() : insertCEP(),
        ),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          color: Color(0xffE6E6E6)
        ),
        child: Center(
          child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  cepInserido ? _putAddress() : _getAddress();
                },
                child: Text(cepInserido ? 'Salvar endereço' : 'Continuar'),
                style: ElevatedButton.styleFrom(
                  primary: mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultButtonRadius)),
                  textStyle: const TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ),
    );
  }
  Widget insertCEP(){
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Qual é o seu CEP?',
            style: TextStyle(fontSize: 18, color: textSecondaryColor),
          ),
          const SizedBox(height: 20),
          Form(
            key: _keyCEP,
            child: TextFormField(
                autofocus: true,
                onFieldSubmitted: (value) => _getAddress(),
                controller: _txtCEP,
                keyboardType: TextInputType.number,
                inputFormatters: [cpfMask],
                validator: (cep) {
                  return cep == null || cep.isEmpty ? 'Insira o seu CEP' : null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  labelText: 'CEP',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(defaultButtonRadius),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  labelStyle: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: textSecondaryColor),
                )),
          ),
        ],
      ),
    );
  }

  Widget completeAddress(){
    return  Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Complete o endereço',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 20),
          TextField(
              enabled: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15),
                labelText: street,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultButtonRadius),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                labelStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: textSecondaryColor),
              )
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 214,
                child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 15),
                      labelText: district,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(defaultButtonRadius),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      labelStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: textSecondaryColor),
                    )
                ),
              ),
              SizedBox(
                width: 115,
                child: TextFormField(
                    autofocus: true,
                    controller: _txtNumber,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (houseNumber) {
                      return houseNumber == null || houseNumber.isEmpty ? 'Preencha o numero' : null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 15),
                      labelText: 'Número',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(defaultButtonRadius),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      labelStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: textSecondaryColor),
                    )
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          TextField(
              controller: _txtRemark,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 15),
                labelText: 'Complemento',
                helperText: 'Apto / Bloco / Casa',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultButtonRadius),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                labelStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: textSecondaryColor),
              )
          ),
          const SizedBox(height: 15),
          TextField(
              controller: _txtAdicionalInfo,
              onSubmitted: (value) => _putAddress(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15),
                labelText: 'Informações adicionais',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultButtonRadius),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                labelStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: textSecondaryColor),
              )
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: (){
              setState(() {
                cepInserido = false;
              });
            },
            child: const Text(
              ' Alterar CEP',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffB2B2B2)
              ),
            ),
          )
        ],
      ),
    );
  }
}
