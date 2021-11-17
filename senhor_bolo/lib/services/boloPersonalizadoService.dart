import 'package:senhor_bolo/model/opcaoBoloPersonalizado.dart';
import 'package:flutter/foundation.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BoloPersonalizadoService{

  Future<List<OpcaoBoloPersonalizado>> getMassa() async {
    final response = await http.get(
      Uri.parse(urlAPIBD + '/massa')
    );
    if(response.statusCode == 200){
      return compute(parseOpcao, response.body);
    } else {
      throw Exception('Erro ao buscar as massas');
    }
  }

  Future<List<OpcaoBoloPersonalizado>> getRecheio() async {
    final response = await http.get(
        Uri.parse(urlAPIBD + '/recheio')
    );
    if(response.statusCode == 200){
      return compute(parseOpcao, response.body);
    } else {
      throw Exception('Erro ao buscar os recheios');
    }
  }

  Future<List<OpcaoBoloPersonalizado>> getCobertura() async {
    final response = await http.get(
        Uri.parse(urlAPIBD + '/cobertura')
    );
    if(response.statusCode == 200){
      return compute(parseOpcao, response.body);
    } else {
      throw Exception('Erro ao buscar as coberturas');
    }
  }

  Future<List<OpcaoBoloPersonalizado>> getConfeitos() async {
    final response = await http.get(
        Uri.parse(urlAPIBD + '/confeito')
    );
    if(response.statusCode == 200){
      return compute(parseOpcao, response.body);
    } else {
      throw Exception('Erro ao buscar os confeitos');
    }
  }
}

List<OpcaoBoloPersonalizado> parseOpcao(String responseBody){
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<OpcaoBoloPersonalizado>((json) => OpcaoBoloPersonalizado.fromJson(json)).toList();
}