import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/produtoVertical.dart';
import 'package:senhor_bolo/components/widgets/shimmerProdutoHorizontal.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../constants.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
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
              Icons.help,
              color: Colors.white,
              size: 35,
            ),
            SizedBox(width: 10),
            Text(
              'Ajuda',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: mainTextColor
              ),
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          const ShimmerProdutoHorizontal()
      ],
      ),
    );
  }
}
