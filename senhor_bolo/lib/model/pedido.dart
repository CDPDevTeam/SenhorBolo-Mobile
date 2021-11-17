class Pedido{
  int idPedido;
  String statusCompra;
  List<ItensPedido>? itensPedido;

  Pedido({
    required this.idPedido,
    required this.statusCompra,
    required this.itensPedido});

  factory Pedido.fromJson(Map<String, dynamic> json) {

    List<ItensPedido>? itens = [];
    json['itens_pedido'].forEach((v) {
      itens.add(ItensPedido.fromJson(v));
    });

    return Pedido(
        idPedido: json['id_pedido'],
        statusCompra: json['status_compra'],
        itensPedido: itens
    );
  }
}

class ItensPedido {
  final int idProd;
  final String nomeProd;
  final String categoriaProdFk;
  final String fotoProd;
  final int qtdePedido;
  final String totalProd;

  ItensPedido(
      {required this.idProd,
        required this.nomeProd,
        required this.categoriaProdFk,
        required this.fotoProd,
        required this.qtdePedido,
        required this.totalProd});

  factory ItensPedido.fromJson(Map<String, dynamic> json) {
    return ItensPedido(
        idProd: json['id_prod'],
        nomeProd:  json['nome_prod'],
        categoriaProdFk:  json['categoria_prod_fk'],
        fotoProd: json['foto_prod'],
        qtdePedido: json['qtde_pedido'],
        totalProd:  json['total_prod']
    );
  }
}