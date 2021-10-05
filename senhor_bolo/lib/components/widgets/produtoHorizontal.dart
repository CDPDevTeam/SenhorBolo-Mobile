import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../cakeDetail.dart';

class ProdutoHorizontal extends StatelessWidget {
  final String nomeProduto;
  final String categoriaProduto;
  final double precoProduto;
  final String imgProduto;

  const ProdutoHorizontal(
      {Key? key,
      required this.nomeProduto,
      required this.categoriaProduto,
      required this.precoProduto,
      required this.imgProduto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CakeDetail(
                  nomeProduto: nomeProduto,
                  categoriaProduto: categoriaProduto,
                  imgProduto: imgProduto,
                )));
      },
      child: SizedBox(
        width: 328,
        height: 118,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 138,
              height: 118,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    'https://thespacefox.github.io/SenhorBolo-Imagens/images/' +
                        imgProduto,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              width: 190,
              height: 98,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nomeProduto,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    categoriaProduto,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: textSecondaryColor),
                  ),
                  Text(
                    'R\$' + precoProduto.toString() + " - 30,00",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
