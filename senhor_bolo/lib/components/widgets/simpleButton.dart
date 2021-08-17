import 'package:flutter/material.dart';

import '../../constants.dart';

Widget simpleButton (double width, double height, String btnText, VoidCallback onPressed, double Radius, double fontSize, Color cor){
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
        onPressed: onPressed,
        child: Text(btnText),
        style: ElevatedButton.styleFrom(
          primary: cor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultRadius)
          ),
          textStyle: TextStyle(
              fontFamily: 'Raleway',
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold
          ),
        ),
    ),
  );
}

