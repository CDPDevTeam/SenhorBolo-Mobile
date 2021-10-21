import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/login.dart';
import 'package:senhor_bolo/components/widgets/emailTextField.dart';
import 'package:senhor_bolo/components/widgets/maskedTextField.dart';
import 'package:senhor_bolo/components/widgets/passwordTextField.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:password_strength/password_strength.dart';


class CadastroApp extends StatelessWidget {
  const CadastroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125),
        child: Container(
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Cadastre-se',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              Text(
                'na facção Senhor Bolo',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white
                ),
              )
            ],
          ),
        )
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 25.0
        ),
        child: FormSignIn(),
      ),
    );
  }
}


class FormSignIn extends StatefulWidget {
  const FormSignIn({Key? key}) : super(key: key);

  @override
  _FormSignInState createState() => _FormSignInState();
}

class _FormSignInState extends State<FormSignIn> {

  final _keyCadastro = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtCPF = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtPasswordConfirm = TextEditingController();

  var maskCPF = MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  bool? _termosUso = false;
  IconData _passwordIcon = Icons.lock;
  String _passwordStrength = 'Digite uma senha forte';

  void verifyPasswordStrength(){
    double strength = estimatePasswordStrength(txtPassword.text);
    setState(() {
      if (strength != 0){
        if (strength < 0.7){
          _passwordStrength = 'Senha parruda';
          _passwordIcon = Icons.done_all;
        } else if (strength < 0.5){
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
    });
  }

  void _confirmarTermosUso() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Não é possível completar o cadastro'),
          content: Text('Aceita vender seus dados para o PCC?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Não')),
            TextButton(onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _termosUso = true;
              });
            }, child: Text('Sim'))
          ],
        );
      },
    );
  }

  void verificarForm() {
      if (_keyCadastro.currentState!.validate()) {
        if (_termosUso == true) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginApp())
          );
        } else {
          _confirmarTermosUso();
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return
      Form(
      key: _keyCadastro,
      child :Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Preencha os seguintes campos',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 18),

        emailTextField(txtEmail),

        SizedBox(height: 18),

        maskedTextField('CPF', txtCPF, maskCPF),

        SizedBox(height: 18),

        PasswordTextField(passwordController: txtPassword),

        SizedBox(height: 6.5),

        Container(
          margin: EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Text(
                  _passwordStrength
              ),
              SizedBox(width: 5),
              Icon(
                _passwordIcon,
                color: textSecondaryColor,
                size: 15,
              )
            ],
          ),
        ),

        SizedBox(height: 22),

        TextFormField(
          controller: txtPasswordConfirm,
          obscureText: true,
          validator: (passwordConfirm){
            if (passwordConfirm == ''){
              return 'Confirme a senha';
            } else if (passwordConfirm != txtPassword.text){
              return 'As senhas não batem, tente novamente';
            }
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15),
            labelText: 'Confirme a senha',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            labelStyle: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: textSecondaryColor
            ),
          ),
        ),

        SizedBox(height: 18),

        CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Eu concordo com a venda dos meus dados para o Partido Comunista Chinês',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 13
              ),
            ),
            value: _termosUso,
            onChanged: (bool? value){
                setState(() {
                  _termosUso = value;
                });
            }
        ),

        SizedBox(height: 22),

        simpleButton(double.infinity, 50, 'Cadastrar', verificarForm, defaultButtonRadius, 25, mainColor),
      ],
    )
   );
  }
}




