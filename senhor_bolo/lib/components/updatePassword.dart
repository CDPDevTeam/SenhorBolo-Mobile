import 'package:flutter/material.dart';
import 'package:password_strength/password_strength.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/classes/user.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/components/widgets/textAppBar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:cool_alert/cool_alert.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {

  User usuario = User();

  final _userFormKey = GlobalKey<FormState>();
  final maskCPF = MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  bool _hidePassword = true;

  TextEditingController _txtPassword = TextEditingController();
  TextEditingController _txtNewPassword = TextEditingController();
  TextEditingController _txtPasswordConfirmation = TextEditingController();

  IconData _passwordIcon = Icons.lock;
  String _passwordStrength = 'Digite uma senha forte';

  void verifyPasswordStrength(String password){
    if (password.isNotEmpty){
      double strength = estimatePasswordStrength(password);
      if (strength > 0.7){
        _passwordStrength = 'Senha parruda';
        _passwordIcon = Icons.done_all;
      } else if (strength > 0.5){
        _passwordStrength = 'Senha ok';
        _passwordIcon = Icons.check;
      } else {
        _passwordStrength = 'Senha fraca';
        _passwordIcon = Icons.thumb_down;
      }
    } else {
      _passwordIcon = Icons.lock;
      _passwordStrength = 'Digite uma senha forte';
    }
    setState(() {});
  }

  void _updateUser() async{

    if(_userFormKey.currentState!.validate()){

      bool success = await usuario.updatePassword(_txtPassword.text, _txtNewPassword.text);

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
    _txtPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: TextAppBar(title: 'Alterar senha'),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _userFormKey,
            child: Column(
              children: [

                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _txtPassword,
                  obscureText: false,
                  validator: (password) {
                    if (password == null){
                      return 'Insira a sua senha atual';
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 15),
                    labelText: 'Insira sua senha atual',
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
                        color: textSecondaryColor),
                  ),
                ),

                const SizedBox(height: 10),

                TextFormField(
                  textInputAction: TextInputAction.next,
                  onChanged: (password){
                    verifyPasswordStrength(password);
                  },
                  controller: _txtNewPassword,
                  obscureText: _hidePassword,
                  validator: (password) {
                    if (password != null){
                      if (password.length < 8){
                        return 'A senha precisa ter mais de 8 caracteres';
                      }
                    } else {
                      return 'Preencha o campo senha';
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 15),
                    labelText: 'Nova senha',
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
                      Text(_passwordStrength),
                      const SizedBox(width: 5),
                      Icon(
                        _passwordIcon,
                        color: textSecondaryColor,
                        size: 15,
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: _txtPasswordConfirmation,
                  obscureText: true,
                  validator: (passwordConfirm){
                    if (passwordConfirm == ''){
                      return 'Confirme a senha';
                    } else if (passwordConfirm != _txtNewPassword.text){
                      return 'As senhas não batem, tente novamente';
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 15),
                    labelText: 'Confirme a senha',
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