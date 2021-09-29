import 'package:flutter/material.dart';
// Mudar o txtImagem para a foto da classe usuário dps

Widget profileIcon(String txtImagem){
  return CircleAvatar(
    radius: 25,
    backgroundImage: AssetImage(txtImagem),
  );
}