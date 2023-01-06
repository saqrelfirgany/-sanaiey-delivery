
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';

class SingleDot extends StatelessWidget {
  const SingleDot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 1.5,
      width: 3,
      decoration: const BoxDecoration(color: greyColor),
    );
  }
}
