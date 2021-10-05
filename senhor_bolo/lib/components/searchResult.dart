import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/produtoHorizontal.dart';
import 'package:senhor_bolo/components/widgets/searchAppBar.dart';
import 'package:senhor_bolo/constants.dart';

class SearchResult extends StatefulWidget {
  final String searchText;

  const SearchResult({Key? key, required this.searchText}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  static List<String> _imagensBolosSimples = [
    'formigueiro.png',
    'bolo_nada.png',
    'laranja.png',
    'chocolate.png',
    'formigueiro.png',
    'bolo_nada.png',
    'laranja.png',
    'chocolate.png',
  ];

  static List<String> _bolosSimples = [
    'Formigueiro',
    'Bolo de nada',
    'Laranja',
    'Chocolate',
    'Formigueiro',
    'Bolo de nada',
    'Laranja',
    'Chocolate',
  ];

  static List<String> _categoriaBolosSimples = [
    "Bolo simples",
    "Bolo simples",
    "Bolo simples",
    "Bolo simples",
    "Bolo simples",
    "Bolo simples",
    "Bolo simples",
    "Bolo simples",
  ];

  static List<double> _precoBoloSimples = [
    12.00,
    12.00,
    12.00,
    12.00,
    12.00,
    12.00,
    12.00,
    12.00,
  ];

  String searchResult(int queryResult) {
    if (queryResult > 0) {
      if (queryResult == 1) {
        return '$queryResult resultado encontrado para ' + widget.searchText;
      } else {
        return '$queryResult resultados encontrados para ' + widget.searchText;
      }
    } else {
      return 'Nenhum resultado encontrado para ' + widget.searchText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: mainColor,
          child: Icon(Icons.shopping_cart),
        ),
        appBar: SearchAppBar(searchText: widget.searchText,),
        body: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              searchResult(3),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: textSecondaryColor),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                width: 328,
                child: ListView.separated(
                  itemCount: _bolosSimples.length,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ProdutoHorizontal(
                        nomeProduto: _bolosSimples[index],
                        categoriaProduto: _categoriaBolosSimples[index],
                        precoProduto: _precoBoloSimples[index],
                        imgProduto: _imagensBolosSimples[index]);
                  },
                  separatorBuilder: (context, int index) {
                    return SizedBox(height: 20);
                  },
                ),
              ),
            )
          ],
        )
    );
  }
}
