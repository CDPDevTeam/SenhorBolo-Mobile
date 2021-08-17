import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senhor_bolo/components/homepage.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/constants.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          elevation: 0,
          centerTitle: true,
          title: Image.asset('images/logo_login.png'),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              width: double.infinity,
              height: 344,
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
                vertical: 31,
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
  final _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();

  void validarForm() {
    if (_formKey.currentState!.validate()) {
      print('Validado!');
      if (_txtEmail.text == 'lricardosp@gmail.com' &&
          _txtPassword.text == 'teste') {
        print('Usuário aceito');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Homepage()));
      } else {
        print('Usuário inexistente');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Construído');
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _txtEmail,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              bool emailValid =
                  RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                      .hasMatch(value.toString());
              if (value == '') {
                return 'Preencha o campo e-mail';
              } else if (emailValid != true) {
                return 'Digite um e-mail válido';
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 15),
              labelText: 'E-mail',
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
                  color: textSecondaryColor),
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _txtPassword,
            obscureText: _hidePassword,
            validator: (password) {
              return password == null || password.isEmpty
                  ? 'Preencha o campo Senha'
                  : null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 15),
              labelText: 'Senha',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide(
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
              labelStyle: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: textSecondaryColor),
            ),
          ),
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
        ],
      ),
    );
  }
}
