import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../cakeDetail.dart';

class ProdutoVertical extends StatelessWidget {

  final String nomeProduto;
  final String categoriaProduto;
  final double precoProduto;
  final String imgProduto;

  const ProdutoVertical({Key? key, required this.nomeProduto,
    required this.categoriaProduto, required this.precoProduto,
    required this.imgProduto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CakeDetail(
                nomeProduto: nomeProduto,
                categoriaProduto: categoriaProduto,
                imgProduto: imgProduto,))
          );
        },
        child: Container(
          width: 176,
          height: 227,
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Container(
                width: 176,
                height: 222,
                padding: EdgeInsets.only(top: 160, left: 22),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Text>[
                    Text(
                      nomeProduto,
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      categoriaProduto,
                      style: TextStyle(
                          fontSize: 12,
                          color: textSecondaryColor
                      ),
                    ),
                    Text(
                      'R\$' + precoProduto.toString() + " - 30,00",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  right: 0,
                  top: 0,
                  child: Hero(
                      tag: nomeProduto,
                      child: Container(
                        width: 161,
                        height: 161,
                        decoration: BoxDecoration(
                            color: Color(0xff64CBC7),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            /*
                            image: DecorationImage(image: NetworkImage('https://thespacefox.github.io/SenhorBolo-Imagens/images/' + imgProduto),
                                fit: BoxFit.contain) */
                        ),
                        child: CachedNetworkImage(
                          imageUrl: 'https://thespacefox.github.io/SenhorBolo-Imagens/images/' + imgProduto,
                          fit: BoxFit.contain,
                        ),
                      )
                  )
              )
            ],
          ),
        )
    );
  }
}
