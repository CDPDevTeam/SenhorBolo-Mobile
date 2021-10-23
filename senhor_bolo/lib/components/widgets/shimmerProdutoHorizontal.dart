import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerProdutoHorizontal extends StatelessWidget {
  const ShimmerProdutoHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 328,
      height: 118,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Shimmer(
            child: Container(
              width: 138,
              height: 118,
              decoration: const BoxDecoration(
                color: Color(0xffE8E8E8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
         ),
         Container(
            width: 190,
            height: 98,
            padding: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
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
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
