
import 'package:flutter/material.dart';
import 'package:sanaiey/utils/responsive.dart';

class OrderImage extends StatelessWidget {
  const OrderImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isLandscape(context)
          ? 2 * height(context) * .25
          : height(context) * .25,
      width: width(context),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/delivery_man1.png"))),
    );
  }
}
