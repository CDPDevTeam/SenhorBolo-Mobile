import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/model/cupom.dart';
import 'package:senhor_bolo/classes/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CupomService{
  final storage = FlutterSecureStorage();

  Future<List<Coupon>> getCupom() async{
    String? key = await storage.read(key:  'key');
    http.Response response = await http.get(
        Uri.parse(urlAPIBD + '/cupom/${User.email}'),
        headers: {
          'Authorization' : "Bearer $key"
        }
    );
    final jsonDecoded = jsonDecode(response.body);
    if (response.statusCode == 200){
      print(response.body);
      final parsed = jsonDecoded.cast<Map<String, dynamic>>();
      return parsed.map<Coupon>((json) => Coupon.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar cupons da API');
    }
  }
}