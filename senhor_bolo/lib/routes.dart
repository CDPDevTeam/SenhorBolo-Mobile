import 'package:flutter/widgets.dart';
import 'components/updatePassword.dart';
import 'components/updateUser.dart';
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
import 'components/userProfile.dart';

final Map<String, WidgetBuilder> routes = {
  'userCheck': (context) => UserCheck(),
  'connectionError': (context) => ConectionError(),
  'homepage': (context) => HomePage(),
  'welcomePage' : (context) => WelcomePage(),
  'login' : (context) => Login(),
  'signUp': (context) => CadastroApp(),
  'addressPicker' : (context) => AddressPicker(),
  'userProfile' : (context) => UserProfile(),
  'addCreditCard' : (context) => FormCartao(),
  'orders' : (context) => MeusPedidos(),
  'customCake' : (context) => CustomCake(),
  'searchPage' : (context) => SearchPage(),
  'cardError' : (context) => CardDenied(),
  'orderConfirmed' : (context) => CardConfirmed(),
  'addAddress' : (context) => AddAddress(),
  'shoppingCart' : (context) => Cart(),
  'checkout' : (context) => Checkout(),
  'help' : (context) => HelpPage(),
  'aboutUs' : (context) => AboutUs(),
  'cupons': (context) => Cupom(),
  'updateUser': (context) => UpdateUser(),
  'updatePassword': (context) => UpdatePassword()
};