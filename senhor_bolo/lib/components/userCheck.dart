import 'package:flutter/material.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/services/authenticationService.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class UserCheck extends StatefulWidget {
  const UserCheck({Key? key}) : super(key: key);

  @override
  _UserCheckState createState() => _UserCheckState();
}

class _UserCheckState extends State<UserCheck> {

  Future<bool> _isAPIActive() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      http.Response response = await http.get(Uri.parse(urlAPIBD + '/bolos'));
      if(response.statusCode == 404){
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Future<bool> _authUser() async {
    AuthenticationService authService = AuthenticationService();
    final storage = FlutterSecureStorage();
    var alreadyLogged = await storage.read(key: 'email');
    if (alreadyLogged == null){
      return false;
    } else {
      await authService.authLoggedUser();
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    _isAPIActive().then((value) {
      if (value) {
        _authUser().then((value) {
          if (value){
            Navigator.pushReplacementNamed(context, 'homepage');
          } else {
            Navigator.pushReplacementNamed(context, 'login');
          }
        });
      } else {
        Navigator.pushNamed(context, 'connectionError');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: const Center(
        child: CircularProgressIndicator(color: Colors.white)
      ),
    );
  }
}
