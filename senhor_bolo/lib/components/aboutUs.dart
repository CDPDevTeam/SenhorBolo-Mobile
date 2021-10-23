import 'package:flutter/material.dart';
import '../constants.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      title: Wrap(
        children: [
          Icon(
            Icons.info,
            color: Colors.white,
            size: 35,
          ),
          SizedBox(width: 10),
          Text(
            'Sobre nós',
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
    );
  }
}
