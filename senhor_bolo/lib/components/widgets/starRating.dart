import "package:flutter/material.dart";
import 'package:senhor_bolo/constants.dart';

class Rating extends StatefulWidget {
  final int maxRating;
  final Function(int) onRatingSelected;

  Rating(this.onRatingSelected, [this.maxRating = 5]);

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {

  int _currentRating = 0;
  Widget _buildRatingStar(int index){
    final starIconFull = Icon(Icons.star, size: 50,color: Colors.amber,);
    final starIconNot = Icon(Icons.star_border_outlined, size: 50,);
    final starText = Text("$_currentRating/5");
    if(index < _currentRating){
      return starIconFull;
    } else {
      return starIconNot;}
  }

  Widget _buildBody(){
    final stars = List.generate(this.widget.maxRating, (index) {
      return GestureDetector(
        child: _buildRatingStar(index),
        onTap: (){
          setState(() {
            _currentRating = index + 1;
          });
          this.widget.onRatingSelected(_currentRating);
        },
      );
    });
    return Row(
      children: stars,
      mainAxisAlignment: MainAxisAlignment.center ,
    );

  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
