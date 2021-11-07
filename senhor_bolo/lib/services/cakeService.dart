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
    } else {
      throw Exception('Erro ao buscar bolos');
    }
  }

  Future<List<Cake>> searchCakeByCategory(String cakeCategory) async {
    final response = await http.get(
        Uri.parse(urlAPIBD + '/bolo/$cakeCategory'));
    if(response.statusCode == 200){
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Cake>((json) => Cake.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar bolos pela categoria');
    }
  }
  
  Future<List<Cake>> recommendedCake(String cakeCategory) async{
    final response = await http.get(Uri.parse(urlAPIBD + '/bolo/recomendacao'));
    if(response.statusCode == 200){
      return parseCake(response.body);
    } else {
      throw Exception('Erro ao acessar a API');
    }
  }

  List<Cake> parseCake(String responseBody){
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Cake>((json) => Cake.fromJson(json)).toList();
  }
}