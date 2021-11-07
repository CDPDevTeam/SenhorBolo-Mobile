import 'package:flutter/widgets.dart';
import 'components/aboutUs.dart';
import 'components/checkout.dart';
import 'components/help.dart';
import 'components/shoppingCart.dart';
import 'components/userCheck.dart';
import 'components/cupom.dart';
import 'components/connectionError.dart';
import 'components/welcomePage.dart';
import 'components/homepage.dart';
import 'components/addAddress.dart';
import 'components/addressPicker.dart';
import 'components/creditcard.dart';
import 'components/customCake.dart';
import 'components/login.dart';
import 'components/myOrders.dart';
import 'components/orderConfirmation.dart';
import 'components/searchPage.dart';
import 'components/signUp.dart';
import 'components/tracking.dart';
import 'components/userProfile.dart';

final Map<String, WidgetBuilder> routes = {
  'userCheck': (context) => UserCheck(),
  'connectionError': (context) => ConectionError(),
  'homepage': (context) => Homepage(),
  'welcomePage' : (context) => WelcomePage(),
  'login' : (context) => Login(),
  'signUp': (context) => CadastroApp(),
  'addressPicker' : (context) => AddressPicker(),
  'userProfile' : (context) => UserProfile(),
  'addCreditCard' : (context) => FormCartao(),
  'orders' : (context) => MeusPedidos(),
  'customCake' : (context) => CustomCake(),
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