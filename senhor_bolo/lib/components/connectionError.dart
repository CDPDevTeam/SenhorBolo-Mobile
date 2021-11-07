import 'package:flutter/material.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';

class ConectionError extends StatelessWidget {
  const ConectionError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/erroConexao.png',
                width: 242,
                height: 186,
              ),
              const SizedBox(height: 20),
              Text(
                'Parece que não há internet!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Verifique sua conexão para \n usar o aplicativo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: textSecondaryColor
                ),
              ),
              const SizedBox(height: 20),
              simpleButton(
                  248, 39, 'Tentar novamente',
                  () => Navigator.pushNamed(context, 'userCheck'),
                  defaultButtonRadius, 18, mainColor)
            ],
          ),
        ),
      ),
    );
  }
}
