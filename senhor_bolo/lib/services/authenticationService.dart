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
            'foto': 'fotodeteste.png'
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
      return parsed['status'] == 'success';
  }

  Future<bool> authLoggedUser() async {
    String? email = await storage.read(key: 'email');
    String? pass = await storage.read(key: 'password');
    final parsed = await getLoginJSON(email!, pass!);
    if (parsed['status'] == 'success'){
      User(
          parsed['data']['email_cli'],
          parsed['data']['nome_cli'],
          parsed['data']['cpf_cli'],
          parsed['data']['foto_cli']
      );
    }
    return parsed['status'] == 'success';
  }

  Future<bool> authLogin(String email, String password) async {
    final parsed = await getLoginJSON(email, password);
    if (parsed['status'] == true){
      storage.write(key: 'email', value: email);
      storage.write(key: 'password', value: password);
      storage.write(key: 'key', value: parsed['data']['key']);
      User(
        email,
        parsed['data']['usuario']['nome_cli'],
        parsed['data']['usuario']['cpf_cli'],
        parsed['data']['usuario']['foto_cli']
      );
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