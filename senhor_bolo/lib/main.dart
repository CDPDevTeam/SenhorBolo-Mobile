import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/addressPicker.dart';
import 'package:senhor_bolo/components/cadastro.dart';
import 'package:senhor_bolo/components/homepage.dart';
import 'package:senhor_bolo/components/imageViewer.dart';
import 'package:senhor_bolo/components/myOrders.dart';
import 'package:senhor_bolo/components/pedidoEntregue.dart';
import 'package:senhor_bolo/components/ratingScreen.dart';
import 'package:senhor_bolo/components/reportarProblema.dart';
import 'package:senhor_bolo/components/widgets/addressPicker.dart';
import 'package:senhor_bolo/constants.dart';


import 'components/cardConfirmation.dart';

import 'components/paginaTeste.dart';


void main(){
  runApp(MaterialApp(
    title: 'Senhor Bolo',
    theme: ThemeData(
        primaryColor: mainColor,
        fontFamily: 'Raleway',
        scaffoldBackgroundColor: backgroundColor
    ),

    home: AddressPicker()

    ),
  );
}