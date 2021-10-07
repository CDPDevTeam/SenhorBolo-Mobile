import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class TestAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TestAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('AppBar feita');
    return PreferredSize(
      preferredSize: Size.fromHeight(88),
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
        title: GestureDetector(
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
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'searchPage'),
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          ),
          Badge(
            position: BadgePosition.topEnd(top: 18, end: 6),
            badgeContent: Text(
              '1',
              style: TextStyle(color: textMainColor, fontFamily: 'Roboto'),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(88);
}
