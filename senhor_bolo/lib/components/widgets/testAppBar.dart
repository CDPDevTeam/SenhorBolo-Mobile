import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/classes/shoppingCart.dart';
import '../../constants.dart';

class TestAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TestAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(88),
      child: AppBar(
        elevation: 0,
        toolbarHeight: 88,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
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
                  const Text(
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
              const Icon(
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
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          ),
          Badge(
            position: BadgePosition.topEnd(top: 18, end: 6),
            badgeContent: Text(
              ShoppingCart.cartItens.length.toString(),
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
