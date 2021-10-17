import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/produtoHorizontal.dart';
import 'package:senhor_bolo/components/widgets/searchAppBar.dart';
import 'package:senhor_bolo/constants.dart';
import 'classes/api.dart';
import 'model/cake.dart';


class SearchResult extends StatefulWidget {
  final String searchText;
  const SearchResult({Key? key, required this.searchText}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  API api = API();
  Future<List<Cake>>? resultadoPesquisa;

  String searchResult(int queryResult) {
    if (queryResult > 0) {
      return 'Resultado(s) encontrado(s) para ' + widget.searchText;
    } else {
      return 'Nenhum resultado encontrado para ' + widget.searchText;
    }
  }

  @override
  void initState() {
    super.initState();
    resultadoPesquisa = api.searchCake(widget.searchText);
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
            const SizedBox(
              height: 15,
            ),
            Text(
              searchResult(3),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, color: textSecondaryColor),
            ),
            const SizedBox(
              height: 15,
            ),
            FutureBuilder<List<Cake>>(
              future: resultadoPesquisa,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Center(
                    child: SizedBox(
                      width: 328,
                      child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ProdutoHorizontal(
                              nomeProduto: snapshot.data![index].name,
                              categoriaProduto: snapshot.data![index].category,
                              precoProduto: snapshot.data![index].price.toDouble(),
                              imgProduto: snapshot.data![index].image);
                        },
                        separatorBuilder: (context, int index) {
                          return SizedBox(height: 20);
                        },
                      ),
                    )
                  );
                } else if (snapshot.hasError){
                  return Text('${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        )
    );
  }
}
