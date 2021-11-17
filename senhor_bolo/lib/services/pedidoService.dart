import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:senhor_bolo/classes/user.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/model/pedido.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PedidoService{
  Future<List<Pedido>>? getPedidosAbertos() async {
    final storage = FlutterSecureStorage();

    String? key = await storage.read(key: 'key');

    final response = await http.get(
      Uri.parse(urlAPIBD + '/pedido/${User.email}'),
      headers: {
        'Authorization' : 'Bearer $key'
      }
    );

    final jsonDecoded = jsonDecode(response.body);

    if(response.statusCode == 200){
      final parsed = jsonDecoded.cast<Map<String, dynamic>>();
      return parsed.map<Pedido>((json) => Pedido.fromJson(json)).toList();
    } else if (jsonDecoded['success'] == false){
      List<Pedido> testeSemPedido = [];
      return testeSemPedido;
    } else {
      throw Exception('Erro ao carregar os pedidos');
    }
  }
}