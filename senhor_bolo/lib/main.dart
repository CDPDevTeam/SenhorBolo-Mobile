import 'package:flutter/material.dart';
import 'package:senhor_bolo/routes.dart';
import 'package:senhor_bolo/theme/style.dart';

void main(){
  runApp(MaterialApp(
    theme: appTheme(),
    routes: routes,
    initialRoute: 'checkout',
    ),
  );
}