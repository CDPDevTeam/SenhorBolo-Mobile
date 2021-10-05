import 'package:flutter/material.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/components/signUp.dart';
import 'package:senhor_bolo/components/homepage.dart';
import 'package:senhor_bolo/components/widgets/emailTextField.dart';
import 'package:senhor_bolo/components/widgets/passwordTextField.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 88,
          elevation: 0,
          centerTitle: true,
          title: Image.asset('images/logo_login.png'),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.42,
              decoration: BoxDecoration(
                color: mainColor,
                image: DecorationImage(
                    image: AssetImage('images/bolo_login.png'),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Text>[
                  Text(
                    'Bem vindo!',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'Entre para comprar',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 40,
              ),
              child: FormLogin(),
            )
          ]),
        ));
  }
}

class FormLogin extends StatefulWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {

  final _formKey = GlobalKey<FormState>(); // Chave que define o formulário

  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();

  void validarForm() { // Dps mudar para PostgreSQL
    if (_formKey.currentState!.validate()) {
      print('Validado!');
      if (_txtEmail.text == 'lricardosp@gmail.com' &&
          _txtPassword.text == 'edsonlindo') {
        print('Usuário aceito');
        Navigator.pushReplacementNamed(context, 'homepage');
      } else {
        print('Usuário inexistente');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          emailTextField(_txtEmail),
          SizedBox(height: 15),
          PasswordTextField(passwordController: _txtPassword),
          SizedBox(height: 7),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Esqueci a senha',
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          simpleButton(double.infinity, 50, 'Entrar', validarForm,
              defaultRadius, 25, mainColor),
          SizedBox(height: 15),
          InkWell(
            onTap: (){
              Navigator.pushReplacementNamed(context, 'signUp');
            },
            child: Text(
              'Não tenho cadastro',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xffB2B2B2)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
