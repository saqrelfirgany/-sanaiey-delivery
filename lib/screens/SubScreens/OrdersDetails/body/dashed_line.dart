
import 'package:flutter/material.dart';
import 'package:sanaiey/screens/MainScreens/CartScreen/body/single_dot.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .8,
//            height:isLandscape(context)
//                ? 2*height*.08: height*.08,
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
