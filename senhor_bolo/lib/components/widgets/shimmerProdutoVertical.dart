import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

Widget shimmerProdutoVertical(){
  return Container(
    width: 176,
    height: 227,
    child: Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          width: 176,
          height: 220,
          padding: const EdgeInsets.only(top: 160, left: 22),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Shimmer(
                child: Container(
                  width: 100,
                  height: 15,
                  color: Color(0xFFF4F4F4),
                ),
              ),
              Shimmer(
                child: Container(
                  width: 60,
                  height: 8,
                  color: Color(0xFFF4F4F4),
                ),
              ),
              Shimmer(
                child: Container(
                  width: 80,
                  height: 10,
                  color: Color(0xFFF4F4F4),
                ),
              ),
              const SizedBox(height: 5)
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Shimmer(
            interval: Duration(seconds: 2),
            child: Container(
              width: 161,
              height: 161,
              decoration: BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        )
      ],
    ),
  );
}