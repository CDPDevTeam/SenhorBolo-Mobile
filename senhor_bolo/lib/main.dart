import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/boloPersonalizado.dart';
import 'package:senhor_bolo/constants.dart';

import 'components/cardConfirmation.dart';

void main(){
  runApp(MaterialApp(
    title: 'Senhor Bolo',
    theme: ThemeData(
        primaryColor: mainColor,
        fontFamily: 'Raleway',
        scaffoldBackgroundColor: backgroundColor
    ),
    home: CardConfirmation(),
    ),
  );
}