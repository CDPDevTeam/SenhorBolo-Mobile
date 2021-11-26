import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senhor_bolo/classes/order.dart';
import 'package:senhor_bolo/classes/shoppingCart.dart';
import 'package:senhor_bolo/routes.dart';
import 'package:senhor_bolo/theme/style.dart';

void main()  {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ShoppingCart(),
          ),
          ChangeNotifierProvider(
            create: (_) => Order(),
          )
        ],
        child: const BaseWidget(),
      )// Wrap your app
   );
}

class BaseWidget extends StatelessWidget {
  const BaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Senhor Bolo',
        theme: appTheme(),
        routes: routes,
        initialRoute: 'userCheck',
    );
  }
}