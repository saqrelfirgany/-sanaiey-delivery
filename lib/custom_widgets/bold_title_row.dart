
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/utils/responsive.dart';

import 'custom_text.dart';

class TitleRow extends StatelessWidget {
  final String text;
  const TitleRow({Key? key, this.text: ""}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * .9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              percentageOfHeight: .02,
              text: text,
              textColor: blackColor,
              fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}
