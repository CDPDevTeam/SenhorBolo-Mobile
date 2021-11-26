import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/model/cake.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Classe usada para pegar os bolos na pesquisa e na parte de recomendação
class CakeService{
  Future<List<Cake>> searchCake(String query) async {
    final response = await http.get(
        Uri.parse(urlAPIBD + '/bolo/$query'));
    if(response.statusCode == 200){
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Cake>((json) => Cake.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      List<Cake> listaVazia = [];
      return listaVazia;
    } else {
      throw Exception('Erro ao buscar bolos');
    }
  }

  Future<List<Cake>> getCakeByCategory(String cakeCategory) async {
    final response = await http.get(
        Uri.parse(urlAPIBD + '/bolo/categoria/$cakeCategory'));
    if(response.statusCode == 200){
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Cake>((json) => Cake.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar bolos pela categoria');
    }
  }
  
  Future<List<Cake>> recommendedCake() async{
    final response = await http.get(Uri.parse(urlAPIBD + '/bolo/recomendacao'));
    if(response.statusCode == 200){
      return parseCake(response.body);
    } else {
      throw Exception('Erro ao acessar a API');
    }
  }

  Future<Cake> insertCustomCake(String? massa, String? recheio,
      String? cobertura, String? confeito) async{

    final storage = FlutterSecureStorage();
    String? key = await storage.read(key: 'key');

    var body = jsonEncode({
      "massa": massa,
      "recheio": recheio,
      "cobertura": cobertura,
      "confeito": confeito
    });
    http.Response response = await http.post(
        Uri.parse(urlAPIBD + '/bolo'),
        headers: {
          'Authorization' : 'Bearer $key'
        },
        body: body
    );
    final json = jsonDecode(response.body);
    var preco = json[0]['preco_catprod'].split('\$');
    return Cake(
      id: json[0]['id_prod'] as int,
      name: json[0]['nome_prod'] as String,
      image: json[0]['foto_prod'] as String,
      category: json[0]['categoria_prod_fk'] as String,
      price: double.parse(preco[1]),
      qtde: 0,
    );
  }

  List<Cake> parseCake(String responseBody){
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Cake>((json) => Cake.fromJson(json)).toList();
  }
}