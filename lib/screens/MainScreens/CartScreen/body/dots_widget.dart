
import 'package:flutter/material.dart';
import 'package:sanaiey/screens/MainScreens/CartScreen/body/single_dot.dart';
import 'package:sanaiey/utils/responsive.dart';

class DotsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * .5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SingleDot(),
          SingleDot(),
          SingleDot(),
          SingleDot(),
          SingleDot(),
          SingleDot(),
          SingleDot(),
          SingleDot(),
          SingleDot(),
          SingleDot(),
          SingleDot(),
          SingleDot(),
          SingleDot(),
          SingleDot(),
          SingleDot(),
        ],
      ),
    );
  }
}
