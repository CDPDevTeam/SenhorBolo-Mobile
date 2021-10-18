import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../cakeDetail.dart';

class ProdutoVertical extends StatelessWidget {

  final String nomeProduto;
  final String categoriaProduto;
  final int precoProduto;
  final String imgProduto;

  const ProdutoVertical({Key? key, required this.nomeProduto,
    required this.categoriaProduto, required this.precoProduto,
    required this.imgProduto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                height: 220,
                padding: EdgeInsets.only(top: 160, left: 22),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      nomeProduto,
                      maxLines: 1,
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
                            borderRadius: BorderRadius.circular(20),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: urlImagem + imgProduto,
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
