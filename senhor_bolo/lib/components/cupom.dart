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

  @override
  void initState(){
    super.initState();
    futureCupom = CupomService().getCupom();
  }

  int? cupomSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: IconAppBar(
        appBarText: 'Meus cupons',
        appBarIcon: Icons.local_offer,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<Coupon>>(
          future: futureCupom,
          builder: (context, snapshot) {
            print("DATAAA ${snapshot.data}");
            if (snapshot.hasData){
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
                            cupomSelecionado = index;
                          });
                        },
                        child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            width: 164,
                            height: 140,
                            decoration: BoxDecoration(
                              color: cupomSelecionado == index ? mainColor : Color(0xffE6E6E6),
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
                                        color: cupomSelecionado == index ?  mainTextColor : textSecondaryColor,
                                        fontFamily: 'Montserrat',
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                   'Em todo o app',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: cupomSelecionado == index ? mainTextColor : textSecondaryColor,
                                        fontSize: 15
                                    ),
                                  )
                                ],
                              ),
                            )));
                  });
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