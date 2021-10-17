import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../searchResult.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String searchText;

  const SearchAppBar({
    Key? key,
    required this.searchText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(160),
      child: AppBar(
        elevation: 0,
        toolbarHeight: 88,
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
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
                  Text(
                    'Entregar em',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'Rua Humaitá, 538',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        color: Colors.white),
                  ),
                ],
              ),
              Icon(
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
                          'https://thespacefox.github.io/SenhorBolo-Imagens/images/usuario/ricardinho_betoneira.jpeg',
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
                controller: TextEditingController(text: searchText),
                textInputAction: TextInputAction.go,
                onSubmitted: (searchText){
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => SearchResult(searchText: searchText,)));
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    hintText: 'Bolo de miiiiiiiiiiiiiiiiiiiiiiiilhooo',
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
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    )),
              )),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(160);
}
