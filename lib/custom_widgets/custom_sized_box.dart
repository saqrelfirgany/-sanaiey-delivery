
import 'package:flutter/material.dart';
import 'package:sanaiey/utils/responsive.dart';

class CustomSizedBox extends StatelessWidget {
  final double percentageOfHeight;
  const CustomSizedBox({Key? key, this.percentageOfHeight: .01})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: isLandscape(context)
            ? 2 * height(context) * percentageOfHeight
            : height(context) * percentageOfHeight);
  }
}
