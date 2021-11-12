import 'package:flutter/material.dart';
import '../../constants.dart';

class TextAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;

  const TextAppBar({Key? key,
    required this.title}) : super(key: key);

  @override
  Size get preferredSize => new Size.fromHeight(88);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 88,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25))),
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.keyboard_arrow_left,
          size: 50,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
            color: mainTextColor,
            fontSize: 25,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
