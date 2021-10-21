import "package:flutter/material.dart";
import 'package:senhor_bolo/components/widgets/simpleButton.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({Key? key}) : super(key: key);

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.20),
        child: Container(
          decoration: BoxDecoration(
          ),
          padding: EdgeInsets.all(20),
          child: SafeArea(
            top: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconSize: 40,
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back_ios)),

              ],
            ),
          )
        ),
        ),
      body: Center(
       child: Hero(
         tag: 'ImageViewer',
         child: Image.asset("images/davi.png", ),
       ),
      ),
    bottomSheet: Container(
      width: double.infinity,
      color: Colors.black,
      child: simpleButtonIconeOnly(200, 50, (){}, 25, 20, Colors.red, Icon(Icons.delete), FontWeight.normal),
    ),
    );
  }
}
