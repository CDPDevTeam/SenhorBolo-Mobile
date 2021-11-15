import 'dart:convert';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:senhor_bolo/model/address.dart';
import 'package:senhor_bolo/services/addressService.dart';
import '../constants.dart';

class UpdateAddress extends StatefulWidget {
  final Address endereco;

  const UpdateAddress({Key? key, required this.endereco}) : super(key: key);

  @override
  _UpdateAddressState createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {

  AddressService updateendereco = AddressService();
  
  final _keyAddress = GlobalKey<FormState>();
  var cpfMask = MaskTextInputFormatter(
      mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});

  late int _txtid;
  TextEditingController _txtCEP = TextEditingController();
  TextEditingController _txtStreet = TextEditingController();
  TextEditingController _txtDistrict = TextEditingController();
  TextEditingController _txtNumber = TextEditingController();
  TextEditingController _txtAdicionalInfo = TextEditingController();
  TextEditingController _txtRemark = TextEditingController();


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
    String cepAPI = _txtCEP.text.replaceAll(RegExp(r'[^0-9]'), '');
    final response = await http
        .get(Uri.parse('https://viacep.com.br/ws/' + cepAPI + '/json/'));
    Map<String, dynamic> addressData = json.decode(response.body);
    if(addressData['localidade'] != 'São Paulo' || response.body.isEmpty){
      _showErrorDialog();
    } else {
      _txtStreet.text = addressData['logradouro'];
      _txtDistrict.text = addressData['bairro'];
    }
  }

  void _updateAddress() async{
    print(_txtid);
      if (_keyAddress.currentState!.validate()){
        bool success = await updateendereco.putAddress(
            _txtid,
            _txtStreet.text,
            _txtDistrict.text,
            _txtCEP.text,
            _txtNumber.text,
            _txtRemark.text,
            _txtAdicionalInfo.text);
        if(success) {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              title: 'Dados atualizados!',
              confirmBtnColor: mainColor,
              onConfirmBtnTap: (){
                Navigator.pop(context);
                Navigator.pop(context);
              }
          );
        } else {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              title: 'Erro ao atualizar os dados',
              text: 'Verique sua senha',
              confirmBtnColor: mainColor,
              onConfirmBtnTap: (){
                Navigator.of(context).pop();
              }
          );
        }
      }

  }

  void _cleanText() {
    _keyAddress.currentState!.reset();
    _txtAdicionalInfo.clear();
    _txtRemark.clear();
    _txtNumber.clear();
    _txtDistrict.clear();
    _txtStreet.clear();
    _txtCEP.clear();
  }

  @override
  void initState() {
    super.initState();
    _txtid = widget.endereco.id;
    _txtCEP.text = widget.endereco.cep;
    _txtStreet.text = widget.endereco.rua;
    _txtDistrict.text = widget.endereco.bairro;
    _txtNumber.text = widget.endereco.num;
    if (widget.endereco.complemento != null){
      _txtRemark.text = widget.endereco.complemento!;
    } else {
      _txtRemark.text = '';
    };
    if (widget.endereco.observacao != null){
      _txtAdicionalInfo.text = widget.endereco.observacao!;
    } else{
      _txtAdicionalInfo.text = '';
    }


  }

  @override
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
          title: const Text(
            'Editar endereço',
            style: TextStyle(
                color: mainTextColor,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _keyAddress,
            child: Column(
              children: [
                TextFormField(
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
                const SizedBox(height: 15),
                TextField(
                    controller: _txtStreet,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 15),
                      labelText: 'Rua',
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
                          controller: _txtDistrict,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 15),
                            labelText: 'Bairro',
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
              ],
            ),
          ),
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
              simpleButton(175, 55, 'Salvar', _updateAddress, 25, 20, mainColor),
              simpleButton(175, 55, 'Limpar', _cleanText, 25, 20, redButtonColor),
            ],
          ),
        )
    );
  }
}
