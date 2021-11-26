import 'package:provider/provider.dart';
import 'package:senhor_bolo/classes/order.dart';
import 'package:senhor_bolo/services/cupomService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:senhor_bolo/model/cupom.dart';
import '../constants.dart';
import 'package:senhor_bolo/components/widgets/iconAppBar.dart';

class Cupom extends StatefulWidget {
  const Cupom({Key? key}) : super(key: key);
  @override
  _CupomState createState() => _CupomState();
}

class _CupomState extends State<Cupom> {
  late Future<List<Coupon>> futureCupom;
  late Order orderCupom;
  late int cupomSelecionado;

  @override
  void initState(){
    super.initState();
    futureCupom = CupomService().getCupom();
    orderCupom = context.read<Order>();
    cupomSelecionado = orderCupom.orderCoupon == null
        ? -1
        : orderCupom.orderCoupon!.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IconAppBar(
        appBarText: 'Meus cupons',
        appBarIcon: Icons.local_offer,
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<List<Coupon>>(
            future: futureCupom,
            builder: (context, snapshot) {
              if (snapshot.hasData){
                if(snapshot.data!.length != 0){
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisExtent: 140,
                          mainAxisSpacing: 20),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Coupon cupom = snapshot.data![index];
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                cupomSelecionado = cupom.id;
                                orderCupom.orderCoupon = cupom;
                              });
                            },
                            child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                width: 164,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: cupomSelecionado == cupom.id ? mainColor : Color(0xffE6E6E6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '${cupom.discountPercentage}% OFF',
                                        style: TextStyle(
                                            color: cupomSelecionado == cupom.id ?  mainTextColor : textSecondaryColor,
                                            fontFamily: 'Montserrat',
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(
                                        'Em todo o app',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: cupomSelecionado == cupom.id ? mainTextColor : textSecondaryColor,
                                            fontSize: 15
                                        ),
                                      )
                                    ],
                                  ),
                                )));
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
                            'Você não tem cupons...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            'Distribuimos cupons em datas especiais, \n fique atento a nossas redes sociais!',
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

              } else if (snapshot.hasError){
                throw Exception('Erro ao buscar cupons');
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )
      ),
    );
  }
}