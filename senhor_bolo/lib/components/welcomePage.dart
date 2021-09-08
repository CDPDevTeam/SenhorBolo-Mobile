import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/homepage.dart';
import 'package:senhor_bolo/components/login.dart';
import 'package:senhor_bolo/constants.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Extende o body por de trás da bottomNavigationBar (e da AppBar tbm)
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0), // Essa appBar vazia é umn truque indiano para a barra de status ficar na cor do App
        child: AppBar(

        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          top: true,
          bottom: true,
          left: false,
          right: false,
          child: Container(
            width: double.infinity,
            height: 663,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/boloBoasVindas.png"),
                fit: BoxFit.cover
              )
            ),
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
        )
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 252,
        padding: EdgeInsets.only(left: 26, top: 33, right: 26, bottom: 48),
        decoration: BoxDecoration(
          color: Color(0xffF5F5F5),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20)
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Selecione uma opção para continuar",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 51,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => LoginApp())
                  );
                },
                child: Text("Realizar Login"),
                style: ElevatedButton.styleFrom(
                  primary: mainColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultRadius)
                  ),
                  textStyle: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                print("Usuário Convidado");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Homepage())
                );
              },
              child: Text(
                "Continuar como convidado",
                style: TextStyle(
                  color: Color(0xffB2B2B2),
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Teste extends StatefulWidget {
  const Teste({Key? key}) : super(key: key);

  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {



  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

