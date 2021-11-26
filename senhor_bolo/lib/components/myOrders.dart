import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/tracking.dart';
import 'package:senhor_bolo/model/pedido.dart';
import 'package:senhor_bolo/services/pedidoService.dart';
import '../../constants.dart';
import 'package:senhor_bolo/components/widgets/iconAppBar.dart';
import 'package:senhor_bolo/components/widgets/simpleButton.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MeusPedidos extends StatefulWidget {
  const MeusPedidos({Key? key}) : super(key: key);

  @override
  _MeusPedidosState createState() => _MeusPedidosState();
}

class _MeusPedidosState extends State<MeusPedidos> {

  void _trackingStep(String etapaPedido, int idPedido){
    int orderStep;

    print(etapaPedido);

    if(etapaPedido == 'Pedido recebido'){
      orderStep = 0;
    } else if (etapaPedido == 'Pedido em preparação'){
      orderStep = 1;
    } else {
      orderStep = 2;
    }

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Tracking(currentStep: orderStep, idPedido: idPedido)
    ));
  }

  late Future<List<Pedido>>? pedidosAbertos;
  PedidoService apiPedido = PedidoService();

  @override
  void initState() {
    super.initState();
    pedidosAbertos = apiPedido.getPedidosAbertos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: IconAppBar(
        appBarText: 'Meus pedidos',
        appBarIcon: Icons.local_shipping,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Pedidos em aberto",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            FutureBuilder<List<Pedido>>(
                future: pedidosAbertos,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data!.length != 0){
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {

                            Pedido pedidoLista = Pedido(
                                idPedido: snapshot.data![index].idPedido,
                                statusCompra: snapshot.data![index].statusCompra,
                                itensPedido: snapshot.data![index].itensPedido
                            );
                            return Container(
                              width: double.infinity,
                              child: Column(
                                  children: [
                                    const SizedBox(height: 15),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Pedido #${pedidoLista.idPedido}',
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ListView.separated(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        separatorBuilder: (context, int index) {
                                          return const SizedBox(height: 10);
                                        },
                                        itemCount: pedidoLista.itensPedido!.length,
                                        itemBuilder: (context, index){

                                          ItensPedido itemPedido = pedidoLista.itensPedido![index];

                                          return  ProdutoPedido(
                                              qtde: itemPedido.qtdePedido,
                                              nomeProduto: itemPedido.nomeProd,
                                              categoriaProduto: itemPedido.categoriaProdFk,
                                              precoProduto: itemPedido.totalProd,
                                              imgProduto: itemPedido.fotoProd
                                          );
                                        }
                                    ),
                                    const SizedBox(height: 15),
                                    simpleButtonIcon(306, 47, 'Rastrear',
                                            () => _trackingStep(pedidoLista.statusCompra, pedidoLista.idPedido),
                                        10, 25, mainColor, Icon(Icons.near_me), FontWeight.bold),
                                  ]
                              ),
                            );
                          });
                    } else {
                      return Container(
                          child: Column(
                            children: [
                              const Text(
                                '(¬_¬)',
                                style: TextStyle(
                                    fontSize: 92,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffD5D5D5)
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Você ainda não pediu nada...',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                    fontSize: 18,
                                ),
                              ),
                              const Text(
                                'Temos muitos bolos te esperando!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: textSecondaryColor
                                ),
                              ),
                            ],
                          )
                      );
                    }

                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Container(
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        CircularProgressIndicator(),
                        const SizedBox(height: 15)
                      ],
                    ),
                  );
                }
            ),
          ],
        ),
      )
    );
  }
}

class ProdutoPedido extends StatelessWidget {
  final String nomeProduto;
  final String categoriaProduto;
  final String precoProduto;
  final String imgProduto;
  final int qtde;
  const ProdutoPedido(
      {Key? key,
        required this.qtde,
        required this.nomeProduto,
        required this.categoriaProduto,
        required this.precoProduto,
        required this.imgProduto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 104,
            height: 104,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: mainColor,
            ),
            child: CachedNetworkImage(
              imageUrl: urlImagem + '/bolos/' + imgProduto,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
              child: Padding (
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nomeProduto,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          categoriaProduto,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(text: "qtde ", style: TextStyle(fontSize: 12)),
                                  TextSpan(text: qtde.toString())
                                ]
                            )
                        ),
                        RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                ),
                                children: [
                                  const TextSpan(text: "total ", style: TextStyle(fontSize: 12)),
                                  TextSpan(text: "R$precoProduto")
                                ]
                            )
                        ),
                      ],
                    )
                  ],
                ) ,
              )
          )
        ],
      ),
    );
  }
}