import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senhor_bolo/classes/user.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/components/widgets/emailTextField.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/services/authenticationService.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              toolbarHeight: 88,
              centerTitle: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
                title: const Image(
                  image: AssetImage('images/logo_login.png'),
                  width: 200,
                ),
                expandedHeight: 438,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.bottomCenter,
                    image: AssetImage('images/bolo_login.png',),
                    fit: BoxFit.fitWidth),
              ),
              padding: const EdgeInsets.fromLTRB(34, 110, 34, 32),
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
            )),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 40,
                      ),
                      child: FormLogin()
                  )
                ]
              ),
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

  bool _hidePassword = true;

  AuthenticationService authService = AuthenticationService();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();

  void validarForm() async {
    if (_formKey.currentState!.validate()) {
      bool login = await authService.authLogin(_txtEmail.text, _txtPassword.text);
      if (login) {
        Navigator.pushReplacementNamed(context, 'homepage');
      } else {
        HapticFeedback.lightImpact();
        _txtEmail.clear();
        _txtPassword.clear();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Color(0xff88002A),
                duration: Duration(milliseconds: 1500),
                behavior: SnackBarBehavior.floating,
                content: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.white),
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
          TextFormField(
            controller: _txtPassword,
            obscureText: _hidePassword,
            validator: (password) {
              if (password != null){
                if (password.length < 8){
                  return 'Digite uma senha válida';
                }
              } else {
                return 'Preencha o campo senha';
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
          const SizedBox(height: 7),
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
