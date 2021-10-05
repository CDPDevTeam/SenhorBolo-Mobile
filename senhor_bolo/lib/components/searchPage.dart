import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/searchResult.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 88,
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back),
            iconSize: 30,
            color: Colors.white,
          ),
          title: SizedBox(
            width: screenSize.width * 0.66,
            height: screenSize.height * 0.05,
            child: Hero(
              tag: 'searchBar',
              child: TextField(
                controller: searchText,
                onSubmitted: (searchText){
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => SearchResult(searchText: searchText,)));
                },
                textInputAction: TextInputAction.go,
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  hintText: 'Pesquisa',
                  filled: true,
                  fillColor: Color(0xffE6E6E6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffB5B5B5)),
                ),
              ),
            ),
          ),
          actions: <IconButton>[
            IconButton(
              onPressed: () => searchText.clear(),
              icon: Icon(Icons.clear),
              iconSize: 30,
              color: Colors.white,
            )
          ],
        ));
  }
}