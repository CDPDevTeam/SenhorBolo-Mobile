import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/services/authenticationService.dart';

class UserCheck extends StatefulWidget {
  const UserCheck({Key? key}) : super(key: key);

  @override
  _UserCheckState createState() => _UserCheckState();
}

class _UserCheckState extends State<UserCheck> {

  Future<bool> _authUser() async {
    AuthenticationService authService = AuthenticationService();
    final storage = FlutterSecureStorage();
    var alreadyLogged = await storage.read(key: 'email');
    if (alreadyLogged == null){
      return false;
    } else {
      authService.authLoggedUser();
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    _authUser().then((value) {
      if (value){
        Navigator.pushReplacementNamed(context, 'homepage');
      } else {
        Navigator.pushReplacementNamed(context, 'login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Image.asset('images/splash_image.png')
      ),
    );
  }
}
