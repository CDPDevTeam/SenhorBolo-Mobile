import 'package:flutter/material.dart';
import '../../constants.dart';
import '../produto.dart';

class ProdutoVertical extends StatelessWidget {

  final String nomeProduto;
  final String categoriaProduto;
  final String precoProduto;
  final String imgProduto;

  const ProdutoVertical({Key? key, required this.nomeProduto,
    required this.categoriaProduto, required this.precoProduto,
    required this.imgProduto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DetalheProduto())
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
                      'R\$ $precoProduto',
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
                  child: Container(
                    width: 161,
                    height: 161,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        image: DecorationImage(
                            image: AssetImage(imgProduto),
                            fit: BoxFit.contain
                        )
                    ),
                  )
              )
            ],
          ),
        )
    );
  }
}
