import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/components/widgets/emailTextField.dart';
import 'package:senhor_bolo/components/widgets/passwordTextField.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 88,
          elevation: 0,
          centerTitle: true,
          title: const Image(
            image: AssetImage('images/logo_login.png'),
            width: 200,
          )
        ),
        body: ListView(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.42,
              decoration: const BoxDecoration(
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
                  const Text(
                    'Bem vindo!',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    'Entre para comprar',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 40,
                ),
                child: FormLogin()
            )
          ],
        )
    );
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

  /// TODO: Mudar para validação com a API
  void validarForm() {
    if (_formKey.currentState!.validate()) {
      if (_txtEmail.text == 'lricardosp@gmail.com' &&
          _txtPassword.text == 'teste123') {
        Navigator.pushReplacementNamed(context, 'homepage');
      } else {
        HapticFeedback.lightImpact();
        _txtEmail.clear();
        _txtPassword.clear();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
                content: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.white,),
                    SizedBox(width: 15),
                    Expanded(child: Text('E-mail ou senha inválidos!'))
                  ],
                )
            )
        );
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
          const SizedBox(height: 15),
          PasswordTextField(passwordController: _txtPassword),
          SizedBox(height: 7),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Esqueci a senha',
              style: TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 15),
          simpleButton(double.infinity, 50, 'Entrar', () => validarForm(),
              defaultButtonRadius, 25, mainColor),
          const SizedBox(height: 15),
          InkWell(
            onTap: () => Navigator.pushReplacementNamed(context, 'signUp'),
            child: const Text(
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
