import 'package:flutter/material.dart';

const mainColor = Color(0xff0BBAB3);
const redButtonColor = Color(0xffD90042);
const backgroundColor = Color(0xffF5F5F5);
const textMainColor = Color(0xffFFFFFF);
const textSecondaryColor = Color(0xff707070);
const textMainColorFade = Color(0xB3FFFFFF);
const double defaultRadius = 10;
const urlImagem = 'https://realsenhorbolo.000webhostapp.com/images/bolos/';
const urlAPI = 'http://10.0.2.2:3000/';

Widget buildMenuItem({
  required String texto,
  IconData? icone,
}){
  final hoverColor = Color(0xff14A8A2);
  return ListTile(
    leading: Icon(icone, color: Colors.white, size: 30,),
    title: Text(
      texto,
      style: TextStyle(
          fontSize: 22,
          color: Colors.white
      ),
    ),
    hoverColor: hoverColor,
    onTap: (){},
  );
}

// database placeholder variables below
const List enderecos = [
  "R. Tiro ao Pombo",
  "R. Borboletas Psicodélicas",
  "Rua zap"
];
const List cep = [
  "03080000",
  "04050000",
  "00000000"
];
const List cardN = [
  1964,
  4589,
  3390
];
const List issuer = [
  "visa",
  "visa",
  "master"
];