import 'package:flutter/material.dart';
import 'package:senhor_bolo/routes.dart';
import 'package:senhor_bolo/theme/style.dart';

void main()  {
  runApp(const BaseWidget());
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