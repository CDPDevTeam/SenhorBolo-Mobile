import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/iconAppBar.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IconAppBar(appBarIcon: Icons.info, appBarText: 'Sobre nós',),
    );
  }
}
