import 'package:senhor_bolo/classes/user.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthenticationService{
  final storage = FlutterSecureStorage();

  Future<bool> signUp(String email, String name,
      String cpf, String password) async{
      var body = jsonEncode(
          {
            'cadastro': true,
            'email': email,
            'senha': password,
            'nome': name,
            'cpf': cpf,
            'foto': 'defaultpicture.png'
          }
      );
      http.Response response = await http.post(
          Uri.parse(urlAPIBD + '/user'),
          headers: {
            'Content-type': 'application/json; charset=UTF-8'
          },
          body: body
      );
      final parsed = jsonDecode(response.body);
      return parsed['success'];
  }

  Future<bool> authLoggedUser() async {
    String? email = await storage.read(key: 'email');
    String? pass = await storage.read(key: 'password');
    final parsed = await getLoginJSON(email!, pass!);
    if (parsed['success']){
      User.email = email;
      User.username = parsed['data']['usuario'][0]['nome_cli'];
      User.cpf = parsed['data']['usuario'][0]['cpf_cli'];
      User.image = parsed['data']['usuario'][0]['foto_cli'];
    }
    return parsed['success'];
  }

  Future<bool> authLogin(String email, String password) async {
    var parsed = await getLoginJSON(email, password);
    if (parsed['success']){
      storage.write(key: 'email', value: email);
      storage.write(key: 'password', value: password);
      storage.write(key: 'key', value: parsed['data']['key']);
      User.email = email;
      User.username = parsed['data']['usuario'][0]['nome_cli'];
      User.cpf = parsed['data']['usuario'][0]['cpf_cli'];
      User.image = parsed['data']['usuario'][0]['foto_cli'];
    }
    return parsed['success'];
  }

  Future<Map<String, dynamic>> getLoginJSON(String email, String password) async {
    var body = jsonEncode(
        {
          'email': email,
          'senha': password
        }
    );
    http.Response response = await http.post(
        Uri.parse(urlAPIBD + '/auth/login'),
        headers: {
          'Content-type': 'application/json; charset=UTF-8'
        },
        body: body
    );
    return jsonDecode(response.body);
  }

}