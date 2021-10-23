import 'package:flutter/material.dart';
import 'package:senhor_bolo/constants.dart';

// Caixa de texto do e-mail, para o Login e Cadastro

Widget emailTextField(TextEditingController emailController){
  return TextFormField(
    textInputAction: TextInputAction.next,
    controller: emailController,
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
      contentPadding: const EdgeInsets.only(left: 15),
      labelText: 'E-mail',
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
  );
}