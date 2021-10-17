import 'package:senhor_bolo/components/model/cake.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:senhor_bolo/constants.dart';

class API{
  Future<List<Cake>> searchCake(String query) async {
    final response = await http.get(
        Uri.parse(urlAPI + 'bolos?nome_like=$query'));
    if(response.statusCode == 200){
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Cake>((json) => Cake.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar bolos');
    }
  }
  
  Future<List<Cake>> recommendedCake(String cakeCategory) async{
    final response = await http.get(Uri.parse(urlAPI + 'bolos?_limit=5'));
    if(response.statusCode == 200){
      return parseCake(response.body);
    } else {
      throw Exception('Erro ao buscar bolos');
    }
  }

  List<Cake> parseCake(String responseBody){
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Cake>((json) => Cake.fromJson(json)).toList();
  }
}