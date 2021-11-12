import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/model/address.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:senhor_bolo/classes/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressService{
 final storage = FlutterSecureStorage();
  Future<List<Address>> getAll() async{
    String? key = await storage.read(key: 'key');
    print('$key');
    http.Response response = await http.get(
      Uri.parse(urlAPIBD + '/address/${User.email}'),
      headers: {
        'Authorization' : "Bearer $key"
      }
    );
    if(response.statusCode == 200){
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      print('$parsed');
      return parsed.map<Address>((json) => Address.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar endereço');
    }
  }
  Future<bool> postAddress(String rua, String bairro, String cep, String numero,
      String? complemento, String? observacao) async{
    String? key = await storage.read(key: 'key');
    var body = jsonEncode({
      'email': User.email,
      'rua': rua,
      'bairro': bairro,
      'numero': numero,
      'cep': cep,
      'complemento': complemento,
      'observacao': observacao
    });
    http.Response response = await http.post(
      Uri.parse(urlAPIBD + '/address'),
      headers: {
        'Authorization' : 'Bearer $key'
      },
      body: body
    );
    return response.statusCode == 200;
  }

  Future<bool> putAddress(int id,String rua, String bairro, String cep, String numero,
      String? complemento, String? observacao) async{
    String? key = await storage.read(key: 'key');
    var body = jsonEncode({
      'email': User.email,
      'rua': rua,
      'bairro': bairro,
      'numero': numero,
      'cep': cep,
      'complemento': complemento,
      'observacao': observacao
    });
    http.Response response = await http.put(
      Uri.parse(urlAPIBD + '/address/$id'),
      headers: {
        'Authorization' : 'Bearer $key'
      },
      body: body
    );
    return response.statusCode == 200;

  }

  Future<bool> deleteAddress(int id) async{
    String? key = await storage.read(key: 'key');
    http.Response response = await http.delete(
      Uri.parse(urlAPIBD + '/address/$id'),
      headers: {
        'Authorization' : 'Bearer $key'
      },
    );
    return response.statusCode == 200;
  }
}