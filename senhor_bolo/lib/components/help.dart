import 'package:flutter/material.dart';
import 'package:senhor_bolo/components/widgets/iconAppBar.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IconAppBar(appBarIcon: Icons.help, appBarText: 'Ajuda')
    );
  }
}
