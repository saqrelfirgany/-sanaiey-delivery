
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/utils/responsive.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double percentageOfHeight;
  final Color textColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final decoration;
  final FontStyle fontStyle;
  final int maxLines;
  final double textHeight;
  const CustomText(
      {Key? key,
      this.text: "text",
      this.percentageOfHeight: .019,
      this.textColor: mainColor,
      this.fontWeight: FontWeight.normal,
      this.textAlign: TextAlign.center,
      this.decoration,
      this.fontStyle: FontStyle.normal,
      this.maxLines: 1,
      this.textHeight: 1.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      translator.translate(text),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          height: textHeight,
          fontStyle: fontStyle,
          fontFamily: "sanaiey",
          decoration: decoration,
          fontWeight: fontWeight,
          color: textColor,
          fontSize: isLandscape(context)
              ? 2 * height(context) * percentageOfHeight
              : height(context) * percentageOfHeight),
    );
  }
}
