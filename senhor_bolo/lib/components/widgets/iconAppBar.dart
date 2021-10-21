import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class IconAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String appBarText;
  final IconData appBarIcon;

  const IconAppBar({Key? key, required this.appBarText, required this.appBarIcon}) : super(key: key);

  @override
  Size get preferredSize => new Size.fromHeight(160);

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
                        color: Colors.white
                    ),
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
                      imageUrl: 'https://thespacefox.github.io/SenhorBolo-Imagens/images/usuario/ricardinho_betoneira.jpeg',
                      imageBuilder: (context, imageProvider) => Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fitWidth)),
                      )
                  )
              )
          )
        ],
        bottom: PreferredSize(
          //Exigido por causa do null safety, mas aqui não faz diferença
          preferredSize: Size.fromHeight(0),
          child: Container(
              width: double.infinity,
              height: 70,
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      appBarIcon,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(width: 5),
                    Text(
                      appBarText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: mainTextColor
                      ),
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
