import 'package:flutter/widgets.dart';
import 'package:senhor_bolo/components/aboutUs.dart';
import 'package:senhor_bolo/components/checkout.dart';
import 'package:senhor_bolo/components/help.dart';
import 'package:senhor_bolo/components/shoppingCart.dart';
import 'package:senhor_bolo/components/userCheck.dart';
import 'package:senhor_bolo/components/cupom.dart';
import 'components/welcomePage.dart';
import 'components/homepage.dart';
import 'components/addAddress.dart';
import 'components/addressPicker.dart';
import 'components/creditcard.dart';
import 'components/customCake.dart';
import 'components/deliveryProblem.dart';
import 'components/login.dart';
import 'components/myOrders.dart';
import 'components/orderConfirmation.dart';
import 'components/ratingScreen.dart';
import 'components/searchPage.dart';
import 'components/signUp.dart';
import 'components/tracking.dart';
import 'components/userProfile.dart';

final Map<String, WidgetBuilder> routes = {
  'userCheck': (context) => UserCheck(),
  'homepage': (context) => Homepage(),
  'welcomePage' : (context) => WelcomePage(),
  'login' : (context) => Login(),
  'signUp': (context) => CadastroApp(),
  'addressPicker' : (context) => AddressPicker(),
  'userProfile' : (context) => UserProfile(),
  'addCreditCard' : (context) => FormCartao(),
  'orders' : (context) => MeusPedidos(),
  'customCake' : (context) => CustomCake(),
  'orderRating' : (context) => RatingScreen(),
  'orderFeedback' : (context) => DeliveryProblem(),
  'tracking' : (context) => Tracking(currentStep: 1),
  'searchPage' : (context) => SearchPage(),
  'cardError' : (context) => CardDenied(),
  'orderConfirmed' : (context) => CardConfirmed(),
  'addAddress' : (context) => AddAddress(),
  'shoppingCart' : (context) => Cart(),
  'checkout' : (context) => Checkout(),
  'help' : (context) => HelpPage(),
  'aboutUs' : (context) => AboutUs(),
  'cupons': (context) => Cupom()
};