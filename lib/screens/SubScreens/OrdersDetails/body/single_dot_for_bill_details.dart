
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';

class SingleDotForBillDetails extends StatelessWidget {
  const SingleDotForBillDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: 1,
      decoration: const BoxDecoration(color: greyColor),
    );
  }
}
