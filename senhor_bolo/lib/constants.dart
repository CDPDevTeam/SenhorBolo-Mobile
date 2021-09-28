import 'package:flutter/material.dart';

const mainColor = Color(0xff0BBAB3);
const redButtonColor = Color(0xffD90042);
const backgroundColor = Color(0xffF5F5F5);
const textMainColor = Color(0xffFFFFFF);
const textSecondaryColor = Color(0xff707070);
const textMainColorFade = Color(0xB3FFFFFF);
const double defaultRadius = 10;

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