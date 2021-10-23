import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:senhor_bolo/constants.dart';

class WelcomePage extends StatelessWidget {

  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        // Essa appBar vazia é para a barra de status ficar na cor do App
        child: AppBar(),
      ),

      body: Container(
        width: screenSize.width,
        height: screenSize.height * 0.77,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/boloBoasVindas.png"),
                fit: BoxFit.cover)),
        child: const Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 26, top: 12),
            child: Image(
              width: 110,
              height: 110,
              image: AssetImage("images/logoMarrom.png"),
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        width: double.infinity,
        height: screenSize.height * 0.29,
        padding: const EdgeInsets.only(left: 26, top: 33, right: 26, bottom: 48),
        decoration: const BoxDecoration(
            color: Color(0xffF5F5F5),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "Selecione uma opção para continuar",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
            simpleButton(
                double.infinity,
                51,
                'Realizar Login',
                () => Navigator.pushReplacementNamed(context, 'login'),
                defaultButtonRadius,
                25,
                mainColor
            ),
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, 'homepage'),
              child: const Text(
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