import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senhor_bolo/components/login.dart';
import 'package:senhor_bolo/components/widgets/emailTextField.dart';
import 'package:senhor_bolo/components/widgets/maskedTextField.dart';
import 'package:senhor_bolo/components/widgets/passwordTextField.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:password_strength/password_strength.dart';
import 'package:senhor_bolo/services/authenticationService.dart';


class CadastroApp extends StatelessWidget {
  const CadastroApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 125,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cadastre-se',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            const Text(
              'na facção Senhor Bolo',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
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

  AuthenticationService authService = AuthenticationService();
  final _keyCadastro = GlobalKey<FormState>();

  TextEditingController _txtName = TextEditingController();
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
          content: Text('Aceita vender seus dados para o PCCh?'),
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

  Future<void> verificarForm() async {
      if (_keyCadastro.currentState!.validate()) {
        if (_termosUso == true) {
          bool success = await authService.signUp(txtEmail.text, _txtName.text, txtCPF.text, txtPassword.text);
          if(success){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()));
          } else {
            HapticFeedback.lightImpact();
            txtEmail.clear();
            _txtName.clear();
            txtCPF.clear();
            txtPassword.clear();
            txtPasswordConfirm.clear();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: Color(0xff88002A),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    content: Row(
                      children: [
                        Icon(Icons.warning, color: Colors.white),
                        SizedBox(width: 15),
                        Expanded(child: Text('E-mail já cadastrado no sistema!'))
                      ],
                    )
                ));
          }
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
        const Text(
          'Preencha os seguintes campos',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500
          ),
        ),
        const SizedBox(height: 15),

        emailTextField(txtEmail),

        const SizedBox(height: 15),

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

        maskedTextField('CPF', txtCPF, maskCPF),

        const SizedBox(height: 15),

        PasswordTextField(passwordController: txtPassword),

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

        const SizedBox(height: 15),

        CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Eu concordo com a venda dos meus dados para o Partido Comunista Chinês',
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

        const SizedBox(height: 22),

        simpleButton(double.infinity, 50, 'Cadastrar', verificarForm, defaultButtonRadius, 25, mainColor),

        const SizedBox(height: 15),

        InkWell(
          onTap: () => Navigator.pushReplacementNamed(context, 'login'),
          child: const Text(
            'Já sou cadastrado',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xffB2B2B2)
            ),
          ),
        ),
      ],
    )
   );
  }
}




