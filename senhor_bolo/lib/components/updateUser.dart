import 'package:flutter/material.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/classes/user.dart';
import 'package:senhor_bolo/components/widgets/maskedTextField.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/components/widgets/textAppBar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:cool_alert/cool_alert.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {

  User usuario = User();

  final _userFormKey = GlobalKey<FormState>();
  final maskCPF = MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  bool _hidePassword = true;

  TextEditingController _txtName = TextEditingController(text: User.username);
  TextEditingController _txtCPF = TextEditingController(text: User.cpf);
  TextEditingController _txtPassword = TextEditingController();

  void _updateUser() async{

    if(_userFormKey.currentState!.validate()){
      bool success = await usuario.updateUser(
          _txtName.text, _txtCPF.text, _txtPassword.text);

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

  void _cleanText(){
    _userFormKey.currentState!.reset();
    _txtName.clear();
    _txtCPF.clear();
    _txtPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: TextAppBar(title: 'Editar conta'),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _userFormKey,
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _txtName,
                  keyboardType: TextInputType.text,
                  validator: (value){
                    return value == null || value.isEmpty
                        ? 'Preencha o campo nome'
                        : null;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 15),
                    labelText: 'Nome',
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

                const SizedBox(height: 15),

                maskedTextField(textFieldName: 'CPF', txtController: _txtCPF,
                    textInputType: TextInputType.number, inputFormatter: maskCPF),

                const SizedBox(height: 15),

                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _txtPassword,
                  obscureText: _hidePassword,
                  validator: (password) {
                    if (password == null){
                      return 'Insira a sua senha';
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 15),
                    labelText: 'Senha',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                      padding: EdgeInsets.zero,
                      icon: _hidePassword
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      color: textSecondaryColor,
                    ),
                    labelStyle: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: textSecondaryColor),
                  ),
                ),

                const SizedBox(height: 6.5),

                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      const Text('Confirme a sua senha'),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.lock,
                        color: textSecondaryColor,
                        size: 15,
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(context, 'updatePassword'),
                  child: const Text(
                    "Alterar senha",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xffB2B2B2),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                )
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
              simpleButton(
                  175, 55, 'Salvar', _updateUser, 25, 20, mainColor),
              simpleButton(
                  175, 55, 'Limpar', _cleanText, 25, 20, redButtonColor),
            ],
          ),
        )
    );
  }
}