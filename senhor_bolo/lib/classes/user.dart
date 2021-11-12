import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:senhor_bolo/constants.dart';

class User{
    static late String email;
    static late String username;
    static late String cpf;
    static late String image;

    Future<bool> updateUser(String name, String cpf, String password) async{
        final storage = FlutterSecureStorage();

        String? savedPassword = await storage.read(key: 'password');

        if(savedPassword == password){
            String? key = await storage.read(key: 'key');

            var body = jsonEncode({
                'nome': name,
                'cpf': cpf,
                'senha': password,
                'foto': 'defaultimg.png'
            });

            http.Response response = await http.put(
                Uri.parse(urlAPIBD + '/user/$email'),
                headers: {
                    'Authorization' : 'Bearer $key'
                },
                body: body
            );

            return response.statusCode == 200;
        } else {
           return false;
        }
    }

    Future<bool> updatePassword(String atualPass, String newPass) async{
        final storage = FlutterSecureStorage();

        String? savedPassword = await storage.read(key: 'password');

        print(savedPassword == atualPass);
        if(savedPassword == atualPass){
            String? key = await storage.read(key: 'key');

            var body = jsonEncode({
                'nome': username,
                'cpf': cpf,
                'senha': newPass,
                'foto': 'defaultimg.png'
            });

            http.Response response = await http.put(
                Uri.parse(urlAPIBD + '/user/$email'),
                headers: {
                    'Authorization' : 'Bearer $key'
                },
                body: body
            );

            if(response.statusCode == 200){
                await storage.write(key: 'password', value: newPass);
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }


}