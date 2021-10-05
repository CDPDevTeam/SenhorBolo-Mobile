import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/addressPicker.dart';
import 'package:senhor_bolo/components/customCake.dart';
import 'package:senhor_bolo/components/signUp.dart';
import 'package:senhor_bolo/components/creditcard.dart';
import 'package:senhor_bolo/components/homepage.dart';
import 'package:senhor_bolo/components/login.dart';
import 'package:senhor_bolo/components/myOrders.dart';
import 'package:senhor_bolo/components/orderConfirmation.dart';
import 'package:senhor_bolo/components/searchPage.dart';
import 'package:senhor_bolo/components/userProfile.dart';
import 'package:senhor_bolo/components/ratingScreen.dart';
import 'package:senhor_bolo/components/deliveryProblem.dart';
import 'package:senhor_bolo/components/welcomePage.dart';
import 'package:senhor_bolo/constants.dart';
import 'components/tracking.dart';

void main(){
  runApp(MaterialApp(
    title: 'Senhor Bolo',
    theme: ThemeData(
        primaryColor: mainColor,
        fontFamily: 'Raleway',
        scaffoldBackgroundColor: backgroundColor,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder()
          //TargetPlatform.android: CupertinoPageTransitionsBuilder()
        })
    ),
    routes: {
      'login' : (context) => LoginApp(),
      'signUp': (context) => CadastroApp(),
      'homepage' : (context) => Homepage(),
      'addressPicker' : (context) => AddressPicker(),
      'userProfile' : (context) => UserProfile(),
      'addCreditCard' : (context) => FormCartao(),
      'orders' : (context) => MeusPedidos(),
      'customCake' : (context) => CustomCake(),
      'orderRating' : (context) => RatingScreen(),
      'orderFeedback' : (context) => DeliveryProblem(),
      'tracking' : (context) => Tracking(),
      'searchPage' : (context) => SearchPage(),
      'cardError' : (context) => CardDenied(),
      'orderConfirmed' : (context) => CardConfirmed()
    },
    home: WelcomePage()
    ),
  );
}