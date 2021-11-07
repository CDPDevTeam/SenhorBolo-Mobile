import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:senhor_bolo/classes/user.dart';
import 'package:senhor_bolo/components/widgets/produtoHorizontal.dart';
import 'package:senhor_bolo/components/widgets/shimmerProdutoHorizontal.dart';
import 'package:senhor_bolo/constants.dart';
import 'package:senhor_bolo/model/cake.dart';
import '../services/cakeService.dart';

class SearchResult extends StatefulWidget {
  final String searchText;
  const SearchResult({Key? key, required this.searchText}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  CakeService api = CakeService();
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
          child: const Icon(Icons.shopping_cart),
        ),
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 88,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: 50,
            ),
          ),
          title: InkWell(
            onTap: () => Navigator.pushNamed(context, 'addressPicker'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: <Text>[
                    const Text(
                      'Entregar em',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      'Rua Humaitá, 538',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                    ),
                  ],
                ),
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 20,
                )
              ],
            ),
          ),
          actions: <Widget>[
            InkWell(
                onTap: () =>
                    Navigator.pushReplacementNamed(context, 'userProfile'),
                child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: CachedNetworkImage(
                        imageUrl:
                        'https://thespacefox.github.io/SenhorBolo-Imagens/images/usuario/${User.image}',
                        imageBuilder: (context, imageProvider) => Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fitWidth)),
                        ))))
          ],
          bottom: PreferredSize(
            preferredSize: Size(350, 70),
            child: Container(
                width: 350,
                height: 70,
                child: TextField(
                  controller: TextEditingController(text: widget.searchText),
                  textInputAction: TextInputAction.go,
                  onSubmitted: (searchText){
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => SearchResult(searchText: searchText,)));
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      hintText: 'Bolo de miiiiiiiiiiiiiiiiiiiiiiiilhooo',
                      filled: true,
                      fillColor: Color(0xffE6E6E6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffB5B5B5)),
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      )),
                )),
          ),
        ),
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
                              imgProduto: snapshot.data![index].image,
                              idProduto: snapshot.data![index].id,);
                        },
                        separatorBuilder: (context, int index) {
                          return const SizedBox(height: 20);
                        },
                      ),
                    )
                  );
                } else if (snapshot.hasError){
                  return Text('${snapshot.error}');
                }
                return Center(
                    child: SizedBox(
                      width: 328,
                      child: ListView.separated(
                        itemCount: 4,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return const ShimmerProdutoHorizontal();
                        },
                        separatorBuilder: (context, int index) {
                          return const SizedBox(height: 20);
                        },
                      ),
                    )
                );
              },
            ),
            const SizedBox(height: 15),
          ],
        )
    );
  }
}
