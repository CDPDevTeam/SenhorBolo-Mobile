import 'package:flutter/material.dart';
import '../constants.dart';

ThemeData appTheme(){
  return ThemeData(
      primaryColor: mainColor,
      fontFamily: 'Raleway',
      scaffoldBackgroundColor: Color(0xffF5F5F5),
      appBarTheme: AppBarTheme(
        backgroundColor: mainColor,
        iconTheme: IconThemeData(
          color: Colors.white
        )
      ),
      pageTransitionsTheme: PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder()
      })
  );
}