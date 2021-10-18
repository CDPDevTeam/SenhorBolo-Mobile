import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/addAddress.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/constants.dart';

class WelcomePage extends StatelessWidget {

  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      // Extende o body por de trás da bottomNavigationBar (e da AppBar tbm)
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        // Essa appBar vazia é umn truque indiano para a barra de status ficar na cor do App
        child: AppBar(),
      ),

      body: Container(
        width: screenSize.width,
        height: screenSize.height * 0.77,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/boloBoasVindas.png"),
                fit: BoxFit.cover)),
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 31, top: 12),
            child: Image(
              image: AssetImage("images/logoMarrom.png"),
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        width: double.infinity,
        height: screenSize.height * 0.29,
        padding: EdgeInsets.only(left: 26, top: 33, right: 26, bottom: 48),
        decoration: BoxDecoration(
            color: Color(0xffF5F5F5),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Selecione uma opção para continuar",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
            simpleButton(
                double.infinity,
                51,
                'Realizar Login',
                () => Navigator.pushReplacementNamed(context, 'login'),
                defaultRadius,
                25,
                mainColor
            ),
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, 'homepage'),
              child: Text(
                "Continuar como convidado",
                style: TextStyle(
                    color: Color(0xffB2B2B2),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}