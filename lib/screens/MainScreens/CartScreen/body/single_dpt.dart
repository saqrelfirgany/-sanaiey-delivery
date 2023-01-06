
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';

class SingleDot extends StatelessWidget {
  const SingleDot();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: 1,
      decoration: const BoxDecoration(color: greyColor),
    );
  }
}
